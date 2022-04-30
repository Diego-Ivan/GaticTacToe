/* WinnerPage.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace TicTacToe {
    [GtkTemplate (ui = "/io/github/diegoivan/TicTacToe/ui/WinnerPage.ui")]
    public class WinnerPage : Gtk.Box {
        [GtkChild]
        private unowned Gtk.Label winner_label;

        public Player? winner {
            set {
                if (value == null) {
                    winner_label.label = _("It's a tie!");
                    label_provider.load_from_data ((uint8[]) "* {color: @theme_text_color;}");
                    return;
                }
                winner_label.label = value.name;
                label_provider.load_from_data ((uint8[]) "* {color: %s;}".printf (value.color));
            }
        }

        private Gtk.CssProvider label_provider = new Gtk.CssProvider ();

        public WinnerPage () {
        }

        construct {
            winner_label.get_style_context ().add_provider (label_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        }
    }
}
