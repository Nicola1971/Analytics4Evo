/**
 * Analytics4Evo
 *
 * Google Analytics for Evolution
 *
 * @category	module
 * @version     beta 0.2
 * @author      Author: Nicola Lambathakis http://www.tattoocms.it/
 * @icon        fa fa-bar-chart
 * @internal	@modx_category Manager
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @properties &IDclient=ID client:;string;;;application ID client &ids=ids:;string;;;Table ID (ids) &sess_metrics=Session/Users Chart metrics:;menu;sessions,users;sessions &sess_time=Session/Users time period:;menu;30daysAgo,14daysAgo,7daysAgo;30daysAgo &cms=cms:;menu;modxevo,evolution;evolution
 * @internal @installset base, sample
 * @internal    @disabled 0
 * @reportissues https://github.com/Nicola1971/Analytics4Evo/issues
 * @lastupdate  05-01-2017
 */


if(!defined('MODX_BASE_PATH')){die('What are you doing? Get out of here!');}

// get global language
global $modx,$_lang;
//config button
$module_id = (!empty($_REQUEST["id"])) ? (int)$_REQUEST["id"] : $yourModuleId;
if($modx->hasPermission('edit_module')) {
$button_config = '<a title="' . $_lang["settings_config"] . '" href="index.php?a=108&id='.$module_id.'" class="btn btn-sm btn-secondary" ><i class="fa fa-cog"></i> ' . $_lang["settings_config"] . '</a>';
}

$output ="";
$output .="
<!DOCTYPE html>
<html>
<head>
  <title> Analytics4Evo </title>"; 
  
if ($cms == 'modxevo') { 
$output .="<link type=\"text/css\" rel=\"stylesheet\" href=\"../assets/modules/analytics4evo/12/default/style.css\">";  
}
else {
$output .="<link type=\"text/css\" rel=\"stylesheet\" href=\"media/style/".$modx->config['manager_theme']."/style.css\">";  
}

$output .="
</head>
<body>
<style>
div#active-users, div#month-users {color:#499bea;display:block;margin:0;font-size:1.4rem;min-height:18px;text-align:center;vertical-align:middle;}
div#active-users .ActiveUsers-value, div#month-users h1 {display:block; margin-top:14px; font-size: 5rem !important; font-weight:normal!important;}
.container {padding-top:30px;}
.google-visualization-table-page-numbers a, .google-visualization-table-page-numbers a.current, .google-visualization-table-page-next, .google-visualization-table-page-prev {padding:0 6px;font-size:1.2em;text-decoration:none;box-shadow:0;background:none!important;border:1px solid #dedede;color:#595959}
.google-visualization-table-page-next, .google-visualization-table-page-prev {height:25px;background:none!important;border:1px solid #dedede;color:#595959;background-image:none!important;}
.google-visualization-table-page-numbers a:hover{text-decoration:none;box-shadow:0!important;border:1px solid #499bea;}
.google-visualization-table-div-page.gradient {background:transparent; padding-top:10px;}
.gapi-analytics-data-chart {width:100%!important;}
.card-header{text-transform: capitalize;}
</style>
<!-- Create the containing elements. -->
<h1><i class=\"fa fa-bar-chart\" aria-hidden=\"true\"></i> Analytics 4 Evo</h1>
<div style=\"position:absolute;top:25px;right:35px;z-index:10;\" id=\"auth-button\"></div>

<div class=\"container\">
<div class=\"col-md-9\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> $sess_metrics </div> 
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

</div>
<div class=\"container\">
<div class=\"col-md-12\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Visitors </div> <div class=\"card-block\" id=\"widgetVisitors\"></div></div></div>

<div class=\"col-md-4\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Countries </div> <div class=\"card-block\" id=\"widgetCountry\"></div></div></div>
<div class=\"col-md-4\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Devices </div> <div class=\"card-block\" id=\"widgetDevice\"></div></div></div>
<div class=\"col-md-4\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Sources </div> <div class=\"card-block\" id=\"widgetSources\"></div></div></div>

<div class=\"col-md-12\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Top Content </div> <div class=\"card-block\" id=\"widgetContent\"></div></div></div>
<div class=\"col-md-6\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Top Referring </div> <div class=\"card-block\" id=\"widgetReferring\"></div></div></div>

<div class=\"col-md-6\"><div class=\"card\" data-stateful=\"true\" data-inner-id=\"top\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Social Network </div> <div class=\"card-block\" id=\"socialNetworks\"></div></div></div>

<div class=\"buttonConfig pull-right\" style=\"margin-right:8px;\">
$button_config
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
<script src=\"media/script/jquery/jquery.min.js\"></script>
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
  
  //Create a new ActiveUsers instance to be rendered inside of an element with the id \"active-users-container\" 
  //and poll for changes every five seconds.
 var activeUsers = new gapi.analytics.ext.ActiveUsers({
    container: 'active-users',
	filters: null,
	template: '<div class=\"ActiveUsers\">' + 'Right Now: <br/><h1><b class=\"ActiveUsers-value\"></b></h1>' +  '</div>',
    pollingInterval: 5,
	'ids': \"$ids\"
  });

var monthUsers = new gapi.analytics.report.Data({
 query: {
  'ids': \"$ids\",
  'metrics': 'ga:users',
  'start-date': '30daysAgo',
  'end-date': 'yesterday'
}
 });
monthUsers.on('success', function(monthUsers) {
for (var prop in monthUsers) {
      var outputDiv = document.getElementById('month-users');
      outputDiv.innerHTML = 'Users: <br/>' + '<h1>' + monthUsers[prop] +  '</h1>';  
	  }
	console.log(monthUsers);
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
  //pie
  // widgetCountry: Create the timeline chart.
  var widgetCountry = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:sessions',
      dimensions: 'ga:country',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 6,
      sort: '-ga:sessions',
     'ids': \"$ids\"
    },
    chart: {
      container: 'widgetCountry',
       type: 'GEO',
       options: {
        width: '100%'
      }
    }
  }); 
  // widgetDevice: Create the timeline chart.
  var widgetDevice = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:sessions',
      dimensions: 'ga:deviceCategory',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 6,
      sort: '-ga:sessions',
     'ids': \"$ids\"
    },
    chart: {
      container: 'widgetDevice',
      type: 'PIE',
      options: {
        width: '100%',
        pieHole: 4/9
      }
    }
  });   
   // widgetSources: Create the timeline chart.
  var widgetSources = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:sessions',
      dimensions: 'ga:medium',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 6,
      sort: '-ga:sessions',
     'ids': \"$ids\"
    },
    chart: {
      container: 'widgetSources',
      type: 'PIE',
      options: {
        width: '100%',
        pieHole: 4/9
      }
    }
  });  
  //tables
    // widgetContent: Top Content
  var widgetContent = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:pageviews,ga:uniquePageviews,ga:timeOnPage,ga:bounces',
      dimensions: 'ga:pagePath',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 30,
      sort: '-ga:pageviews',
     'ids': \"$ids\"
    },
    chart: {
      type: 'TABLE',
      container: 'widgetContent',
      options: {
        width: '100%',
		page: 'enable',
		pageSize: '10'
      }
    }
  });
       // widgetReferring: Referring Sites
  var widgetReferring = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:pageviews,ga:sessionDuration',
      dimensions: 'ga:source',
	  filters: 'ga:medium==referral',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 10,
      sort: '-ga:pageviews',
     'ids': \"$ids\"
    },
    chart: {
      type: 'TABLE',
      container: 'widgetReferring',
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
    var socialNetworks = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:sessions',
      dimensions: 'ga:source,ga:socialNetwork,ga:referralPath,ga:pagePath',
	  filters: 'ga:hasSocialSourceReferral==Yes',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 10,
      sort: '-ga:sessions',
     'ids': \"$ids\"
    },
    chart: {
      type: 'TABLE',
      container: 'socialNetworks',
      options: {
        width: '100%'
      }
    }
  }); 
  gapi.analytics.auth.on('success', function(response) {
    //hide the auth-button
    document.querySelector(\"#auth-button\").style.display='none';  
    widgetSessions.execute();
    widgetCountry.execute();
	widgetVisitors.execute();
	widgetContent.execute();
	widgetReferring.execute();
	widgetDevice.execute();
	widgetSources.execute();
	socialNetworks.execute();
	activeUsers.execute();
	//settimeout to try to avoid GA rate limits
      setTimeout(monthUsers.execute(),400);
  });

});
</script>
</body>
";  
$output .="
</html>	";
return $output;