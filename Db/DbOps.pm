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

package DbOps;

use DBI;
use strict;
use warnings;

my $LEVEL = 1;

sub connect{

    my $driver   = "SQLite"; 
    my $database = "gabbro.db";
    my $dsn = "DBI:$driver:dbname=$database";
    my $userid = "";
    my $password = "";
    my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) 
        or die $DBI::errstr;

    print "Opened database successfully\n";
    
    return $dbh;

}

sub delete_link_table{

    my $conn = &connect();

    #Truncate the table
    my $truncateData = $conn->prepare("DELETE FROM NewsLinks");
    $truncateData->execute();

}

sub insert_feed{
    my ($conn,$linkCat, $linkUrl, $linkDate, $articleTitle) = @_;
    
    #Insert the feed
    my $insertFeedData = $conn->prepare("INSERT INTO NewsLinks (linkCat,linkUrl,linkDate,articleTitle) VALUES (?,?,?,?)");
    $insertFeedData->bind_param(1,$linkCat);
    $insertFeedData->bind_param(2,$linkUrl);
    $insertFeedData->bind_param(3,$linkDate);
    $insertFeedData->bind_param(4,$articleTitle);
    $insertFeedData->execute();
    

}

sub truncate_feed_table{

    my $conn = &connect();
    
    
}






