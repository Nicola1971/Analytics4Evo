/**
 * PageAnalytics4Evo
 *
 * Resource Page Google Analytics for Evolution
 *
 * @author      Author: Nicola Lambathakis http://www.tattoocms.it/
 * @category	plugin
 * @version     1 RC1.3
 * @internal    @events OnDocFormRender
 * @internal	@modx_category Analytics
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @properties &wdgVisibility=Show Analytics tab for:;menu;All,AdminOnly,AdminExcluded,ThisRoleOnly,ThisUserOnly;All &ThisRole=Show only for this role:;string;;;(role id) &ThisUser=Show only for this user:;string;;;(username) &IDclient=ID client:;string;;;application ID client &ids=ids:;string;;;Table ID (ids) &sess_metrics=Session/Users Chart metrics:;list;sessions,users;sessions &sess_time=Session/Users time period:;list;7daysAgo,14daysAgo,30daysAgo,60daysAgo;30daysAgo &custNum_metrics=Custom Number report :;list;pageviews,sessions,users,newUsers,bounceRate,timeOnPage,adsenseRevenue;pageviews &custChart1_title= Custom chart 1 Title:;string;Bounce Rate &custChart1_metrics=Custom chart 1 metrics:;menu;users,newUsers,sessions,bounces,bounceRate,sessionDuration,avgSessionDuration,hits,organicSearches,pageValue,entrances,entranceRate,pageviews,timeOnPage,exits,pageLoadTime,adsenseRevenue,adsenseCTR,adsenseAdsViewed,adsenseAdsClicks;bounceRate &custChart1_dimensions=Custom chart 1 dimensions:;menu;userType,sessionCount,referralPath,fullReferrer,campaign,source,medium,sourceMedium,keyword,adContent,socialNetwork,campaignCode,browser,browserVersion,operatingSystem,operatingSystemVersion,mobileDeviceBranding,mobileDeviceModel,deviceCategory,browserSize,continent,country,region,city,hostname,pagePath,pageTitle,landingPagePath,secondPagePath,exitPagePath,previousPagePath,date,year,month,week,day,hour,dayOfWeek,dateHour;date &custChart1_Chart=Custom Chart1 chart type :;menu;PIE,LINE,COLUMN,BAR,TABLE,GEO;LINE &custChart2_title= Custom chart 2 Title:;string; &custChart2_metrics=Custom chart 2 metrics:;menu;users,newUsers,sessions,bounces,bounceRate,sessionDuration,avgSessionDuration,hits,organicSearches,pageValue,entrances,entranceRate,pageviews,timeOnPage,exits,pageLoadTime,adsenseRevenue,adsenseCTR,adsenseAdsViewed,adsenseAdsClicks;sessions &custChart2_dimensions=Custom chart 2 dimensions:;menu;userType,sessionCount,referralPath,fullReferrer,campaign,source,medium,sourceMedium,keyword,adContent,socialNetwork,campaignCode,browser,browserVersion,operatingSystem,operatingSystemVersion,mobileDeviceBranding,mobileDeviceModel,deviceCategory,browserSize,continent,country,region,city,hostname,pagePath,pageTitle,landingPagePath,secondPagePath,exitPagePath,previousPagePath,date,year,month,week,day,hour,dayOfWeek,dateHour;deviceCategory &custChart2_Chart=Custom Chart2 chart type:;menu;PIE,LINE,COLUMN,BAR,TABLE,GEO;PIE &cms=cms:;list;modxevo,evolution;evolution
 * @internal @installset base, sample
 * @internal    @disabled 0
 * @reportissues https://github.com/Nicola1971/Analytics4Evo/issues
 * @lastupdate  12-01-2017
 */

$version = '1 RC1.3';
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
// get plugin id
$result = $modx->db->select('id', $this->getFullTableName("site_plugins"), "name='{$modx->event->activePlugin}' AND disabled=0");
$pluginid = $modx->db->getValue($result);
if($modx->hasPermission('edit_plugin')) {
$button_pl_config = '<a data-toggle="tooltip" href="javascript:;" title="' . $_lang["settings_config"] . '" class="btn btn-sm btn-secondary text-muted pull-right" onclick="parent.modx.popup({url:\''. MODX_MANAGER_URL.'?a=102&id='.$pluginid.'&tab=1\',title1:\'' . $_lang["settings_config"] . '\',icon:\'fa-cog\',iframe:\'iframe\',selector2:\'#tabConfig\',position:\'center center\',width:\'80%\',height:\'80%\',hide:0,hover:0,overlay:1,overlayclose:1})" ><i class="fa fa-cog"></i> ' . $_lang["settings_config"] . '</a>';
}
$modx->setPlaceholder('button_pl_config', $button_pl_config);
$custChart1_title = isset($custChart1_title) ? $custChart1_title : $custChart1_dimensions;
$custChart2_title = isset($custChart2_title) ? $custChart2_title : $custChart2_dimensions;
$e = &$modx->Event;
$output ='';
switch($e->name) {
case 'OnDocFormRender':

$output ="";
if ($cms == 'modxevo') { 
$output .="<link type=\"text/css\" rel=\"stylesheet\" href=\"../assets/modules/analytics4evo/12/default/style.css\">";  
}
$output .="
<style>
div#active-users, div#month-views {text-transform: capitalize;color:#058DC7;display:block;margin:0;font-size:1.4rem;min-height:18px;text-align:center;vertical-align:middle;}
div#active-users .ActiveUsers-value {color:#ff9900; display:block; margin-top:14px; font-size: 5rem !important; font-weight:normal!important;}
div#month-views h1 {color:#ff9900; display:block; margin-top:14px; font-size: 3rem !important; font-weight:normal!important;}
.container {padding-top:30px;}
.google-visualization-table-page-numbers a, .google-visualization-table-page-numbers a.current, .google-visualization-table-page-next, .google-visualization-table-page-prev {padding:0 6px;font-size:1.2em;text-decoration:none;box-shadow:0;background:none!important;border:1px solid #dedede;color:#595959}
.google-visualization-table-page-next, .google-visualization-table-page-prev {height:25px;background:none!important;border:1px solid #dedede;color:#595959;background-image:none!important;}
.google-visualization-table-page-numbers a:hover{text-decoration:none;box-shadow:0!important;border:1px solid #499bea;}
.google-visualization-table-div-page.gradient {background:transparent; padding-top:10px;}
.card-header{text-transform: capitalize;}
.widgets {padding:0!important;}
.widgets .card-block {padding:0 10px 10px 10px!important;}
.widgets .container { padding: 0!important; width: 100% }
</style>
<div class=\"tab-page widgets\" id=\"tabAnalytics\">
<h2 class=\"tab\" id=\"analytics4evo-tab\">Analytics</h2>
<!-- Create the containing elements. -->
<h1><i class=\"fa fa-bar-chart\" aria-hidden=\"true\"></i> Page Analytics for <small>$url</small> </h1>
<div style=\"position:absolute;top:25px;right:35px;z-index:10;\" id=\"auth-button\"></div>
<div class=\"container\">
<div class=\"col-md-9\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> $sess_metrics </div> 
<div class=\"card-block\">
<div style='width:100%;' id=\"widgetSessions\"></div>	
</div></div></div>
<div class=\"col-md-3\">
<div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Right Now</div> 
<div class=\"card-block\">
<div id=\"active-users\"></div>
</div></div>
<div class=\"card\"><div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Last 30 Days $custNum_metrics</div> 
<div class=\"card-block\">
<div id=\"month-views\"></div>
</div></div>
</div>
<div class=\"clearfix\"></div>
<div class=\"col-md-6\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> $custChart1_title </div> 
<div class=\"card-block\">
  <div id=\"widgetcustChart1\"></div>	
</div></div></div>
<div class=\"col-md-6\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> $custChart2_title </div> 
<div class=\"card-block\">
  <div id=\"widgetcustChart2\"></div>	
</div></div></div>
<div class=\"col-md-12\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Visitors </div> 
<div class=\"card-block\">
  <div id=\"widgetVisitors\"></div>	
</div></div></div>
<div class=\"clearfix\"></div>
<div class=\"col-md-6\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Previous Page </div> 
<div class=\"card-block\">
  <div id=\"widgetPrevPage\"></div>	
</div></div></div>
<div class=\"col-md-6\"><div class=\"card\">
<div class=\"card-header\"> <i class=\"fa fa-bar-chart\"></i> Next Page </div> 
<div class=\"card-block\">
  <div id=\"widgetNextPage\"></div>	
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
<div class=\"clearfix\"></div>
<div class=\"buttonConfig pull-left\" style=\"margin-left:12px;\">
<span class=\"text-muted\"><i class=\"fa fa-bar-chart\"></i> PageAnalytics4Evo $version</span>
  </div>
<div class=\"buttonConfig pull-right\" style=\"margin-right:12px;\">
 $button_pl_config
  </div>
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
 
//custom number report
var monthViews = new gapi.analytics.report.Data({
 query: {
  'ids': \"$ids\",
  'filters': 'ga:pagePath==$url',
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

  // widgetSessions: Create the timeline chart.
  var widgetSessions = new gapi.analytics.googleCharts.DataChart({
    reportType: 'ga',
    query: {
      'dimensions': 'ga:date',
      'metrics': 'ga:$sess_metrics',
      'start-date': '$sess_time',
      'end-date': 'yesterday',
	  'max-results': 60,
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
      sort: '-ga:users',
	  'filters': 'ga:pagePath==$url',
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
      // widgetPrevPage: PrevPage.
  var widgetPrevPage = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:users',
      dimensions: 'ga:previousPagePath',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 30,
	  'filters': 'ga:pagePath==$url,ga:previousPagePath!=$url',
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
      // widgetNextPage: NextPage.
  var widgetNextPage = new gapi.analytics.googleCharts.DataChart({
     reportType: 'ga',
    query: {
      metrics: 'ga:users',
      dimensions: 'ga:PagePath',
      'start-date': '30daysAgo',
      'end-date': 'yesterday',
      'max-results': 30,
	  'filters': 'ga:pagePath!=$url,ga:previousPagePath==$url',
      sort: '-ga:users',
     'ids': \"$ids\"
    },
    chart: {
      type: 'TABLE',
      container: 'widgetNextPage',
      options: {
        width: '100%',
		page: 'enable',
		pageSize: '10'
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
	  'filters': 'ga:pagePath==$url',
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
	  'max-results': 30,
	  'filters': 'ga:pagePath==$url',
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
  gapi.analytics.auth.on('success', function(response) {
    //hide the auth-button
    document.querySelector(\"#auth-button\").style.display='none';  
    widgetSessions.execute();
	widgetVisitors.execute();
	widgetPrevPage.execute();
	widgetNextPage.execute()
	activeUsers.execute();	
	monthViews.execute();
	widgetcustChart1.execute();
	widgetcustChart2.execute();
		//settimeout to try to avoid GA rate limits
    setTimeout(widgetReferres.execute(),500);    
	setTimeout(widgetKeywords.execute(),1000);
	$('analytics4evo-tab').addEventListener('click',function ()
    {
        widgetSessions.execute();
		widgetcustChart1.execute();
	    widgetcustChart2.execute();
    });
  });
(function($,sr){
  // debouncing function from John Hann
  // http://unscriptable.com/index.php/2009/03/20/debouncing-javascript-methods/
  var debounce = function (func, threshold, execAsap) {
      var timeout;
      return function debounced () {
          var obj = this, args = arguments;
          function delayed () {
              if (!execAsap)
                  func.apply(obj, args);
              timeout = null;
          };

          if (timeout)
              clearTimeout(timeout);
          else if (execAsap)
              func.apply(obj, args);

          timeout = setTimeout(delayed, threshold || 100);
      };
  }
  // smartresize 
  jQuery.fn[sr] = function(fn){  return fn ? this.bind('resize', debounce(fn)) : this.trigger(sr); };

})(jQuery,'smartresize');
//resize charts
jQuery(document).ready(function () {
    jQuery(window).smartresize(function () {
        widgetSessions.execute();
		widgetcustChart1.execute();
	    widgetcustChart2.execute();
    });
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