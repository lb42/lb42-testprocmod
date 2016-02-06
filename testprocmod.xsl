<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="tei"
                xpath-default-namespace="http://www.tei-c.org/ns/1.0"
                version="2.0">
   <xsl:output method="xhtml"
               omit-xml-declaration="yes"
               doctype-system="about:legacy-compat"/>
   <xsl:key name="ALL-EXTRENDITION"
            match="@rendition[not(starts-with(.,'simple:') or starts-with(.,'#'))]"
            use="1"/>
   <xsl:key name="EXTRENDITION"
            match="@rendition[not(starts-with(.,'simple:') or starts-with(.,'#'))]"
            use="."/>
   <xsl:key name="ALL-LOCALRENDITION" match="tei:rendition" use="1"/>
   <xsl:template match="choice">
      <xsl:choose>
         <xsl:when test="sic and corr">
            <span class="alternate choice1" title="alternate">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates select="corr[@cert='high']"/>
               <span class="hidden altcontent ">
                  <xsl:if test="@xml:id">
                     <xsl:attribute name="id" select="@xml:id"/>
                  </xsl:if>
                  <xsl:apply-templates select="sic"/>
               </span>
            </span>
         </xsl:when>
         <xsl:when test="abbr and expan">
            <span class="alternate choice2" title="alternate">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates select="expan[1]"/>
               <span class="hidden altcontent ">
                  <xsl:if test="@xml:id">
                     <xsl:attribute name="id" select="@xml:id"/>
                  </xsl:if>
                  <xsl:apply-templates select="abbr"/>
               </span>
            </span>
         </xsl:when>
         <xsl:when test="orig and reg">
            <span class="alternate choice3" title="alternate">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates select="reg"/>
               <span class="hidden altcontent ">
                  <xsl:if test="@xml:id">
                     <xsl:attribute name="id" select="@xml:id"/>
                  </xsl:if>
                  <xsl:apply-templates select="orig"/>
               </span>
            </span>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="anchor">
      <xsl:variable name="cId">
         <xsl:value-of select="generate-id(.)"/>
      </xsl:variable>
      <sup>
         <xsl:element name="a">
            <xsl:attribute name="class">anchor</xsl:attribute>
            <xsl:attribute name="name">A<xsl:value-of select="$cId"/>
            </xsl:attribute>
            <xsl:attribute name="href">#N<xsl:value-of select="$cId"/>
            </xsl:attribute>
            <xsl:number level="any"/>
         </xsl:element>
      </sup>
   </xsl:template>
   <xsl:template match="ab">
      <div class="ab">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="lb">
      <span class="lb">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:value-of select="@n"/>
      </span>
   </xsl:template>
   <xsl:template match="pb">
      <span class="pb">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:value-of select="@facs"/>
      </span>
   </xsl:template>
   <xsl:template match="cb">
      <span class="cb">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="cell">
      <td class="cell">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </td>
   </xsl:template>
   <xsl:template match="cit">
      <div class="cit">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="text">
      <html>
         <xsl:apply-templates/>
      </html>
   </xsl:template>
   <xsl:template match="figure">
      <xsl:choose>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="string(@facs)">
                  <img class="figure">
                     <xsl:attribute name="src">
                        <xsl:value-of select="@facs"/>
                     </xsl:attribute>
                  </img>
               </xsl:when>
               <xsl:otherwise>
                  <div class="figure">
                     <xsl:apply-templates/>
                  </div>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="g"/>
   <xsl:template match="graphic">
      <img src="{@url}">
         <xsl:variable name="sizes">
            <xsl:if test="@width">
               <xsl:value-of select="concat('width:',@width,';')"/>
            </xsl:if>
            <xsl:if test="@height">
               <xsl:value-of select="concat('height:',@height,';')"/>
            </xsl:if>
         </xsl:variable>
         <xsl:if test="not($sizes='')">
            <xsl:attribute name="style" select="$sizes"/>
         </xsl:if>
      </img>
   </xsl:template>
   <xsl:template match="head">
      <xsl:choose>
         <xsl:when test="parent::div[@type='chapter']">
            <xsl:variable name="depth">"chapter"</xsl:variable>
            <xsl:element name="{concat('h',&#34;chapter&#34;)}">
               <xsl:attribute name="class">head</xsl:attribute>
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:when>
         <xsl:when test="parent::div[not(@type)]">
            <xsl:variable name="depth">"part"</xsl:variable>
            <xsl:element name="{concat('h',&#34;part&#34;)}">
               <xsl:attribute name="class">head</xsl:attribute>
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:when>
         <xsl:when test="parent::lg">
            <xsl:variable name="depth">"verse"</xsl:variable>
            <xsl:element name="{concat('h',&#34;verse&#34;)}">
               <xsl:attribute name="class">head</xsl:attribute>
               <xsl:apply-templates/>
            </xsl:element>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="quote">
      <xsl:choose>
         <xsl:when test="ancestor::p">
            <span class="quote1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <div class="quote2">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:apply-templates/>
            </div>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="list">
      <ul class="list">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </ul>
   </xsl:template>
   <xsl:template match="item">
      <div class="item">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="ref">
      <a class="ref" href="{}">
         <xsl:apply-templates/>
      </a>
   </xsl:template>
   <xsl:template match="teiHeader">
      <head>
         <link rel="StyleSheet" href="simple.css" type="text/css"/>
         <style type="text/css">div.ab {border-style: solid; border-width: medium;}
span.quote1 {font-style: italic;}
div.quote2 {left-margin: 2em;}
p.quote {font-style:italic;}
</style>
         <xsl:call-template name="localRendition"/>
         <script type="text/javascript"
                 charset="utf-8"
                 src="http://code.jquery.com/jquery-1.10.2.min.js"/>
         <link rel="stylesheet"
               href="http://code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css"/>
         <script type="text/javascript"
                 src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"/>
         <link rel="stylesheet"
               href="http://jqueryui.com/tooltip/resources/demos/style.css"/>
         <script type="text/javascript" charset="utf-8" src="simple.js"/>
         <xsl:apply-templates/>
      </head>
   </xsl:template>
   <xsl:template match="note">
      <xsl:choose>
         <xsl:when test="ancestor::div[@type='ignoreMe']"/>
         <xsl:otherwise>
            <span class="note1">
               <xsl:if test="@xml:id">
                  <xsl:attribute name="id" select="@xml:id"/>
               </xsl:if>
               <xsl:value-of select="@n"/>
            </span>
            <xsl:variable name="place" select="'end'"/>
            <xsl:variable name="marker" select=""/>
            <xsl:variable name="class">note</xsl:variable>
            <xsl:variable name="number" select="2"/>
            <xsl:variable name="I" select="generate-id()"/>
            <xsl:variable name="N">
               <xsl:number from="text" level="any" count="note"/>
            </xsl:variable>
            <xsl:choose>
               <xsl:when test="$place='bottom'">
                  <sup class="footnotelink">
                     <a href="#{$I}">
                        <xsl:value-of select="if ($marker) then   $marker else $N"/>
                     </a>
                  </sup>
                  <div id="{$I}">
                     <xsl:attribute name="class">
                        <xsl:value-of select="($place, concat($class, $number))"/>
                     </xsl:attribute>
                     <xsl:apply-templates/>
                  </div>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:if test="string-length($marker)&gt;0">
                     <sup class="notelink">
                        <a href="#{$I}">
                           <xsl:value-of select="$marker"/>
                        </a>
                     </sup>
                  </xsl:if>
                  <span>
                     <xsl:attribute name="class">
                        <xsl:value-of select="($place, concat($class, $number))"/>
                     </xsl:attribute>
                     <xsl:if test="string-length($marker)&gt;0">
                        <xsl:attribute name="id" select="$I"/>
                        <sup class="notelink">
                           <xsl:value-of select="$marker"/>
                        </sup>
                     </xsl:if>
                     <xsl:apply-templates/>
                  </span>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="p">
      <p class="p">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   <xsl:template match="row">
      <tr class="row">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </tr>
   </xsl:template>
   <xsl:template match="div">
      <section class="div">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </section>
   </xsl:template>
   <xsl:template match="table">
      <table class="table">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </table>
   </xsl:template>
   <xsl:template match="title">
      <xsl:choose>
         <xsl:when test="parent::titleStmt">
            <title>
               <xsl:apply-templates/>
            </title>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="quote">
      <p class="quote">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   <xsl:template match="lg">
      <div class="lg">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="l">
      <div class="l">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="front">
      <div class="front">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="body">
      <div class="body">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template match="back">
      <div class="back">
         <xsl:if test="@xml:id">
            <xsl:attribute name="id" select="@xml:id"/>
         </xsl:if>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   <xsl:template name="localrendition">
      <xsl:if test="@rendition">
         <xsl:variable name="values">
            <xsl:for-each select="tokenize(normalize-space(@rendition),' ')">
               <xsl:choose>
                  <xsl:when test="starts-with(.,'#')">
                     <xsl:sequence select="concat('document_',substring-after(.,'#'))"/>
                  </xsl:when>
                  <xsl:when test="starts-with(.,'simple:')">
                     <xsl:sequence select="replace(.,':','_')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:for-each select="document(.)">
                        <xsl:sequence select="concat('external_',@xml:id)"/>
                     </xsl:for-each>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:variable>
         <xsl:attribute name="class">
            <xsl:value-of select="string-join($values,' ')"/>
         </xsl:attribute>
      </xsl:if>
   </xsl:template>
   <xsl:template name="localRendition">
      <xsl:if test="key('ALL-LOCALRENDITION',1)">
         <style type="text/css">
            <xsl:for-each select="key('ALL-LOCALRENDITION',1)">
               <xsl:text>
.document_</xsl:text>
               <xsl:value-of select="@xml:id"/>
               <xsl:if test="@scope">
                  <xsl:text>:</xsl:text>
                  <xsl:value-of select="@scope"/>
               </xsl:if>
               <xsl:text> {
	</xsl:text>
               <xsl:value-of select="."/>
               <xsl:text>
}</xsl:text>
            </xsl:for-each>
            <xsl:text/>
         </style>
      </xsl:if>
      <xsl:if test="key('ALL-EXTRENDITION',1)">
         <style type="text/css">
            <xsl:for-each select="key('ALL-EXTRENDITION',1)">
               <xsl:variable name="pointer">
                  <xsl:value-of select="."/>
               </xsl:variable>
               <xsl:for-each select="key('EXTRENDITION',$pointer)[1]">
                  <xsl:for-each select="document($pointer)">
                     <xsl:text>
.</xsl:text>
                     <xsl:value-of select="@xml:id"/>
                     <xsl:if test="@scope">
                        <xsl:text>:</xsl:text>
                        <xsl:value-of select="@scope"/>
                     </xsl:if>
                     <xsl:text> {
</xsl:text>
                     <xsl:value-of select="."/>
                     <xsl:text>
}</xsl:text>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
         </style>
      </xsl:if>
   </xsl:template>
   <xsl:function name="tei:escapeChars">
      <xsl:param name="letters"/>
      <xsl:param name="context"/>
      <xsl:value-of select="translate($letters,'ſ','s')"/>
   </xsl:function>
   <xsl:template match="text()" mode="#default plain">
      <xsl:choose>
         <xsl:when test="ancestor::*[@xml:space][1]/@xml:space='preserve'">
            <xsl:value-of select="tei:escapeChars(.,parent::*)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="context" select="name(parent::*)"/>
            <xsl:if test="matches(.,'^\s') and  normalize-space()!=''">
               <xsl:choose>
                  <xsl:when test="(parent::*/preceding-sibling::node()[1][name()=$context])">
                     <xsl:value-of select="' '"/>
                  </xsl:when>
                  <xsl:when test="position()=1"/>
                  <xsl:otherwise>
                     <xsl:value-of select="' '"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:if>
            <xsl:value-of select="tei:escapeChars(normalize-space(.),parent::*)"/>
            <xsl:choose>
               <xsl:when test="last()=1 and string-length()!=0 and      normalize-space()=''">
                  <xsl:value-of select="' '"/>
               </xsl:when>
               <xsl:when test="position()!=1 and position()!=last() and matches(.,'\s$')">
                  <xsl:value-of select="' '"/>
               </xsl:when>
               <xsl:when test="position()=1 and matches(.,'\s$') and normalize-space()!=''">
                  <xsl:value-of select="' '"/>
               </xsl:when>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
