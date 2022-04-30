/* GridElement.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace GaticTacToe {
    public class GridElement : Adw.Bin {
        /* Properties */
        public uint row { get; construct; }
        public uint column { get; construct; }
        public bool empty {
            get {
                return element == null;
            }
        }

        private Player? _element;
        public Player? element {
            get {
                return _element;
            }
            set {
                _element = value;
                if (value == null) {
                    item_animation.reverse = true;
                    item_animation.play ();
                    provider.load_from_data ((uint8[]) "* {color: @borders;}");
                    return;
                }

                item.label = value.text;
                provider.load_from_data ((uint8[]) "* {color: %s;}".printf (value.color));

                item_animation.reverse = false;
                item_animation.play ();
            }
        }

        /* Signals */
        public signal void element_selected (GridElement element);

        /* Fields */
        private Gtk.CssProvider provider = new Gtk.CssProvider ();
        private Gtk.Label item = new Gtk.Label ("");
        private Adw.TimedAnimation item_animation;

        /* Constructors */
        public GridElement (uint r, uint c) {
            Object (
                row: r,
                column: c
            );
        }

        class construct {
            set_css_name ("gridelement");
        }

        construct {
            child = item;
            item.opacity = 0;

            get_style_context ().add_provider (provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            add_css_class ("background");

            var controller = new Gtk.GestureClick ();
            controller.released.connect (on_controller_released);
            add_controller (controller);

            var animation_target = new Adw.CallbackAnimationTarget (on_item_revealed);
            item_animation = new Adw.TimedAnimation (item, 0, 1, 150, animation_target);
            item_animation.easing = EASE_IN_OUT_SINE;
        }

        /* Methods */
        private void on_controller_released () {
            if (empty == false)
                return;

            element_selected (this);
        }

        private void on_item_revealed (double v) {
            item.opacity = v;
        }
    }
}
