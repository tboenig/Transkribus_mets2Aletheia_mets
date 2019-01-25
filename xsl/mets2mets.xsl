<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ns3="http://www.loc.gov/METS/"
    xmlns="https://transkribus.eu/Schema" xmlns:ns2="http://www.w3.org/1999/xlink"
    xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="xs ns3 ns2 #default"
    version="2.0">

    <xsl:variable name="IMG" select="replace(@ID, 'IMG', 'Master')"/>

    <xsl:template
        match="trpDocMetadata | docId | title | uploadTimestamp | scriptType | uploader | uploaderId | nrOfPages | pageId | url | thumbUrl | externalId | authority | language | status | fimgStoreColl | localFolder | createdFromTimestamp | createdToTimestamp | origDocId | collectionList | colList | colId | colName | description | crowdsourcing | elearning | nrOfDocuments">
        <xsl:element name="{local-name()}" namespace="https://transkribus.eu/Schema">
            <xsl:apply-templates select="@*, node()"/>
        </xsl:element>
    </xsl:template>
    
   
    <xsl:template match="ns3:fptr">
        <xsl:choose>
            <xsl:when test="starts-with(ns3:area/@FILEID, 'ALTO')"/>
            
            <xsl:when test="ns3:area">
                <xsl:element name="{local-name()}" namespace="http://www.loc.gov/METS/">
                    <xsl:attribute name="FILEID">
                        <xsl:value-of select="ns3:area/@FILEID"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="ns3:fileGrp[@ID = 'MASTER']">
        <xsl:element name="fileGrp" xmlns="http://www.loc.gov/METS/">
            <xsl:attribute name="USE">Binary</xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ns3:structMap/ns3:div">
        <xsl:element name="div" xmlns="http://www.loc.gov/METS/">
            <xsl:attribute name="ID"><xsl:value-of select="@ID"/></xsl:attribute>
            <xsl:attribute name="ADMID"><xsl:value-of select="@ADMID"/></xsl:attribute>
            <xsl:attribute name="TYPE">sequence</xsl:attribute>
        
           <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="ns3:amdSec/ns3:sourceMD/ns3:mdWrap">
        <xsl:element name="mdWrap" xmlns="http://www.loc.gov/METS/">
            <xsl:attribute name="ID"><xsl:value-of select="@ID"/></xsl:attribute>
            <xsl:attribute name="MDTYPE"><xsl:value-of select="@MDTYPE"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="ns3:fileGrp[@ID = 'ALTO']"/>
    
    <xsl:template match="ns3:structMap/ns3:div/ns3:div/ns3:fptr/ns3:area">
        <xsl:choose>
            <xsl:when test="starts-with(@FILEID, 'ALTO')"/>
            <xsl:otherwise>
                Hallo
            </xsl:otherwise>
        </xsl:choose>
            
    </xsl:template>
    
    
    

    <xsl:template match="@ns2:*">
        <xsl:attribute name="xlink:{local-name()}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>



    <xsl:template match="ns3:*">
        <xsl:element name="{local-name()}" namespace="http://www.loc.gov/METS/">
            <xsl:apply-templates select="@*, node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@*">
        <xsl:choose>
            <xsl:when test=". = 'IMG'">
                <xsl:attribute name="ID">Master</xsl:attribute>
            </xsl:when>
            <xsl:when test=". = 'OTHER'">
                <xsl:attribute name="LOCTYPE">URL</xsl:attribute>
            </xsl:when>
            <xsl:when test=". = 'PAGEXML'">
                <xsl:attribute name="USE">PageContent</xsl:attribute>
            </xsl:when>
            <xsl:when test=". = 'MANUSCRIPT'">
                <xsl:attribute name="TYPE">physical</xsl:attribute>
            </xsl:when>
            <xsl:when test=". = 'SINGLE_PAGE'">
                <xsl:attribute name="TYPE">page</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>

                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="node()">
        <xsl:copy>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
