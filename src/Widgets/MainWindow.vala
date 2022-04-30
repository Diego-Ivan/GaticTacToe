/* MainWindow.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace TicTacToe {
    [GtkTemplate (ui = "/io/github/diegoivan/TicTacToe/ui/MainWindow.ui")]
    public class MainWindow : Adw.ApplicationWindow {
        [GtkChild]
        private unowned Gtk.Grid grid;

        [GtkChild]
        private unowned Counter p1_counter;
        [GtkChild]
        private unowned Counter p2_counter;
        [GtkChild]
        private unowned Counter tie_counter;

        private Player player_1;
        private Player player_2;
        private int ties = 0;

        private Player _current_turn;
        public Player current_turn {
            get {
                return _current_turn;
            }
            set {
                _current_turn.on_turn = false;
                _current_turn = value;
                value.on_turn = true;
            }
        }

        private Player? _winner;
        public Player? winner {
            get {
                return _winner;
            }
            set {
                _winner = value;
                if (value == null)
                    return;

                winner.wins++;
            }
        }
        public Player match_starter { get; private set; }

        private uint empty_elements = 9;

        private const ActionEntry[] WIN_ENTRIES = {
            { "start-new-match", start_new_match }
        };

        public MainWindow (Gtk.Application app) {
            Object (
                application: app
            );
        }

        construct {
            remove_css_class ("background");
            add_css_class ("view");

            player_1 = new Player ("X", "@x_color") {
                name = _("Player 1")
            };
            player_2 = new Player ("O", "@o_color") {
                name = _("Player 2")
            };

            p1_counter.player = player_1;
            p2_counter.player = player_2;

            populate_grid ();
            start_new_match ();

            var action_group = new SimpleActionGroup ();
            action_group.add_action_entries (WIN_ENTRIES, this);
            insert_action_group ("win", action_group);
        }

        private void populate_grid () {
            for (int row = 0; row < 3; row++) {
                for (int column = 0; column < 3; column++) {
                    var e = new GridElement (row, column);
                    e.element_selected.connect (on_element_selected);

                    grid.attach (e, column, row);
                }
            }
        }

        private void start_new_match () {
            empty_elements = 9;
            for (int row = 0; row < 3; row++) {
                for (int column = 0; column < 3; column++) {
                    GridElement element = (GridElement) grid.get_child_at (column, row);
                    element.element = null;
                }
            }

            if (winner == null) {
                 if (Random.int_range (1, 2) == 1) {
                    current_turn = player_1;
                 }
                 else {
                    current_turn = player_2;
                 }
                 return;
            }

            if (winner == player_1) {
                current_turn = player_2;
            }
            else {
                current_turn = player_1;
            }
            winner = null;
        }

        private void on_element_selected (GridElement e) {
            if (winner != null) {
                return;
            }
            e.element = current_turn;
            empty_elements--;

            if (check_row (e))
                return;
            if (check_column (e))
                return;
            if (check_right_to_left_diagonal (e))
                return;
            if (check_left_to_right_diagonal (e))
                return;

            if (empty_elements == 0) {
                ties++;
                tie_counter.counter = ties;
                return;
            }

            if (current_turn == player_1) {
                current_turn = player_2;
            }
            else {
                current_turn = player_1;
            }
        }

        private bool check_row (GridElement e) {
            /* Iterate over the element's row to check if it's complete */
            for (int column = 0; column < 3; column++) {
                GridElement element = (GridElement) grid.get_child_at (column, (int) e.row);
                if (element.element == null || element.element != e.element)
                    return false;
            }
            winner = e.element;
            return true;
        }

        private bool check_column (GridElement e) {
            /* Iterate over the element's column to check if it's complete */
            for (int row = 0; row < 3; row++) {
                GridElement element = (GridElement) grid.get_child_at ((int) e.column, row);
                if (element.element == null || element.element != e.element)
                    return false;
            }
            winner = e.element;
            return true;
        }

        private bool check_left_to_right_diagonal (GridElement e) {
            for (int i = 0; i < 3; i++) {
                GridElement element = (GridElement) grid.get_child_at (i, i);
                if (element.element == null || element.element != e.element)
                    return false;
            }
            winner = e.element;
            return true;
        }

        private bool check_right_to_left_diagonal (GridElement e) {
            int row = 2;
            for (int column = 0; column < 3; column++) {
                GridElement element = (GridElement) grid.get_child_at (column, row);
                if (element.element == null || element.element != e.element)
                    return false;
                row--;
            }
            winner = e.element;
            return true;
        }
    }
}
