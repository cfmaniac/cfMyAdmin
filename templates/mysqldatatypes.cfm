<cfsetting enablecfoutputonly="Yes">

<cfset tableTypeList = "&lt;Automatic&gt;,ISAM,MyISAM,HEAP,MERGE,InnoDB,BDB,Gemini">
<cfset fieldTypes = ArrayNew(1)>

<!--- TINYINT --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "TINYINT">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "yes">
<cfset fieldTypes[insertPos].bZeroFillOption = "yes">

<!--- SMALLINT --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "SMALLINT">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "yes">
<cfset fieldTypes[insertPos].bZeroFillOption = "yes">

<!--- MEDIUMINT --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "MEDIUMINT">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "yes">
<cfset fieldTypes[insertPos].bZeroFillOption = "yes">

<!--- INT --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "INT">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "yes">
<cfset fieldTypes[insertPos].bZeroFillOption = "yes">

<!--- BIGINT --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "BIGINT">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "yes">
<cfset fieldTypes[insertPos].bZeroFillOption = "yes">

<!--- FLOAT --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "FLOAT">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "yes">

<!--- DOUBLE --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "DOUBLE">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "yes">

<!--- DECIMAL --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "DECIMAL">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "yes">

<!--- DATE --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "DATE">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- DATETIME --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "DATETIME">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- TIMESTAMP --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "TIMESTAMP">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- TIME --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "TIME">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- YEAR --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "YEAR">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- CHAR --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "CHAR">
<cfset fieldTypes[insertPos].bBinaryOption = "yes">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- VARCHAR --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "VARCHAR">
<cfset fieldTypes[insertPos].bBinaryOption = "yes">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- TINYBLOB --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "TINYBLOB">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- TINYTEXT --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "TINYTEXT">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- TEXT --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "TEXT">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- BLOB --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "BLOB">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- MEDIUMBLOB --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "MEDIUMBLOB">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- MEDIUMTEXT --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "MEDIUMTEXT">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- LONGBLOB --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "LONGBLOB">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- LONGTEXT --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "LONGTEXT">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- ENUM --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "ENUM">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<!--- SET --->
<cfset insertPos = ArrayLen(fieldTypes) + 1>
<cfset fieldTypes[insertPos] = StructNew()>
<cfset fieldTypes[insertPos].fieldType = "SET">
<cfset fieldTypes[insertPos].bBinaryOption = "no">
<cfset fieldTypes[insertPos].bUnsignedOption = "no">
<cfset fieldTypes[insertPos].bZeroFillOption = "no">

<cfsetting enablecfoutputonly="No">
