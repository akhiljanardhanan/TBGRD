#!/usr/bin/perl 
use DBI;
use CGI;
my $cgi = new CGI;
# output the content-type so the web server knows
print $cgi->header;
print $cgi->start_html(-style=>{src=>'http://18.118.207.180/my2.css'});
print<<HTML;
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		body {font-family: "Times New Roman", Georgia, Serif;}
		h1,h2,h3,h4,h5,h6 {font-family: "Playfair Display";letter-spacing: 5px;}
	</style>
		
	<table class='w3-table w3-striped w3-bordered'>
		<tr>
			<th>Name</th>
			<th>Type</th>
			<th>Organism</th>
			<th>Details</th>
			<th>Weblink</th>
		</tr>
HTML

my $dbh = DBI->connect("DBI:mysql:tb",'root','') or die "DBI failed,$!";
my $sth = $dbh->prepare('SELECT * FROM tools');
$sth->execute;

while (my @row = $sth->fetchrow_array){
print<<HTML2
	<tr>
		<td><a href='$row[4]' target='_blank'>$row[0]</a></td>
		<td>$row[1]</td>
		<td>$row[2]</td>
		<td>$row[3]</td>
		<td><a href='$row[4]' target='_blank'>Link</a></td>
	</tr>
HTML2
}
print"</table>";
$sth->finish();
$dbh->disconnect();
print "</body></html>";
