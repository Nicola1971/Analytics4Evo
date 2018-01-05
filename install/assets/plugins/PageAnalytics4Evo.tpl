/**
 * PageAnalytics4Evo
 *
 * Resource Page Google Analytics for Evolution
 *
 * @author      Author: Nicola Lambathakis http://www.tattoocms.it/
 * @category	plugin
 * @version     beta 0.1
 * @internal    @events OnDocFormRender
 * @internal	@modx_category Analytics
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @properties &wdgVisibility=Show Analytics tab for:;menu;All,AdminOnly,AdminExcluded,ThisRoleOnly,ThisUserOnly;All &ThisRole=Show only for this role:;string;;;(role id) &ThisUser=Show only for this user:;string;;;(username) &IDclient=ID client:;string;;;application ID client &ids=ids:;string;;;Table ID (ids) &sess_metrics=Session/Users Chart metrics:;list;sessions,users;sessions &sess_time=Session/Users time period:;list;30daysAgo,14daysAgo,7daysAgo;30daysAgo &cms=cms:;list;modxevo,evolution;evolution
 * @internal @installset base, sample
 * @internal    @disabled 0
 * @reportissues https://github.com/Nicola1971/Analytics4Evo/issues
 * @lastupdate  05-01-2017
 */

// get manager role
$internalKey = $modx->getLoginUserID();
$sid = $modx->sid;
$role = $_SESSION['mgrRole'];
$user = $_SESSION['mgrShortname'];
// show widget only to Admin role 1
if(($role!=1) AND ($wdgVisibility == 'AdminOnly')) {}
// show widget to all manager users excluded Admin role 1
else if(($role==1) AND ($wdgVisibility == 'AdminExcluded')) {}
// show widget only to "this" role id
else if(($role!=$ThisRole) AND ($wdgVisibility == 'ThisRoleOnly')) {}
// show widget only to "this" username
else if(($user!=$ThisUser) AND ($wdgVisibility == 'ThisUserOnly')) {}
else {
// get global language
global $modx,$_lang;
$id = isset($_REQUEST['id']) ? intval($_REQUEST['id']) : 0;
$url = $modx->makeUrl($id, '', '', '');
$e = &$modx->Event;
$output ='';
switch($e->name) {
case 'OnDocFormRender':

$output ="";
if ($cms == 'modxevo') { 
$output .="<link type=\"text/css\" rel=\"stylesheet\" href=\"../assets/modules/analytics4evo/12/default/style.css\">";  
}
else {
$output .="<link type=\"text/css\" rel=\"stylesheet\" href=\"media/style/".$modx->config['manager_theme']."/style.css\">";  
}

$output .="
<div class=\"tab-page\" id=\"tabAnalytics\">
<h2 class=\"tab\">Analytics</h2>
<style>
div#month-users, div#month-views {color:#499bea;display:block;margin:0;font-size:1.4rem;min-height:18px;text-align:center;vertical-align:middle;}
div#month-users h1, div#month-views h1 {display:block; margin-top:14px; font-size: 5rem !important;}
.container {padding-top:30px;}
.google-visualization-table-page-numbers a, .google-visualization-table-page-numbers a.current, .google-visualization-table-page-next, .google-visualization-table-page-prev {padding:0 6px;font-size:1.2em;text-decoration:none;box-shadow:0;background:none!important;border:1px solid #dedede;color:#595959}
.google-visualization-table-page-next, .google-visualization-table-page-prev {height:25px;background:none!important;border:1px solid #dedede;color:#595959;background-image:none!important;}
.google-visualization-table-page-numbers a:hover{text-decoration:none;box-shadow:0!important;border:1px solid #499bea;}
.google-visualization-table-div-page.gradient {background:transparent; padding-top:10px;}
.gapi-analytics-data-chart {width:100%!important;}
.card-header{text-transform: capitalize;}
</style>
<!-- Create the containing elements. -->
<h1><i class=\"fa fa-bar-chart\" aria-hidden=\"true\"></i> Page Analytics for <small>$url</small> </h1>
<div style=\"position:absolute;top:25px;right:35px;z-index:10;\" id=\"auth-button\"></div>


<div class=\"container\">
<div class=\"col-md-9\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> $sess_metrics </div> 
<div class=\"card-block\">
  <div style='width:100%;' id=\"widgetSessions\"></div>	
</div></div></div>

<div class=\"col-md-3\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Last 30 Days Users </div> 
<div class=\"card-block\">
<div id=\"month-users\"></div>
</div></div>
<div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Last 30 Days views</div> 
<div class=\"card-block\">
<div id=\"month-views\"></div>
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
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> usersType </div> 
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
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Referres </div> 
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
var monthViews = new gapi.analytics.report.Data({
 query: {
  'ids': \"$ids\",
  'filters': 'ga:pagePath==$url',
  'metrics': 'ga:pageviews',
  'start-date': '30daysAgo',
  'end-date': 'yesterday'
}
 });
monthViews.on('success', function(monthViews) {
for (var prop in monthViews) {
      var outputDiv = document.getElementById('month-views');
      outputDiv.innerHTML = 'Pageviews: ' + '<h1>' + monthViews[prop] +  '</h1>'; 
	  }
	console.log(monthViews);
});

  // widgetSessions: Create the timeline chart.
  var widgetSessions = new gapi.analytics.googleCharts.DataChart({
    reportType: 'ga',
    query: {
      'dimensions': 'ga:date',
      'metrics': 'ga:$sess_metrics',
      'start-date': '$sess_time',
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
	monthViews.execute();
  });

});
</script>
";  
$output .="
</div></div>	";
    break;
}
$e->output($output);
return;
}