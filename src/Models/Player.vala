/* Player.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace TicTacToe {
    public class Player : Object {
        public string name { get; set; }
        public string text { get; set; }
        public string color { get; set; }
        public int wins { get; set; default = 0; }
        public bool on_turn { get; set; }

        public Player (string t, string c) {
            Object (
                text: t,
                color: c
            );
        }
    }
}
