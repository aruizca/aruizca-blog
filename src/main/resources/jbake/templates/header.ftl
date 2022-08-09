<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title><#if (content.title)??>${content.title}<#else>JBake</#if></title>

    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="keywords" content="">
    <meta name="generator" content="JBake">

    <!--Responsive Meta Tags-->
    <meta name="HandheldFriendly" content="True"/>
    <meta name="MobileOptimized" content="320"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!--Bing search engine validation-->
    <meta name="msvalidate.01" content="C6990C0351F7B20ED3C944A3BB3BECD9"/>

    <!--Styles, change style.css-->
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>vendor/bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=Poly|Roboto:400,700,300|Roboto+Condensed' rel='stylesheet' type="text/css">
    <link rel="stylesheet" type="text/css" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>css/style.css"/>
    <link rel="stylesheet" href="http://yandex.st/highlightjs/8.0/styles/googlecode.min.css">
    <style>
        #themecover_mobileworking_willsong {
            background: url(<#if (content.rootpath)??>${content.rootpath}<#else></#if>img/common/background.png) repeat-y;
            background-size: 100%;
            height: 100%;
            left: 0;
            position: fixed;
            top: 30px;
            width: 100%;
            z-index: -100;
        }
    </style>

    <!--Scripts-->
    <script src="//code.jquery.com/jquery-2.1.0.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script src="http://yandex.st/highlightjs/8.0/highlight.min.js"></script>


    <!-- Fav and touch icons -->
    <!--<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">-->
    <link rel="shortcut icon" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>favicon.ico">
</head>
   