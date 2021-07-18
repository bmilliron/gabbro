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


use warnings;
use strict;

use XML::RSS::Parser::Lite;
use LWP::Protocol::https;
use LWP::Simple;
require "/home/pak/Dropbox/code/gabbro/Db/DbOps.pm";
require "/home/pak/Dropbox/code/gabbro/File/FileOps.pm";

#Connect to the database
my $conn = DbOps::connect();

my $rss1 = "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml";
#print($rss1);

#print($xml);

#Get config
my $configSettings = FileOps::get_config();

#Feed worker 
my $rp = new XML::RSS::Parser::Lite;

#Process feeds

#Delete table
DbOps::delete_link_table();

foreach my $section (keys %{$configSettings}) {
    print "[$section] \n";
    foreach my $parameter (keys %{$configSettings->{$section}}) {
        my $feedUrl = $configSettings->{$section}->{$parameter};
        
        #Parse feed
        my $feed = get($feedUrl);
        $rp->parse($feed);
        
        #Process feed
        for (my $i = 0; $i < $rp->count(); $i++) {
            my $it = $rp->get($i);
            print $it->get('title') . " " . $it->get('url')."\n";
        
            #some RSSv2.0 optional parameters may have been set:
        
            if (defined $it->get('pubDate')) { 
        	print "publication date found: " . $it->get('pubDate')."\n";
        	#Insert feed
            	DbOps::insert_feed($conn,$section,$it->get('url'),$it->get('pubDate'),$it->get('title'));
            }
        

    	}
    }
}	




