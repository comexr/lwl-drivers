/* SPDX-License-Identifier: GPL-2.0+ */
/*!
 * Copyright (c) 2023-2024 TUXEDO Computers GmbH <tux@tuxedocomputers.com>
 *
 * This file is part of lwl-drivers.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, see <https://www.gnu.org/licenses/>.
 */

#ifndef lwl_NB05_POWER_PROFILES_H
#define lwl_NB05_POWER_PROFILES_H
void rewrite_last_profile(void);
bool profile_changed_by_driver(void);
#endif
