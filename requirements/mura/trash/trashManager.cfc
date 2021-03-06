<cfcomponent extends="mura.cfobject" output="false">

<cfset variables.configBean="">

<cffunction name="setConfigBean" output="false">
<cfargument name="configBean">
<cfset variables.configBean=arguments.configBean>
</cffunction>

<cffunction name="empty" output="false">
	<cfset var rs=getQuery(argumentCollection=arguments)>
	<cfset var pluginEvent = createObject("component","mura.MuraScope") />
	
	<cfset pluginEvent=pluginEvent.init(arguments).getEvent()>
	<cfset pluginEvent.setValue("rsTrash",rs)>
	
	<cfif isdefined("arguments.siteID") and len(arguments.siteID)>
		<cfset getBean("pluginManager").announceEvent("onBeforeSiteEmptyTrash",pluginEvent)>
	<cfelse>
		<cfset getBean("pluginManager").announceEvent("onBeforeGlobalEmptyTrash",pluginEvent)>
	</cfif>
	
	 <cftransaction>
	
	<!--- CONTENT --->
	 <cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tcontentratings
		where contentID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tcontenteventreminders
		where contentID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tcontentassignments
		where contentID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
		or userID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tcontentcomments
		where contentID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tformresponsepackets
		where formID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tformresponsequestions
		where formID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<!--- CATEGORIES --->
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tcontentcategoryassign
		where categoryID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<!--- CONTENT USERGROUPS RELATIONSHIPS --->
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tpermissions
		where contentID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
		or groupID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<!--- USERS CATEGORY RELATIONSHIP--->
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tusersinterests
		where userID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
		or categoryID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<!--- USERS --->
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tuseraddresses
		where userID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	 <cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tusersfavorites
		where userID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tusersmemb
		where userID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
		or groupID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<!---MAILINGLISTS --->
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tmailinglistmembers
		where mlid in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<!---FEEDS --->
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tcontentfeeditems
		where feedID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tcontentfeedadvancedparams
		where feedID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<!--- ADVERTISING --->
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tadplacements
		where campaignID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tadplacements
		where placementID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tadplacementdetails
		where placementID not in (select placementID from tadplacements)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tadplacementcategoryassign
		where placementID not in (select placementID from tadplacements)
	</cfquery>
	
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from tadstats
		where placementID not in (select placementID from tadplacements)
	</cfquery>
	
	<!--- FILES --->
	<cfif isdefined("arguments.siteID") and len(arguments.siteID)>
		<cfset getBean('fileManager').purgeDeleted(arguments.siteID)>
	<cfelse>
		<cfset getBean('fileManager').purgeDeleted("")>
	</cfif>
	
	<!--- EMPTY TRASH TABLE--->
	<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		delete from ttrash
		where objectID in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#valueList(rs.objectID)#">)
	</cfquery>
	
	</cftransaction>

	<cfif isdefined("arguments.siteID") and len(arguments.siteID)>
		<cfset getBean("pluginManager").announceEvent("onAfterSiteEmptyTrash",pluginEvent)>
	<cfelse>
		<cfset getBean("pluginManager").announceEvent("onAfterGlobalEmptyTrash",pluginEvent)>
	</cfif>
	
</cffunction>

<cffunction name="throwIn" output="false">
<cfargument name="deleted">
	<cfset var $="">	
	<cfset var objectClass=listLast(getMetaData(arguments.deleted).name,".")>
	<cfset var idString="">
	<cfset var labelString="">
	<cfset var objectType="">
	<cfset var objectSubType="">
	<cfset var siteid="">
	<cfset var allValues="">
	<cfset var rs="">
	<cfset var i="">
	<cfset var rsRelated="">
	<cfset var muraDeleteDateTime="">
	
	<cfif isDate(arguments.deleted.getValue("muraDeleteDateTime"))>
		<cfset muraDeleteDateTime=arguments.deleted.getValue("muraDeleteDateTime")>
	<cfelse>
		<cfset muraDeleteDateTime=now()>
	</cfif>
	
	<cfif listFindNoCase("campaignBean,creativeBean",objectClass)>
		<cfset siteid=getBean('userManager').read(arguments.deleted.getUserID()).getSiteID()>
	<cfelseif objectClass eq "placementBean">
		<cfset siteid=getBean('userManager').read( getBean('advertiserManager').readCampaign(arguments.deleted.getCampaignID()).getUserID() ).getSiteID()>	
	<cfelse>
		<cfset siteid=arguments.deleted.getSiteID()>
	</cfif>
	
	<cfset $=getBean('MuraScope').init(siteid)>
	
	<!--- Package up extra stuff related to the contentBean --->
	<cfif objectClass eq "contentBean">
		
		<!--- Store display object assignments --->
		<cfloop from="1" to="8" index="i">
			<cfset arguments.deleted.getDisplayRegion(i)>
		</cfloop>
		
		<!--- Store related content --->
		<cfset rsRelated=arguments.deleted.getRelatedContentQuery()>
		<cfif rsRelated.recordcount>
			<cfset arguments.deleted.setValue(  "relatedContentID"  ,  valueList( rsRelated.contentID ) ) >
		</cfif>
		<!--- store categories --->
		<cfset arguments.deleted.setValue("categoriesFromMuraTrash",  getBean("contentManager").getCategoriesByHistID( arguments.deleted.getContentHistID() )  )>
	</cfif>
	
	<cfwddx action="cfml2wddx" input="#arguments.deleted.getAllValues()#" output="allValues">

	<cfif objectType eq "userBean">
		<cfif arguments.deleted.getType() eq 1>
			<cfset labelString=getLabelString("groupBean")>
			<cfset idString=getIDString("groupBean")>
		<cfelse>
			<cfset labelString=getLabelString("userBean")>
			<cfset idString=getIDString("userBean")>
		</cfif>
	<cfelse>
		<cfset labelString=getLabelString(objectClass)>
		<cfset idString=getIDString(objectClass)>
	</cfif>
	
	<cfif structKeyExists(arguments.deleted,"getType")>
		<cfset objectType=arguments.deleted.getType()>
	<cfelse>
		<cfset objectType=$.setProperCase(replaceNoCase(objectClass,"Bean",""))>
	</cfif>
	
	<cfif objectType eq "1">
		<cfset objectType="Group">
	<cfelseif objectType eq "2">
		<cfset objectType="User">
	</cfif>
	
	<cfif structKeyExists(arguments.deleted,"getSubType")>
		<cfset objectSubType=arguments.deleted.getSubType()>
	<cfelse>
		<cfset objectSubType="Default">
	</cfif>
	
	<cfif len(idString)>
		<cfquery name="rs" datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
			select objectID from ttrash where objectID =<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('arguments.deleted.get#IDString#()')#" />
		</cfquery>
		
		<cfif not rs.recordcount>
			<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
				insert into ttrash (objectID,parentID,siteID,objectClass,objectLabel,objectType,objectSubType,objectString,deletedDate,deletedBy)
					values(	
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('arguments.deleted.get#IDString#()')#" />,
						<cfif structKeyExists(arguments.deleted,"getParentID")>
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.deleted.getParentID()#" />
						<cfelseif objectClass eq "addressBean">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.deleted.getUserID()#" />
						<cfelseif objectClass eq "placementBean">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.deleted.getCampaignID()#" />
						<cfelse>
							'NA'
						</cfif>,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#siteid#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#objectClass#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('arguments.deleted.get#LabelString#()')#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#objectType#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#objectSubType#" />,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#allValues#" />,
						<cfqueryparam cfsqltype="cf_sql_timestamp" value="#muraDeleteDateTime#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#left($.currentUser('fullname'),50)#" />
					)			
			</cfquery>
		</cfif>
	</cfif>

</cffunction>

<cffunction name="getTrashItem" output="false">
<cfargument name="objectID">
<cfreturn getIterator(objectID=arguments.objectID).next()>
</cffunction>

<cffunction name="getObject" output="false">
<cfargument name="objectID">
	<cfset var rs="">
	<cfset var retrieved="">
	<cfset var allValues="">
	
	<cfquery name="rs" datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		select objectID,parentID,siteID,objectClass,objectLabel,objectType,objectSubType,objectString,deletedDate,deletedBy from ttrash where objectID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectID#" />				
	</cfquery>
	
	<cfif rs.recordcount>
		<cfset retrieved=getBean(rs.objectClass)>
		<cfwddx action = "wddx2cfml" input = "#rs.objectstring#" output = "allValues">
		<cfset allValues.fromMuraTrash=true>
		<cfset allValues.muraDeleteDateTime=rs.deletedDate>
		<cfset allValues.extendData="">
		<cfset retrieved.setAllValues(allValues)>
	</cfif>
	
	<cfreturn retrieved>
	
</cffunction>

<cffunction name="getQuery" output="false">
	<cfset var rs="">
	
	<cfquery name="rs" datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
		select objectID,siteID,parentID,objectClass,objectType,objectSubType,objectLabel,deletedDate,deletedBy 
		from ttrash where 
		1=1
		<cfif structKeyExists(arguments,"sinceDate")>
		and deletedDate >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.sinceDate#">
		</cfif>	
		<cfif structKeyExists(arguments,"objectID")>
		and objectID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectID#">
		</cfif>
		<cfif structKeyExists(arguments,"parentID")>
		and parentID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.parentID#">
		</cfif>	
		<cfif structKeyExists(arguments,"siteID")>
		and siteID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.siteID#">
		</cfif>
		<cfif structKeyExists(arguments,"objectType")>
		and objectType=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectType#">
		</cfif>	
		<cfif structKeyExists(arguments,"objectSubType")>
		and objectSubType=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectSubType#">
		</cfif>	
		<cfif structKeyExists(arguments,"objectClass")>
		and objectClass=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectClass#">
		</cfif>	
		<cfif structKeyExists(arguments,"deletedBy")>
		and deletedBy=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.deletedBy#">
		</cfif>
		<cfif structKeyExists(arguments,"objectLabel")>
		and objectClass=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.objectLabel#">
		</cfif>
		<cfif structKeyExists(arguments,"deletedDate") and isDate(arguments.deletedDate)>
		and deletedDate=<cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.deletedDate#">
		</cfif>		
		
		<cfif structKeyExists(arguments,"keywords") and len(arguments.keywords)>
			and (
			objectClass like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keywords#%">
			or objectSubType like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keywords#%">
			or objectType like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keywords#%">
			or deletedBy like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keywords#%">
			or siteID like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keywords#%">
			or objectLabel like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keywords#%">
			)
		</cfif>
		
		order by deletedDate desc		
	</cfquery>
	
	<cfreturn rs>
	
</cffunction>

<cffunction name="getIterator" output="false">
	<cfset var rs=getQuery(argumentCollection=arguments)>
	<cfset var it=createObject("component","trashIterator").init()>
	<cfset it.setTrashManager(this)>
	<cfset it.setQuery(rs)>
	<cfreturn it>
</cffunction>

<cffunction name="takeOut" output="false">
<cfargument name="restored" hint="Object that has been pulled from trash and has since been saved">

	<cfset var data="">
	<cfset var i="">
	<cfset var objectClass=listLast(getMetaData(arguments.restored).name,".")>
	<cfset var idString=getIDString(objectClass)>
	<cfset var doPurge=false>
	<cfset var it="">
	<cfset var item="">
	
	<cfif structKeyExists(arguments.restored,"getValue")>
		<cfif arguments.restored.getValue("fromMuraTrash") eq "true">
			<cfset doPurge=true>
		</cfif>
	<cfelse>
		<cfset data=arguments.restored.getAllValues()>
		<cfif structKeyExists(data,"fromMuraTrash")>
			<cfset doPurge=true>
		</cfif>
	</cfif>
	
	<cfif doPurge>
		<cfif not isStruct(data)>
			<cfset data=arguments.restored.getAllValues()>
		</cfif>
		<cfloop collection="#data#" item="i">
			<!--- If the values is a uuid try an restore it just in case it's a fileid --->
			<cfif isSimpleValue(data[i]) and isValid("UUID",data[i])>
				<cfset getBean('fileManager').restoreVersion(data[i])>
			</cfif>
		</cfloop>
		
		<cfquery datasource="#variables.configBean.getDatasource()#" password="#variables.configBean.getDbPassword()#" username="#variables.configBean.getDbUsername()#">
			delete from ttrash where objectID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('arguments.restored.get#IDString#()')#" />		
		</cfquery>
		
		<cfif objectClass eq "contentBean">
			<cfset it=getIterator(parentID=arguments.restored.getContentID(), deletedDate=arguments.restored.getvalue("muraDeleteDateTime"))>
			<cfset it.end()>
			<cfloop condition="it.hasPrevious()">
				<cfset item=it.previous().getObject().save()>
			</cfloop>
		<cfelseif objectClass eq "categoryBean">
			<cfset it=getIterator(parentID=arguments.restored.getCategoryID(), deletedDate=arguments.restored.getvalue("muraDeleteDateTime"))>
			<cfloop condition="it.hasNext()">
				<cfset it.next().getObject().save()>
			</cfloop>
		<cfelseif objectClass eq "userBean">
			<cfset it=getIterator(parentID=arguments.restored.getUserID(), deletedDate=arguments.restored.getvalue("muraDeleteDateTime"))>
			<cfloop condition="it.hasNext()">
				<cfset it.next().getObject().save()>
			</cfloop>
		<cfelseif objectClass eq "campaignBean">
			<cfset it=getIterator(parentID=arguments.restored.getCampaignID(), deletedDate=arguments.restored.getvalue("muraDeleteDateTime"))>
			<cfloop condition="it.hasNext()">
				<cfset it.next().getObject().save()>
			</cfloop>
		<cfelseif objectClass eq "contentComment">
			<cfset it=getIterator(parentID=arguments.restored.getCommentID(), deletedDate=arguments.restored.getvalue("muraDeleteDateTime"))>
			<cfloop condition="it.hasNext()">
				<cfset it.next().getObject().save()>
			</cfloop>
		</cfif>
	</cfif>
</cffunction>

<cffunction name="getIDString" output="false">
<cfargument name="objectClass">

	<cfswitch expression="#arguments.objectClass#">
	
		<cfcase value="contentBean">
			<cfreturn "contentID">
		</cfcase>
		
		<cfcase value="contentCommentBean">
			<cfreturn "commentID">
		</cfcase>
		
		<cfcase value="feedBean">
			<cfreturn "feedID">
		</cfcase>
		
		<cfcase value="userBean">
			<cfreturn "userID">
		</cfcase>
		
		<cfcase value="addressBean">
			<cfreturn "addressID">
		</cfcase>
		
		<cfcase value="emailBean">
			<cfreturn "emailID">
		</cfcase>
		
		<cfcase value="settingsBean">
			<cfreturn "siteID">
		</cfcase>
		
		<cfcase value="changesetBean">
			<cfreturn "changesetID">
		</cfcase>
		
		<cfcase value="adzoneBean">
			<cfreturn "adZoneID">
		</cfcase>
		
		<cfcase value="campaignBean">
			<cfreturn "campaignID">
		</cfcase>
		
		<cfcase value="placementBean">
			<cfreturn "placementID">
		</cfcase>
		
		<cfcase value="creativeBean">
			<cfreturn "creativeID">
		</cfcase>
		
		<cfcase value="categoryBean">
			<cfreturn "categoryID">
		</cfcase>
		
		<cfcase value="mailinglistBean">
			<cfreturn "mlid">
		</cfcase>
		
		<cfcase value="extendObject">
			<cfreturn "id">
		</cfcase>
		
		<cfdefaultcase>
			<cfreturn "">
		</cfdefaultcase>
	</cfswitch>
</cffunction>

<cffunction name="getLabelString" output="false">
<cfargument name="objectClass">

	<cfswitch expression="#arguments.objectClass#">
	
		<cfcase value="contentBean">
			<cfreturn "title">
		</cfcase>
		
		<cfcase value="contentCommentBean">
			<cfreturn "name">
		</cfcase>
		
		<cfcase value="feedBean">
			<cfreturn "name">
		</cfcase>
		
		<cfcase value="changesetBean">
			<cfreturn "name">
		</cfcase>
		
		<cfcase value="userBean">
			<cfreturn "username">
		</cfcase>
		
		<cfcase value="addressBean">
			<cfreturn "addressname">
		</cfcase>
		
		<cfcase value="groupBean">
			<cfreturn "groupname">
		</cfcase>
		
		<cfcase value="settingsBean">
			<cfreturn "site">
		</cfcase>
		
		<cfcase value="adzoneBean">
			<cfreturn "name">
		</cfcase>
		
		<cfcase value="campaignBean">
			<cfreturn "name">
		</cfcase>
		
		<cfcase value="placementBean">
			<cfreturn "placementID">
		</cfcase>
		
		<cfcase value="creativeBean">
			<cfreturn "name">
		</cfcase>
		
		<cfcase value="emailBean">
			<cfreturn "subject">
		</cfcase>
		
		<cfcase value="categoryBean">
			<cfreturn "name">
		</cfcase>
		
		<cfcase value="mailinglistBean">
			<cfreturn "name">
		</cfcase>
		
		<cfcase value="extendObject">
			<cfreturn "subtype">
		</cfcase>
		
		<cfdefaultcase>
			<cfreturn "">
		</cfdefaultcase>
	</cfswitch>
</cffunction>

</cfcomponent>