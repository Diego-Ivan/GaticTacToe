/* Counter.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace TicTacToe {
    [GtkTemplate (ui = "/io/github/diegoivan/TicTacToe/ui/Counter.ui")]
    public class Counter : Gtk.Box {
        [GtkChild]
        private unowned Gtk.Label name_label;
        [GtkChild]
        private unowned Gtk.Label counter_label;

        public Player player {
            set {
                name_label.label = value.name;
                value.bind_property ("wins",
                    this, "counter"
                );
                value.bind_property ("on_turn",
                    this, "on_turn"
                );
                counter_provider.load_from_data ((uint8[]) "* {color: %s;}".printf (value.color));
            }
        }

        public string player_name {
            get {
                return name_label.label;
            }
            set {
                name_label.label = value;
            }
        }

        public int counter {
            set {
                counter_label.label = value.to_string ();
            }
        }

        public bool on_turn {
            set {
                if (value) {
                    name_provider.load_from_data ((uint8[]) "* {font-weight: 800;}");
                }
                else {
                    name_provider.load_from_data ((uint8[]) "* {font-weight: 400;}");
                }
            }
        }

        private Gtk.CssProvider name_provider = new Gtk.CssProvider ();
        private Gtk.CssProvider counter_provider = new Gtk.CssProvider ();

        public Counter () {
        }

        construct {
            name_label.get_style_context().add_provider (name_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            counter_label.get_style_context().add_provider (counter_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

            counter = 0;
        }
    }
}
