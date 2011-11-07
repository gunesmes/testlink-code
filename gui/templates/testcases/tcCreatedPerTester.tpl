{* 
TestLink Open Source Project - http://testlink.sourceforge.net/

Purpose: smarty template - Report of Test Cases created per tester

rev:
20111106 - kinow - first version
*}

{include file="inc_head.tpl" openHead='yes'}

{foreach from=$gui->tableSet key=idx item=matrix name="initializer"}
	{assign var="tableID" value="table_$idx"}
	{if $smarty.foreach.initializer.first}
		{$matrix->renderCommonGlobals()}
		{include file="inc_ext_js.tpl" bResetEXTCss=1}
		{include file="inc_ext_table.tpl"}
	{/if}
	{$matrix->renderHeadSection($tableID)}
{/foreach}

</head>

{assign var=this_template_dir value=$smarty.template|dirname}
{lang_get var='labels' 
          s='no_records_found,testplan,testcase,version,assigned_on,due_since,platform,goto_testspec,priority,
             high_priority,medium_priority,low_priority,build,testsuite,generated_by_TestLink_on,show_closed_builds_btn'}

{* 20101008 - asimon - BUGID 3311 *}
<body onUnload="storeWindowSize('AssignmentOverview')">
<h1 class="title">{$gui->pageTitle}</h1>
<div class="workBack">

{* 20101013 - asimon - disable "show also closed builds" checkbox when a specific build is selected *}
{if $gui->show_build_selector}
<p>
<form method="post">
	<input type="checkbox" name="show_closed_builds" value="show_closed_builds"
		   {if $gui->show_closed_builds} checked="checked" {/if}
		   onclick="this.form.submit();" /> {$labels.show_closed_builds_btn}
	<input type="hidden"
		   name="show_closed_builds_hidden"
		   value="{$gui->show_closed_builds}" />
</form>
</p>
<br />
{/if}

{if $gui->warning_msg == ''}
	{if $gui->resultSet}
		{foreach from=$gui->tableSet key=idx item=matrix}
		
			<p>
			{assign var="tableID" value="table_$idx"}
			{$matrix->renderBodySection($tableID)}
			<br /></p>
		
		{/foreach}
		
		<br />
		{$labels.generated_by_TestLink_on} {$smarty.now|date_format:$gsmarty_timestamp_format}
    {else}
        	{$labels.no_records_found}
    {/if}
{else}
	<div class="user_feedback">
    {$gui->warning_msg}
    </div>
{/if}   
</div>
</body>
</html>
