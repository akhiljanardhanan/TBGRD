#!/usr/bin/perl 
use DBI;
use CGI;
#my $search = param('search');
my $cgi = new CGI;
# output the content-type so the web server knows
print $cgi->header;
print $cgi->start_html(-style=>{src=>'http://tbgrd.co.in/my2.css'});
print<<HTML;
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="keywords" content="" />
	<link rel='shortcut icon' type='image/png' href=''><!--SHORT ICON-->
	<title>XYZ</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="/home/ubuntu/html/my.css">
	<style>
		body {font-family: "Times New Roman", Georgia, Serif;}
		h1,h2,h3,h4,h5,h6 {font-family: "Playfair Display";letter-spacing: 5px;}
	</style>
	<body id="myPage">
	<!-- Navbar (sit on top) -->
	<div class="w3-top">
		<div class="w3-bar" id="myNavbar">
			<a class="w3-bar-item w3-button w3-hover-black w3-hide-medium w3-hide-large w3-right" href="javascript:void(0);" onclick="toggleFunction()" title="Toggle Navigation Menu">
				<i class="fa fa-bars"></i>
			</a>
			<a href="http://tbgrd.co.in/" class="w3-bar-item w3-button">TBGRD</a><!--LOGO-->
			<div class= "w3-right">
				<a href="http://tbgrd.co.in/cgi-bin/action_page.pl" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Database</a>
				<a href="https://www.who.int/health-topics/tuberculosis#tab=tab_1" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Tuberculosis</a>
				<!--a href="#databases" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Other sources</a-->
			</div>
		</div>

	<!-- Navbar on small screens -->
		<div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium">
			<a href="http://tbgrd.co.in/cgi-bin/action_page.pl" class="w3-bar-item w3-button">Database</a>			
			<a href="https://www.who.int/health-topics/tuberculosis#tab=tab_1" class="w3-bar-item w3-button">Tuberculosis</a>			
			<!--a href="#databases" class="w3-bar-item w3-button">Other sources</a-->
		</div>
	</div>
	<div class="w3-content w3-container w3-padding-32" id="result">
	<table class='w3-table w3-striped w3-bordered'>
		<tr>
			<th>ID</th>
			<th>Class</th>
			<th>Factor</th>
			<th>Factor Name</th>
			<th>Organism (Host/Parasite)</th>
			<th>Role of factor</th>
			<th>Mechanism</th>
			<th>Drug Target</th>
			<th>PMID</th>
		</tr>
HTML

my $dbh = DBI->connect("DBI:mysql:tb",'root','') or die "DBI failed,$!";
my $sth = $dbh->prepare("SELECT * FROM data");# WHERE ID LIKE '%01%'");
$sth->execute;

while (my @row = $sth->fetchrow_array){
print<<HTML2
	<tr>
		<td>$row[0]</td>
		<td>$row[1]</td>
		<td>$row[2]</td>
		<td>$row[3]</td>
		<td>$row[4]</td>
		<td>$row[5]</td>
		<td>$row[6]</td>
		<td>$row[7]</td>
		<td><a href='https://pubmed.ncbi.nlm.nih.gov/$row[8]/' target='_blank'>$row[8]</a></td>
	</tr>
	
HTML2
}
print"</table></div>";
$sth->finish();
$dbh->disconnect();
print<<SCRIPT;
<script>
// Change style of navbar on scroll
window.onscroll = function() {myFunction()};
function myFunction() {
    var navbar = document.getElementById("myNavbar");
    if (document.body.scrollTop > 30 || document.documentElement.scrollTop > 30) {
        navbar.className = "w3-bar" + " w3-card" + " w3-white";
    } else {
        navbar.className = navbar.className.replace(" w3-card w3-white", "");
    }
}

// Used to toggle the menu on small screens when clicking on the menu button
function toggleFunction() {
    var x = document.getElementById("navDemo");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}
</script>
SCRIPT
print "</body></html>";
