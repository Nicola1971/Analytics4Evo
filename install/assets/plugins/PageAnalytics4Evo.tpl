/**
 * PageAnalytics4Evo
 *
 * Resource Page Google Analytics for Evolution
 *
 * @category	plugin
 * @version     beta 0.1
 * @author      Author: Nicola Lambathakis http://www.tattoocms.it/
 * @internal    @events OnDocFormRender
 * @internal	@modx_category Analytics
 * @internal    @properties &IDclient=ID client:;string;;;application ID client &ids=ids:;string;;;Table ID (ids) &cms=cms:;list;modxevo,evolution;evolution
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 */

if(!defined('MODX_BASE_PATH')){die('What are you doing? Get out of here!');}

// get global language
global $modx,$_lang;
$id = isset($_REQUEST['id']) ? intval($_REQUEST['id']) : 0;
$url = $modx->makeUrl($id, '', '', '');
$e = &$modx->Event;
$output ='';
switch($e->name) {
case 'OnDocFormRender':

$output ="";
if ($cms == 'evolution') { 
$output .="<link type=\"text/css\" rel=\"stylesheet\" href=\"media/style/".$modx->config['manager_theme']."/style.css\">";  
}
else { 
$output .="<link type=\"text/css\" rel=\"stylesheet\" href=\"../assets/modules/analytics4evo/12/default/style.css\">";  
$output .="	<style>.gapi-analytics-data-chart .gapi-analytics-data-chart-styles-table-th  {background:#FFF!important;}</style>";  
}
$output .="
<div class=\"tab-page\" id=\"tabAnalytics\">
<h2 class=\"tab\">Analytics</h2>
<style>
div#active-users, div#month-users {color:#499bea;display:block;margin:0;font-size:1.4rem;min-height:18px;text-align:center;vertical-align:middle;}
div#active-users .ActiveUsers-value, div#month-users h1 {display:block; margin-top:14px; font-size: 5rem !important; font-weight:normal!important;}
.container {padding-top:30px;}
.google-visualization-table-page-numbers a, .google-visualization-table-page-numbers a.current, .google-visualization-table-page-next, .google-visualization-table-page-prev {padding:0 6px;font-size:1.2em;text-decoration:none;box-shadow:0;background:none!important;border:1px solid #dedede;color:#595959}
.google-visualization-table-page-next, .google-visualization-table-page-prev {height:25px;background:none!important;border:1px solid #dedede;color:#595959;background-image:none!important;}
.google-visualization-table-page-numbers a:hover{text-decoration:none;box-shadow:0!important;border:1px solid #499bea;}
.google-visualization-table-div-page.gradient {background:transparent; padding-top:10px;}
.gapi-analytics-data-chart {width:100%!important;}
</style>
<!-- Create the containing elements. -->
<h1><i class=\"fa fa-bar-chart\" aria-hidden=\"true\"></i> Page Analytics for <small>$url</small> </h1>
<div style=\"position:absolute;top:25px;right:35px;z-index:10;\" id=\"auth-button\"></div>

<div class=\"container\">
<div class=\"col-md-9\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Sessions </div> 
<div class=\"card-block\">
  <div id=\"widgetSessions\"></div>	
</div></div></div>

<div class=\"col-md-3\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Right now </div> 
<div class=\"card-block\">
<div id=\"active-users\"></div>	
</div></div>
<div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Last 30 Days</div> 
<div class=\"card-block\">
  <div id=\"month-users\"></div>
</div></div>
</div>

<div class=\"col-md-12\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Visitors </div> 
<div class=\"card-block\">
  <div id=\"widgetVisitors\"></div>	
</div></div></div>

<div class=\"col-md-6\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Previous Page </div> 
<div class=\"card-block\">
  <div id=\"widgetPrevPage\"></div>	
</div></div></div>

<div class=\"col-md-6\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Users </div> 
<div class=\"card-block\">
  <div id=\"usersType\"></div>	
</div></div></div>
<div class=\"clearfix\"></div>

<div class=\"col-md-6\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Keywords </div> 
<div class=\"card-block\">
  <div id=\"widgetKeywords\"></div>	
</div></div></div>

<div class=\"col-md-6\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Referrers </div> 
<div class=\"card-block\">
  <div id=\"widgetReferres\"></div>	
</div></div></div>

</div>
<div class=\"buttonConfig pull-right\" style=\"margin-right:8px;\">
'.$button_config.'
</div>
</div>

<!-- Load the library. -->
<script>
(function(w,d,s,g,js,fjs){
  g=w.gapi||(w.gapi={});g.analytics={q:[],ready:function(cb){this.q.push(cb)}};
  js=d.createElement(s);fjs=d.getElementsByTagName(s)[0];
  js.src='https://apis.google.com/js/platform.js';
  fjs.parentNode.insertBefore(js,fjs);js.onload=function(){g.load('analytics')};
}(window,document,'script'));
</script>
<script src=\"../assets/modules/analytics4evo/moment.min.js\"></script>
<script src=\"../assets/modules/analytics4evo/active-users.js\"></script>
";  

$output .="
<script>
gapi.analytics.ready(function() {
  // Authorize the user.
  var CLIENT_ID =  '$IDclient';
  gapi.analytics.auth.authorize({
    container: 'auth-button',
    clientid: CLIENT_ID,
    userInfoLabel:\"\"
  });
 var activeUsers = new gapi.analytics.ext.ActiveUsers({
    container: 'active-users',
	filters: 'ga:pagePath==$url',
	template: '<div class=\"ActiveUsers\">' + 'Right Now: <br/><h1><b class=\"ActiveUsers-value\"></b></h1>' +  '</div>',
    pollingInterval: 5,
	'ids': \"$ids\"
  });

var monthUsers = new gapi.analytics.report.Data({
 query: {
  'ids': \"$ids\",
  'filters': 'ga:pagePath==$url',
  'metrics': 'ga:users',
  'start-date': '30daysAgo',
  'end-date': 'yesterday'
}
 });
monthUsers.on('success', function(monthUsers) {
for (var prop in monthUsers) {
      var outputDiv = document.getElementById('month-users');
      outputDiv.innerHTML = 'Users: ' + '<h1>' + monthUsers[prop] +  '</h1>';  
	  }
	console.log(monthUsers);
});

  // widgetSessions: Create the timeline chart.
  var widgetSessions = new gapi.analytics.googleCharts.DataChart({
    reportType: 'ga',
    query: {
      'dimensions': 'ga:date',
      'metrics': 'ga:sessions',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
	  'max-results': 30,
	  'filters': 'ga:pagePath==$url',
     'ids': \"$ids\"
    },
    chart: {
      type: 'LINE',
      container: 'widgetSessions',
      options: {
        width: '100%'
      }
    }
  }); 
       // widgetVisitors: Visitors.
  var widgetVisitors = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:users,ga:pageviews,ga:timeOnPage',
      dimensions: 'ga:date',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 30,
	  'filters': 'ga:pagePath==$url',
      sort: '-ga:date',
     'ids': \"$ids\"
    },
    chart: {
      type: 'TABLE',
      container: 'widgetVisitors',
      options: {
        width: '100%',
		page: 'enable',
		pageSize: '10'
      }
    }
  }); 
     // widgetKeywords: Keywords.
  var widgetKeywords = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:sessions',
      dimensions: 'ga:keyword',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 30,
	  'filters': 'ga:pagePath==$url',
      sort: '-ga:sessions',
     'ids': \"$ids\"
    },
    chart: {
      type: 'TABLE',
      container: 'widgetKeywords',
      options: {
        width: '100%',
		page: 'enable',
		pageSize: '10'
      }
    }
  });
     // widgetReferres: Referres.
  var widgetReferres = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:sessions',
      dimensions: 'ga:fullReferrer',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 30,
	  'filters': 'ga:medium==referral',
	  'segment': 'users::condition::ga:pagePath==$url',
      sort: '-ga:sessions',
     'ids': \"$ids\"
    },
    chart: {
      type: 'TABLE',
      container: 'widgetReferres',
      options: {
        width: '100%',
		page: 'enable',
		pageSize: '10'
      }
    }
  });
      // widgetPrevPage: widgetPrevPage.
  var widgetPrevPage = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:users',
      dimensions: 'ga:previousPagePath',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 30,
	  'filters': 'ga:pagePath==$url',
      sort: '-ga:users',
     'ids': \"$ids\"
    },
    chart: {
      type: 'TABLE',
      container: 'widgetPrevPage',
      options: {
        width: '100%',
		page: 'enable',
		pageSize: '10'
      }
    }
  });

  //usersType
    var usersType = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:sessions',
      dimensions: 'ga:userType',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 10,
	  'filters': 'ga:pagePath==$url',
      sort: '-ga:sessions',
     'ids': \"$ids\"
    },
    chart: {
      container: 'usersType',
      type: 'PIE',
      options: {
        width: '100%',
        pieHole: 4/9
      }
    }
  });
  gapi.analytics.auth.on('success', function(response) {
    //hide the auth-button
    document.querySelector(\"#auth-button\").style.display='none';  
    widgetSessions.execute();
	widgetVisitors.execute();
	usersType.execute();
	widgetKeywords.execute();
	widgetReferres.execute();
	widgetPrevPage.execute();
	monthUsers.execute();
	activeUsers.execute();
  });

});
</script>
";  
$output .="
</div></div>";
    break;
}
$e->output($output);
return;