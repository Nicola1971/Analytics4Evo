/**
 * DashboardAnalytics4Evo 
 *
 * Dashboard Analytics widget plugin for Evolution CMS
 *
 * @author      Nicola Lambathakis http://www.tattoocms.it/
 * @category    plugin
 * @version     RC1
 * @license	    http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnManagerWelcomeHome,OnManagerWelcomePrerender
 * @internal    @installset base
 * @internal    @modx_category Analytics
 * @internal    @disabled 1
 * @internal    @properties &wdgVisibility=Show widget for:;menu;All,AdminOnly,AdminExcluded,ThisRoleOnly,ThisUserOnly;All &ThisRole=Run only for this role:;string;;;(role id) &ThisUser=Run only for this user:;string;;;(username) &wdgTitle= Analytics widget Title:;string;Analytics  &wdgicon= widget icon:;string;fa-bar-chart &wdgposition=widget position:;text;1 &wdgsizex=widget width:;list;12,6,4,3;12 &IDclient=ID client:;string;;;application ID client &ids=ids:;;;Table ID (ids) &sess_metrics=metrics:;list;sessions,users;sessions &sess_time=time period:;list;30daysAgo,14daysAgo,7daysAgo;30daysAgo &rightNow=Realtime Users Title:;string;Right Now
 * @documentation Requirements: This plugin requires Evolution 1.3.5 or later
 * @reportissues https://github.com/Nicola1971/Analytics4Evo/issues
 * @link        
 * @lastupdate  07/01/2017
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
// get language
global $modx,$_lang;
// get plugin id
$result = $modx->db->select('id', $this->getFullTableName("site_plugins"), "name='{$modx->event->activePlugin}' AND disabled=0");
$pluginid = $modx->db->getValue($result);
if($modx->hasPermission('edit_plugin')) {
$button_pl_config = '<a data-toggle="tooltip" href="javascript:;" title="' . $_lang["settings_config"] . '" class="text-muted pull-right" onclick="parent.modx.popup({url:\''. MODX_MANAGER_URL.'?a=102&id='.$pluginid.'&tab=1\',title1:\'' . $_lang["settings_config"] . '\',icon:\'fa-cog\',iframe:\'iframe\',selector2:\'#tabConfig\',position:\'center center\',width:\'80%\',height:\'80%\',hide:0,hover:0,overlay:1,overlayclose:1})" ><i class="fa fa-cog"></i> </a>';
}
$modx->setPlaceholder('button_pl_config', $button_pl_config);
$WidgetOutput = ''.$modx->getChunk(''.$WidgetChunk.'').'';
$e = &$modx->Event;
switch($e->name){
case 'OnManagerWelcomePrerender':
$cssOutput = "
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
	filters: null,
	template: '<div class=\"ActiveUsers\">' + '$rightNow <br/><h1><b class=\"ActiveUsers-value\"></b></h1>' +  '</div>',
    pollingInterval: 5,
	'ids': \"$ids\"
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
	    height: '200px',
        width: '100%'
      }
    }
  }); 
  gapi.analytics.auth.on('success', function(response) {
    //hide the auth-button
    document.querySelector(\"#auth-button\").style.display='none';  
    widgetSessions.execute();
    activeUsers.execute();
  });

});
</script> 
<style>
div#active-users {color:#058DC7;display:block;margin:0;text-align:center;vertical-align:middle;}
div#active-users .ActiveUsers-value {color:#ff9900; display:block; margin-top:3px; font-size: 3rem !important; font-weight:normal!important;}
</style>
<div id=\"auth-button\"></div>
";
$e->output($cssOutput);
break;
case 'OnManagerWelcomeHome':
			$widgets['DashboardAnalytics'] = array(
				'menuindex' =>''.$wdgposition.'',
				'id' => 'DashboardAnalytics'.$pluginid.'',
				'cols' => 'col-md-'.$wdgsizex.'',
				'icon' => ''.$wdgicon.'',
				'title' => ''.$wdgTitle.' '.$button_pl_config.'',
				'body' => '<div class="card-body"><div id="active-users"></div><div style="width:100%;" id="widgetSessions"></div></div>',
				'hide' => '0'
			);	
            $e->output(serialize($widgets));
    break;
}
}