<cfset chain=$.getBean('approvalChain').loadBy(chainId=rc.chainID)>
<cfset members=chain.getMembershipsIterator()>
<cfset hasChangesets=application.settingsManager.getSite(rc.siteID).getHasChangesets()>
<cfinclude template="dsp_secondary_menu.cfm">
<cfoutput>
<h2>#application.rbFactory.getKeyValue(session.rb,'approvalchains.pendingrequests')#</h2>

<h3>#tempEncodeForHTML(chain.getName())#</h3>
<p>#tempEncodeForHTML(chain.getDescription())#</p>

<cfif members.hasNext()>
	<cfloop condition="members.hasNext()">
		<cfset member=members.next()>
		<h4>#members.getRecordIndex()#. #tempEncodeForHTML(member.getGroup().getGroupName())#</h4>
		<cfset requests=member.getPendingContentIterator()>
	
		<table class="mura-table-grid">
		    <tr> 
		      <th class="var-width">#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.title')#</th>
		      <cfif hasChangesets>
		          	<th>#application.rbFactory.getKeyValue(session.rb,'approvalchains.changeset')#</th>
		          </cfif>
		      <th> Request By</th>
		      <th> Request Date</th>
		      <th class="actions">&nbsp;</th>
		    </tr>
		    <cfif requests.hasNext()>
		     <cfloop condition="requests.hasNext()">
			    <cfsilent>
			      <cfset item=requests.next()>
			      <cfset editlink="./?muraAction=cArch.edit&contenthistid=#item.getContentHistID()#&contentid=#item.getContentID()#&type=#item.getType()#&parentid=#item.getParentID()#&siteid=#tempEncodeForURL(item.getSiteID())#&moduleid=#item.getModuleID()#&return=chain">
			    </cfsilent>
		        <tr>  
		          <td class="title var-width">#$.dspZoom(item.getCrumbArray())#</td>
		          <cfif hasChangesets>
		          	<td>
		          		<cfif isDate(item.getchangesetPublishDate())><a href="##" rel="tooltip" title="#tempEncodeForHTMLAttribute(LSDateFormat(item.getchangesetPublishDate(),"short"))#"> <i class="icon-calendar"></i></a></cfif>
		          		<a href="./?muraAction=cChangesets.assignments&siteID=#item.getSiteID()#&changesetID=#item.getChangeSetID()#">#tempEncodeForHTML(item.getChangesetName())#</a></td>
		          </cfif>
		          <td>#tempEncodeForHTML(item.getLastUpdateBy())#</td>
		          <td>#LSDateFormat(item.getCreated(),session.dateKeyFormat)# #LSTimeFormat(item.getCreated(),"medium")#</td>
		           <td class="actions">
		            <ul>
		           
		              <li class="edit"><a title="Edit" href="#editlink#"><i class="icon-pencil"></i></a></li>  
		              <cfswitch expression="#item.getType()#">
						<cfcase value="Page,Folder,Calendar,Gallery,Link,File">
							<cfset previewURL='http://#application.settingsManager.getSite(rc.siteid).getDomain()##application.configBean.getServerPort()##application.configBean.getContext()##$.getURLStem(rc.siteid,item.getFilename())#?previewid=#item.getContentHistID()#'>
							<cfif rc.compactDisplay eq 'true'>
								<li class="preview"><a title="#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.preview')#" href="##" onclick="frontEndProxy.post({cmd:'setLocation',location:encodeURIComponent('#tempEncodeForJavascript(previewURL)#')});return false;"><i class="icon-globe"></i></a></li>
							<cfelse>
								<li class="preview"><a title="#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.preview')#" href="##" onclick="return preview('#previewURL#','');"><i class="icon-globe"></i></a></li>
							</cfif>
						</cfcase>
						</cfswitch>
						 <li class="version-history"><a title="Version History" href="./?muraAction=cArch.hist&contentid=#item.getContentID()#&type=#item.getType()#&parentid=#item.getParentID()#&siteid=#tempEncodeForURL(item.getSiteID())#&moduleid=#item.getModuleID()#"><i class="icon-book"></i></a></li>
		            </ul>
		          </td>
		        </tr>
		      </cfloop>
		      <cfelse>
		      <tr> 
		        <td <cfif hasChangesets>colspan="5"<cfelse>colspan="4"</cfif> class="results"><em>This group has no pending approvals in this chain.</em></td>
		      </tr>
		    </cfif>
		</table>

	</cfloop>
<cfelse>
	<p>This approvals chain has no group assignents.</p>
</cfif>


</cfoutput>