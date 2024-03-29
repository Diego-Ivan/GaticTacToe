/* Application.vala
 *
 * Copyright 2022-2023 Diego Iván <diegoivan.mae@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace GaticTacToe {
    public class Application : Adw.Application {

        struct AccelEntry {
            string action_name;
            string[] accels;
        }

        static ActionEntry[] ACTION_ENTRIES = {
            { "quit", quit },
            { "about", on_about_action }
        };

        static AccelEntry[] ACCEL_ENTRIES = {
            { "app.quit", {"<Ctrl>q"} },
            { "window.close", {"<Ctrl>w"} }
        };

        public Application () {
            Object (
                flags: ApplicationFlags.FLAGS_NONE,
                application_id: Config.APP_ID
            );
        }

        protected override void startup () {
            base.startup ();

            add_action_entries (ACTION_ENTRIES, this);

            foreach (var accel in ACCEL_ENTRIES)
                set_accels_for_action (accel.action_name, accel.accels);
        }

        protected override void activate () {
            var win = get_active_window ();
            if (win == null) {
                win = new GaticTacToe.MainWindow (this);
            }
            win.present ();
        }

        private void on_about_action () {
            const string? COPYRIGHT = "Copyright \xc2\xa9 Diego Iván";

            const string? AUTHORS[] = {
                "Diego Iván<diegoivan.mae@gmail.com>",
                null
            };

            var about = new Adw.AboutWindow () {
                application_icon = Config.APP_ID,
                application_name = "GaticTacToe",
                copyright = COPYRIGHT,
                developer_name = "Diego Iván",
                developers = AUTHORS,
                license_type = GPL_3_0,
                transient_for = this.active_window,
                // translators: Write your name<email> here :D
                translator_credits = _("translator_credits"),
                version = Config.VERSION,
            };
            about.present ();
        }

        static int main (string[] args) {
            Intl.bindtextdomain (
                Config.GETTEXT_PACKAGE,
                Config.GNOMELOCALEDIR
            );
            Intl.bind_textdomain_codeset (
                Config.GETTEXT_PACKAGE,
                Config.GNOMELOCALEDIR
            );
            Intl.textdomain (Config.GETTEXT_PACKAGE);

            return new GaticTacToe.Application ().run (args);
        }
    }
}
