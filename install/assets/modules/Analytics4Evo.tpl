/**
 * Analytics4Evo
 *
 * Google Analytics for Evolution
 *
 * @category	module
 * @version     RC1
 * @author      Author: Nicola Lambathakis http://www.tattoocms.it/
 * @icon        fa fa-bar-chart
 * @internal	@modx_category Manager
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @properties &IDclient=ID client:;string;;;application ID client &ids=ids:;string;;;Table ID (ids) &sess_metrics=Session/Users Chart metrics:;menu;sessions,users;sessions &sess_time=Session/Users time period:;menu;30daysAgo,14daysAgo,7daysAgo;30daysAgo &custNum_metrics=Custom Number report:;menu;pageviews,sessions,users,newUsers,bounceRate,timeOnPage,adsenseRevenue;users &custChart1_title= Custom chart 1 Title:;string; &custChart1_metrics=Custom chart 1 metrics:;menu;users,newUsers,sessions,bounces,bounceRate,sessionDuration,avgSessionDuration,hits,organicSearches,pageValue,entrances,entranceRate,pageviews,timeOnPage,exits,pageLoadTime,adsenseRevenue,adsenseCTR,adsenseAdsViewed,adsenseAdsClicks;sessions &custChart1_dimensions=Custom chart 1 dimensions:;menu;userType,sessionCount,referralPath,fullReferrer,campaign,source,medium,sourceMedium,keyword,adContent,socialNetwork,campaignCode,browser,browserVersion,operatingSystem,operatingSystemVersion,mobileDeviceBranding,mobileDeviceModel,deviceCategory,browserSize,continent,country,region,city,hostname,pagePath,pageTitle,landingPagePath,secondPagePath,exitPagePath,previousPagePath,date,year,month,week,day,hour,dayOfWeek,dateHour;country &custChart1_Chart=Custom Chart1 chart type :;menu;PIE,LINE,COLUMN,BAR,TABLE,GEO;GEO &custChart2_title= Custom chart 2 Title:;string; &custChart2_metrics=Custom chart 2 metrics:;menu;users,newUsers,sessions,bounces,bounceRate,sessionDuration,avgSessionDuration,hits,organicSearches,pageValue,entrances,entranceRate,pageviews,timeOnPage,exits,pageLoadTime,adsenseRevenue,adsenseCTR,adsenseAdsViewed,adsenseAdsClicks;sessions &custChart2_dimensions=Custom chart 2 dimensions:;menu;userType,sessionCount,referralPath,fullReferrer,campaign,source,medium,sourceMedium,keyword,adContent,socialNetwork,campaignCode,browser,browserVersion,operatingSystem,operatingSystemVersion,mobileDeviceBranding,mobileDeviceModel,deviceCategory,browserSize,continent,country,region,city,hostname,pagePath,pageTitle,landingPagePath,secondPagePath,exitPagePath,previousPagePath,date,year,month,week,day,hour,dayOfWeek,dateHour;deviceCategory &custChart2_Chart=Custom Chart2 chart type:;menu;PIE,LINE,COLUMN,BAR,TABLE,GEO;PIE &custChart3_title= Custom chart 3 Title:;string;Traffic Sources &custChart3_metrics=Custom chart 3 metrics:;menu;users,newUsers,sessions,bounces,bounceRate,sessionDuration,avgSessionDuration,hits,organicSearches,pageValue,entrances,entranceRate,pageviews,timeOnPage,exits,pageLoadTime,adsenseRevenue,adsenseCTR,adsenseAdsViewed,adsenseAdsClicks;sessions &custChart3_dimensions=Custom chart 3 dimensions:;menu;userType,sessionCount,referralPath,fullReferrer,campaign,source,medium,sourceMedium,keyword,adContent,socialNetwork,campaignCode,browser,browserVersion,operatingSystem,operatingSystemVersion,mobileDeviceBranding,mobileDeviceModel,deviceCategory,browserSize,continent,country,region,city,hostname,pagePath,pageTitle,landingPagePath,secondPagePath,exitPagePath,previousPagePath,date,year,month,week,day,hour,dayOfWeek,dateHour;medium &custChart3_Chart=Custom Chart3 chart type :;menu;PIE,LINE,COLUMN,BAR,TABLE,GEO;PIE &cms=cms:;menu;modxevo,evolution;evolution
 * @internal @installset base, sample
 * @internal    @disabled 0
 * @reportissues https://github.com/Nicola1971/Analytics4Evo/issues
 * @lastupdate  07-01-2017
 */

if(!defined('MODX_BASE_PATH')){die('What are you doing? Get out of here!');}
$version = 'RC1';
// get global language
global $modx,$_lang;
//config button
$module_id = (!empty($_REQUEST["id"])) ? (int)$_REQUEST["id"] : $yourModuleId;
if($modx->hasPermission('edit_module')) {
$button_config = '<a title="' . $_lang["settings_config"] . '" href="index.php?a=108&id='.$module_id.'" class="btn btn-sm btn-secondary" ><i class="fa fa-cog"></i> ' . $_lang["settings_config"] . '</a>';
}

$custChart1_title = isset($custChart1_title) ? $custChart1_title : $custChart1_dimensions;
$custChart2_title = isset($custChart2_title) ? $custChart2_title : $custChart2_dimensions;
$custChart3_title = isset($custChart3_title) ? $custChart3_title : $custChart3_dimensions;

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
<body class=\"widgets\">
<style>
div#active-users, div#month-views {text-transform: capitalize;color:#058DC7;display:block;margin:0;font-size:1.4rem;min-height:18px;text-align:center;vertical-align:middle;}
div#active-users .ActiveUsers-value {color:#ff9900; display:block; margin-top:14px; font-size: 5rem !important; font-weight:normal!important;}
div#month-views h1 {color:#ff9900; display:block; margin-top:14px; font-size: 3rem !important; font-weight:normal!important;}
.container {padding-top:30px;}
.google-visualization-table-page-numbers a, .google-visualization-table-page-numbers a.current, .google-visualization-table-page-next, .google-visualization-table-page-prev {padding:0 6px;font-size:1.2em;text-decoration:none;box-shadow:0;background:none!important;border:1px solid #dedede;color:#595959}
.google-visualization-table-page-next, .google-visualization-table-page-prev {height:25px;background:none!important;border:1px solid #dedede;color:#595959;background-image:none!important;}
.google-visualization-table-page-numbers a:hover{text-decoration:none;box-shadow:0!important;border:1px solid #499bea;}
.google-visualization-table-div-page.gradient {background:transparent; padding-top:10px;}
.gapi-analytics-data-chart {width:100%!important;}
.card-header{text-transform: capitalize;}
.widgets .card-block {padding:0 10px 10px 10px!important;}
.container { padding-left: 0.50rem; padding-right: 0.50rem; width: 100% }
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
<div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Last 30 Days $custNum_metrics</div> 
<div class=\"card-block\">
<div id=\"month-views\"></div>
</div></div>
</div>
</div>
<div class=\"container\">
<div class=\"col-md-4\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> $custChart1_title </div> <div class=\"card-block\" id=\"widgetcustChart1\"></div></div></div>
<div class=\"col-md-4\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> $custChart2_title </div> <div class=\"card-block\" id=\"widgetcustChart2\"></div></div></div>
<div class=\"col-md-4\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> $custChart3_title </div> <div class=\"card-block\" id=\"widgetcustChart3\"></div></div></div>
<div class=\"col-md-12\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Visitors </div> <div class=\"card-block\" id=\"widgetVisitors\"></div></div></div>
<div class=\"col-md-12\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Top Content </div> <div class=\"card-block\" id=\"widgetContent\"></div></div></div>
<div class=\"col-md-6\"><div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Top Referring </div> <div class=\"card-block\" id=\"widgetReferring\"></div></div></div>
<div class=\"col-md-6\"><div class=\"card\" data-stateful=\"true\" data-inner-id=\"top\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Social Network </div> <div class=\"card-block\" id=\"socialNetworks\"></div></div></div>
<div class=\"clearfix\"></div>
<div class=\"pull-left\" style=\"margin-left:12px;\">
<span class=\"text-muted\"><i class=\"fa fa-bar-chart\"></i> Analytics4Evo $version</span>
  </div>
<div class=\"buttonConfig pull-right\" style=\"margin-right:12px;\">
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
//custom number report
var monthViews = new gapi.analytics.report.Data({
 query: {
  'ids': \"$ids\",
  'metrics': 'ga:$custNum_metrics',
  'start-date': '30daysAgo',
  'end-date': 'yesterday'
}
 });
monthViews.on('success', function(monthViews) {
for (var prop in monthViews) {
      var outputDiv = document.getElementById('month-views');
	  var jsonViews = JSON.stringify(monthViews[prop]);
	  if (jsonViews !== '{\"ga:$custNum_metrics\":\"0\"}') {
      outputDiv.innerHTML = '$custNum_metrics: ' + '<h1>' + monthViews[prop] +  '</h1>'; 
	  }
		else {
       outputDiv.innerHTML = '$custNum_metrics: ' + '<h1> 0 </h1>'; 
        }
	 }
	 console.log(JSON.stringify(monthViews[prop]));
});
  // widgetSessions
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
    // widgetcustChart1
  var widgetcustChart1 = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:$custChart1_metrics',
      dimensions: 'ga:$custChart1_dimensions',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 30,
      //sort: '-ga:$custChart1_metrics',
     'ids': \"$ids\"
    },
    chart: {
      container: 'widgetcustChart1',
       type: '$custChart1_Chart',
       options: {
        width: '100%',
        pieHole: 4/9
      }
    }
  }); 
    // widgetcustChart2
  var widgetcustChart2 = new gapi.analytics.googleCharts.DataChart({
    reportType: 'ga',
    query: {
      'metrics': 'ga:$custChart2_metrics',
      'dimensions': 'ga:$custChart2_dimensions',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
	  //sort: '-ga:$custChart2_metrics',
      'ids': \"$ids\"
    },
    chart: {
      type: '$custChart2_Chart',
      container: 'widgetcustChart2',
      options: {
        width: '100%',
        pieHole: 4/9
      }
    }
  });
    // widgetcustChart3
  var widgetcustChart3 = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:$custChart3_metrics',
      dimensions: 'ga:$custChart3_dimensions',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 30,
      // sort: '-ga:$custChart3_metrics',
      'ids': \"$ids\"
    },
    chart: {
      container: 'widgetcustChart3',
      type: '$custChart3_Chart',
      options: {
        width: '100%',
        pieHole: 4/9
      }
    }
  });    
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
	widgetVisitors.execute();
	widgetcustChart1.execute();
	widgetcustChart2.execute();
	widgetcustChart3.execute();
	widgetContent.execute();
	widgetReferring.execute();
    activeUsers.execute();		
	//settimeout to try to avoid GA rate limits
	setTimeout(socialNetworks.execute(),200);
    setTimeout(monthViews.execute(),400);
  });

});
</script>
</body>
";  
$output .="
</html>	";
return $output;