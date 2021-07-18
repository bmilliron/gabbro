#!/usr/bin/perl

#    Gabbro - Perl RSS Aggregation Application for Websites
#    Copyright (C) 2021  Ben Milliron

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>

package FileOps;

use strict;
use warnings;
use Config::Tiny;

my $LEVEL = 1;

sub get_config{
    
    my $config = Config::Tiny->read('/home/pak/Dropbox/code/gabbro/Config/feed1.cfg');
    return $config;

}


