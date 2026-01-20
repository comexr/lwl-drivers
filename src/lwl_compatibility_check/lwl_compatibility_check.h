/* SPDX-License-Identifier: GPL-2.0+ */
/*!
 * Copyright (c) 2023 lwl Computers GmbH <tux@lwlcomputers.com>
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

#ifndef lwl_COMPATIBILITY_CHECK_H
#define lwl_COMPATIBILITY_CHECK_H

#include <linux/kernel.h>

bool lwl_is_compatible(void);

#endif // lwl_COMPATIBILITY_CHECK_H
