 <!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on 
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with 
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without 
Mura CMS under the license of your choice, provided that you follow these specific guidelines: 

Your custom code 

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->
<cfinclude template="js.cfm">
<cfoutput>
<h1>#application.rbFactory.getKeyValue(session.rb,"dashboard.comments")#</h1>

<cfinclude template="dsp_secondary_menu.cfm">

<cfparam name="rc.page" default="1">
<cfset comments=application.contentManager.getRecentCommentsIterator(rc.siteID,100,false) />
<cfset comments.setNextN(20)>
<cfset comments.setPage(rc.page)>

<h3>#application.rbFactory.getKeyValue(session.rb,"dashboard.comments.last100")#</h3>
<table class="mura-table-grid">
<thead>
<tr>
	<th class="var-width">#application.rbFactory.getKeyValue(session.rb,"dashboard.comments")#</th>
	<th class="dateTime">#application.rbFactory.getKeyValue(session.rb,"dashboard.comments.posted")#</th>
	<th class="actions">&nbsp;</th>
</tr>
</thead>
<tbody>
<cfif comments.hasNext()>

<cfloop condition="comments.hasNext()">
	<cfset comment=comments.next()>
	<!---
	<cfset crumbdata=application.contentManager.getCrumbList(comment.getCommentID(),comment.getSiteID())/>
	<cfset verdict=application.permUtility.getnodePerm(crumbdata)/>
	--->
	<cfset content=application.serviceFactory.getBean("content").loadBy(contentID=comment.getContentID(),siteID=session.siteID)>

	<tr>
		<cfset args=arrayNew(1)>
		<cfset args[1]="<strong>#tempEncodeForHTML(comment.getName())#</strong>">
		<cfset args[2]="<strong>#tempEncodeForHTML(content.getMenuTitle())#</strong>">
		<td class="var-width">#application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,"dashboard.comments.description"),args)#</td>
		<td class="dateTime">#LSDateFormat(comment.getEntered(),session.dateKeyFormat)# #LSTimeFormat(comment.getEntered(),"short")#</td>
		<td class="actions">
		<ul>
			<li class="preview"><a title="#application.rbFactory.getKeyValue(session.rb,"dashboard.view")#" href="##" onclick="return preview('#tempEncodeForJavascript(content.getURL(complete=1,queryString='##comment-#comment.getCommentID()#'))#','#content.getTargetParams()#');"><i class="icon-globe"></i></a></li>
		</ul>
		</td>
	</tr>
	</cfloop>
<cfelse>
<tr>
<td class="noResults" colspan="3">#application.rbFactory.getKeyValue(session.rb,"dashboard.comments.nocomments")#</td>
</tr>
</cfif>
</tbody>
</table>

<cfif comments.recordCount() and comments.pageCount() gt 1>
	<div class="pagination">
	<ul>
		<cfif comments.getPageIndex() gt 1> 
			<a href="./?muraAction=cDashboard.recentComments&page=#evaluate('comments.getPageIndex()-1')#&siteid=#tempEncodeForURL(rc.siteid)#"><li>&laquo;&nbsp;#application.rbFactory.getKeyValue(session.rb,"dashboard.session.prev")#</a></li>
			</cfif>
		<cfloop from="1"  to="#comments.pageCount()#" index="i">
			<cfif comments.getPageIndex() eq i>
				<li class="active"> <a href="##">#i#</a></li> 
			<cfelse> 
				<li><a href="./?muraAction=cDashBoard.recentComments&page=#i#&siteid=#tempEncodeForURL(rc.siteid)#">#i#</a>
				</li>
			</cfif>
		</cfloop>
		<cfif comments.getPageIndex() lt comments.pageCount()>
			<li><a href="./?muraAction=cDashboard.recentComments&page=#evaluate('comments.getPageIndex()+1')#&siteid=#tempEncodeForURL(rc.siteid)#">#application.rbFactory.getKeyValue(session.rb,"dashboard.session.next")#&nbsp;&raquo;</a></li>
		</cfif>
	</ul>
	</div>
</cfif>	
</cfoutput>



