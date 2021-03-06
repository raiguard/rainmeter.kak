hook global BufCreate .*[.](ini|inc) %{
    # TODO: Somehow validate that it's a Rainmeter file
    set-option buffer filetype rainmeter
}

hook global WinSetOption filetype=rainmeter %{
    require-module rainmeter
}

hook -group rainmeter-highlight global WinSetOption filetype=rainmeter %{
    add-highlighter window/rainmeter ref rainmeter
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/rainmeter }
}

provide-module rainmeter %{
    add-highlighter shared/rainmeter regions
    add-highlighter shared/rainmeter/code default-region group
    add-highlighter shared/rainmeter/comment region ";" $ fill comment
    add-highlighter shared/rainmeter/string region '"' '("|$)' fill string
    add-highlighter shared/rainmeter/string_single region "'" "('|$)" fill string
    add-highlighter shared/rainmeter/variable_nested_section region -recurse "\[" "\[&" "\]" fill module
    add-highlighter shared/rainmeter/variable_nested region -recurse "\[" "\[(\\|#|\$)" "\]" fill variable
    add-highlighter shared/rainmeter/variable_classic region "#" "(#|$)" fill variable
    add-highlighter shared/rainmeter/variable_mouse region "\$" "(\$|$)" fill variable
    add-highlighter shared/rainmeter/variable_section region -recurse "\[" "\[\w" "\]" fill module

    # TODO: Variables within strings

    # SOURCE: https://github.com/poiru/rainlexer/blob/5600b054e0849c91e83ba816e229645ca01d0204/Config/Default/RainLexer.xml

add-highlighter shared/rainmeter/code/bang regex (?i)(!(about|activateconfig|addblur|autoselectscreen|autoselectscreengroup|clearmouseaction|clearmouseactiongroup|clearmouseactionskingroup|clickthrough|clickthroughgroup|commandmeasure|deactivateconfig|deactivateconfiggroup|delay|disablemeasure|disablemeasuregroup|disablemouseaction|disablemouseactiongroup|disablemouseactionskingroup|draggable|draggablegroup|editskin|enablemeasure|enablemeasuregroup|enablemouseaction|enablemouseactiongroup|enablemouseactionskingroup|fadeduration|fadedurationgroup|hide|hideblur|hidefade|hidefadegroup|hidegroup|hidemeter|hidemetergroup|keeponscreen|keeponscreengroup|loadlayout|log|manage|move|movemeter|pausemeasure|pausemeasuregroup|quit|redraw|redrawgroup|refresh|refreshapp|refreshgroup|removeblur|resetstats|setclip|setoption|setoptiongroup|settransparency|settransparencygroup|setvariable|setvariablegroup|setwallpaper|show|showblur|showfade|showfadegroup|showgroup|showmeter|showmetergroup|skincustommenu|skinmenu|snapedges|snapedgesgroup|toggle|toggleblur|toggleconfig|togglefade|togglefadegroup|togglegroup|togglemeasure|togglemeasuregroup|togglemeter|togglemetergroup|togglemouseaction|togglemouseactiongroup|togglemouseactionskingroup|togglepausemeasure|togglepausemeasuregroup|traymenu|unpausemeasure|unpausemeasuregroup|update|updategroup|updatemeasure|updatemeasuregroup|updatemeter|updatemetergroup|writekeyvalue|zpos|zposgroup)) 1:function
    add-highlighter shared/rainmeter/code/header regex ^\s*(\[.*?\])$ 1:module
    add-highlighter shared/rainmeter/code/operator regex (=|\+|-|<|>|&|\|\?|:) 1:operator
    add-highlighter shared/rainmeter/code/number regex (-)?(\d+) 1:value 2:value

    # Highlighted when followed by an equals sign
    add-highlighter shared/rainmeter/code/keyword_literal regex (?i)^\s*(@include|accuratetext|active|adddaystohours|alphavalue|alwaysontop|anchorx|anchory|angle|antialias|author|autoscale|autoselectscreen|averagesize|background|backgroundmargins|backgroundmode|bandidx|bands|barborder|barcolor|barimage|beveltype|bitmapdigits|bitmapextend|bitmapframes|bitmapimage|bitmapseparation|bitmaptransitionframes|bitmapzeroframe|blacklist|blur|blurregion|bothcolor|bothgreyscale|bothimage|bothimagealpha|bothimagecolormatrix1|bothimagecolormatrix2|bothimagecolormatrix3|bothimagecolormatrix4|bothimagecolormatrix5|bothimagecrop|bothimageflip|bothimagepath|bothimagerotate|bothimagetint|buttoncommand|buttonimage|category|clickthrough|clipstring|clipstringh|clipstringw|codepage|colormatrix1|colormatrix2|colormatrix3|colormatrix4|colormatrix5|configeditor|container|contextaction|contexttitle|controlangle|controllength|controlstart|coretempindex|count|counter|cumulative|daylightsavingtime|debug|debug2file|decodecharacterreference|defaultalphavalue|defaultalwaysontop|defaultanchorx|defaultanchory|defaultautoselectscreen|defaultclickthrough|defaultdraggable|defaultfadeduration|defaulthideonmouseover|defaultkeeponscreen|defaultsaveposition|defaultsnapedges|defaultstarthidden|defaultupdatedivider|defaultvalue|defaultwindowx|defaultwindowy|desktopworkarea|desktopworkareatype|destaddress|disabled|disabledragging|disableleadingzero|disableversioncheck|diskquota|download|downloadfile|draggable|draggroup|dragmargins|drive|dynamicvariables|dynamicwindowsize|endvalue|errorstring|extensions|fadeduration|fftattack|fftdecay|fftidx|fftoverlap|fftsize|filefilter|fill|finishaction|flags|flip|focusdismiss|folder|fontcolor|fonteffectcolor|fontface|fontsize|fontweight|forcereload|format|formatlocale|formula|freqmax|freqmin|gradientangle|greyscale|group|h|hardwareacceleration|header|hidden|hideextensions|hideonmouseover|highbound|horizontal|horizontallinecolor|horizontallines|iconpath|id|ifaboveaction|ifabovevalue|ifbelowaction|ifbelowvalue|ifcondition|ifconditionmode|ifequalaction|ifequalvalue|iffalseaction|ifmatch|ifmatchaction|ifmatchmode|ifnotmatchaction|iftrueaction|ignorecount|ignoreremovable|ignorewarnings|imagealpha|imagecrop|imagename|imagepath|imagerotate|imagetint|includehiddenfiles|includesubfolders|includesystemfiles|increment|index|information|inlinepattern|inputlimit|inputnumber|interface|invertmeasure|keeponscreen|label|language|leftmousedoubleclickaction|leftmousedownaction|leftmouseupaction|lengthshift|license|linecolor|linecount|linelength|linestart|linewidth|loadorder|logging|logsubstringerrors|loopcount|lowbound|maskimagename|maskimagepath|maskimagerotate|maxvalue|measurename|metadata|meterstyle|middlemousedoubleclickaction|middlemousedownaction|middlemouseupaction|minvalue|mouseactioncursor|mouseactioncursorname|mouseleaveaction|mouseoveraction|mousescrolldownaction|mousescrollleftaction|mousescrollrightaction|mousescrollupaction|name|numofdecimals|offsetx|offsety|onchangeaction|oncloseaction|onconnecterroraction|ondismissaction|ondownloaderroraction|onfocusaction|onrefreshaction|onregexperroraction|onunfocusaction|onupdateaction|onwakeaction|outputfile|padding|parameter|parent|password|path|pathname|paused|peakattack|peakdecay|peakgain|percent|percentual|pidtoname|playerpath|plugin|postfix|prefix|preserveaspectratio|primarycolor|primarycolormatrix1|primarycolormatrix2|primarycolormatrix3|primarycolormatrix4|primarycolormatrix5|primarygreyscale|primaryimage|primaryimagealpha|primaryimagecrop|primaryimagepath|primaryimagerotate|primaryimagetint|processname|processor|program|proxyserver|rawvalue|recursive|regexp|regexpfilter|regexpsubstitute|regkey|regvalue|rightmousedoubleclickaction|rightmousedownaction|rightmouseupaction|rmsattack|rmsdecay|rmsgain|rollup|rotationangle|saveposition|scale|scalemargins|scriptfile|secondarycolor|secondarycolormatrix1|secondarycolormatrix2|secondarycolormatrix3|secondarycolormatrix4|secondarycolormatrix5|secondarygreyscale|secondaryimage|secondaryimagealpha|secondaryimagecrop|secondaryimagepath|secondaryimagerotate|secondaryimagetint|secondsvalue|selectedcolor|sensitivity|separator|shape|showdotdot|showfile|showfolder|showhidden|showsystem|skinheight|skinpath|skinwidth|snapedges|solid|solidcolor|solidcolor2|sortascending|speedfannumber|startangle|starthidden|startinfolder|startshift|startvalue|string|stringindex|stringindex2|subfolders|substitute|sysinfodata|text|tile|timeout|timeoutvalue|timestamp|timestampformat|timestamplocale|timezone|tooltiphidden|tooltipicon|tooltiptext|tooltiptitle|tooltiptype|tooltipwidth|topmost|total|trackchangeaction|transformationmatrix|transitionupdate|traybitmap|traycolor1|traycolor2|trayexecutedm|trayexecutedr|trayexecutem|trayexecuter|trayicon|uniquerandom|update|updatedivider|updaterandom|updaterate|url|usebits|useexiforientation|useragent|valueremainder|version|w|whitelist|wifiintfid|wifilistlimit|wifiliststyle|wildcardsearch|windowclass|windowmessage|windowname|windowx|windowy|x|x1mousedoubleclickaction|x1mousedownaction|x1mouseupaction|x2mousedoubleclickaction|x2mousedownaction|x2mouseupaction|y)\s*= 1:keyword
    # Highlighted when followed by an integer and an equals sign
    add-highlighter shared/rainmeter/code/keyword_numbered regex (?i)^\s*(alias|barorientation|bitmapalign|bothimageflip|channel|command|contextaction|contexttitle|coretemptype|datetype|graphorientation|graphstart|iconsize|ifcondition|iffalseaction|ifmatch|ifmatchaction|ifnotmatchaction|iftrueaction|imageflip|infotype|inlinesetting|linecolor|maskimageflip|measure|measurename|meter|outputtype|path|playername|playertype|port|powerstate|primaryimageflip|recycletype|reghkey|rescounttype|scale|secondaryimageflip|shape|sortdatetype|sorttype|speedfanscale|speedfantype|state|stringalign|stringcase|stringeffect|stringstyle|sysinfotype|transformstroke|traymeter|twittertype|type|vdmeasuretype|wifiinfotype)(\d+)\s*= 1:keyword 2:keyword
    # Highlighted when followed by alphanumeric characters and an equals sign
    add-highlighter shared/rainmeter/code/keyword_alphanumeric regex (?i)^\s*(@include)([a-zA-Z0-9]+?)\s*= 1:keyword 2:keyword
    # Highlighted when followed by an equals sign and a valid option
    # MACRO: <a-i>w"ay*60Js<ret>ww"syghGLd"aPA=(<esc>"s<a-P>i|<esc>),hdjgh
    add-highlighter shared/rainmeter/code/keyword_alias regex (?i)^\s*(alias)\s*=\s*(cpu|gpu|io|ioread|iowrite|ram|ramshared|vram|vramshared)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_barorientation regex (?i)^\s*(barorientation)\s*=\s*(horizontal|vertical)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_bitmapalign regex (?i)^\s*(bitmapalign)\s*=\s*(center|left|right)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_bothimageflip regex (?i)^\s*(bothimageflip)\s*=\s*(both|horizontal|none|vertical)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_channel regex (?i)^\s*(channel)\s*=\s*(0|1|2|3|4|5|6|7|avg|bl|br|c|fl|fr|l|lfe|r|sl|sr|sub|sum)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_coretemptype regex (?i)^\s*(coretemptype)\s*=\s*(busmultiplier|busspeed|corebusmultiplier|corespeed|cpuname|cpuspeed|load|maxtemperature|power|tdp|temperature|tjmax|vid)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_datetype regex (?i)^\s*(datetype)\s*=\s*(accessed|created|modified)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_graphorientation regex (?i)^\s*(graphorientation)\s*=\s*(horizontal|vertical)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_graphstart regex (?i)^\s*(graphstart)\s*=\s*(left|right)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_iconsize regex (?i)^\s*(iconsize)\s*=\s*(extralarge|large|medium|small)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_imageflip regex (?i)^\s*(imageflip)\s*=\s*(both|horizontal|none|vertical)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_infotype regex (?i)^\s*(infotype)\s*=\s*(filecount|foldercount|foldersize)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_maskimageflip regex (?i)^\s*(maskimageflip)\s*=\s*(both|horizontal|none|vertical)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_measure regex (?i)^\s*(measure)\s*=\s*(calc|cpu|freediskspace|loop|mediakey|memory|netin|netout|nettotal|nowplaying|physicalmemory|plugin|process|recyclemanager|registry|script|string|swapmemory|sysinfo|time|uptime|webparser)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_meter regex (?i)^\s*(meter)\s*=\s*(bar|bitmap|button|histogram|image|line|rotator|roundline|shape|string)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_outputtype regex (?i)^\s*(outputtype)\s*=\s*(ansi|utf16|utf8)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_playername regex (?i)^\s*(playername)\s*=\s*(aimp|cad|itunes|mediamonkey|spotify|winamp|wlm|wmp)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_playertype regex (?i)^\s*(playertype)\s*=\s*(album|artist|cover|duration|file|genre|lyrics|number|position|progress|rating|repeat|shuffle|state|status|title|volume|year)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_port regex (?i)^\s*(port)\s*=\s*(input|output)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_powerstate regex (?i)^\s*(powerstate)\s*=\s*(acline|hz|lifetime|mhz|percent|status|status2)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_primaryimageflip regex (?i)^\s*(primaryimageflip)\s*=\s*(both|horizontal|none|vertical)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_recycletype regex (?i)^\s*(recycletype)\s*=\s*(count|size)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_reghkey regex (?i)^\s*(reghkey)\s*=\s*(hkey_classes_root|hkey_current_config|hkey_current_user|hkey_dyn_data|hkey_local_machine|hkey_performance_data)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_rescounttype regex (?i)^\s*(rescounttype)\s*=\s*(gdi|handle|user|window)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_secondaryimageflip regex (?i)^\s*(secondaryimageflip)\s*=\s*(both|horizontal|none|vertical)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_sortdatetype regex (?i)^\s*(sortdatetype)\s*=\s*(accessed|created|modified)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_sorttype regex (?i)^\s*(sorttype)\s*=\s*(date|name|size|type)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_speedfanscale regex (?i)^\s*(speedfanscale)\s*=\s*(c|f|k)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_speedfantype regex (?i)^\s*(speedfantype)\s*=\s*(fan|temperature|voltage)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_state regex (?i)^\s*(state)\s*=\s*(hide|maximized|minimized|show)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_stringalign regex (?i)^\s*(stringalign)\s*=\s*(center|centerbottom|centercenter|centertop|left|leftbottom|leftcenter|lefttop|right|rightbottom|rightcenter|righttop)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_stringcase regex (?i)^\s*(stringcase)\s*=\s*(lower|none|proper|upper)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_stringeffect regex (?i)^\s*(stringeffect)\s*=\s*(border|none|shadow)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_stringstyle regex (?i)^\s*(stringstyle)\s*=\s*(bold|bolditalic|italic|normal)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_sysinfotype regex (?i)^\s*(sysinfotype)\s*=\s*(adapter_alias|adapter_description|adapter_guid|adapter_receive_speed|adapter_transmit_speed|adapter_type|adapter_state|adapter_status|computer_name|dns_server|domain_name|domain_workgroup|gateway_address|gateway_address_v4|gateway_address_v6|host_name|idle_time|internet_connectivity|internet_connectivity_v4|internet_connectivity_v6|ip_address|lan_connectivity|lan_connectivity_v4|lan_connectivity_v6|last_sleep_time|last_wake_time|mac_address|net_mask|num_monitors|os_bits|os_version|pagesize|screen_height|screen_size|screen_width|timezone_bias|timezone_daylight_bias|timezone_daylight_name|timezone_isdst|timezone_standard_bias|timezone_standard_name|user_logontime|user_name|virtual_screen_height|virtual_screen_left|virtual_screen_top|virtual_screen_width|work_area|work_area_height|work_area_left|work_area_top|work_area_width)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_traymeter regex (?i)^\s*(traymeter)\s*=\s*(bitmap|histogram)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_transformstroke regex (?i)^\s*(transformstroke)\s*=\s*(fixed|normal)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_type regex (?i)^\s*(type)\s*=\s*(0|1|band|bandfreq|deviceid|devicelist|devicename|devicestatus|fft|fftfreq|filecount|filedate|filename|filepath|filesize|filetype|foldercount|folderpath|foldersize|format|icon|pathtofile|peak|rms)$ 1:keyword 2:value
    add-highlighter shared/rainmeter/code/keyword_wifiinfotype regex (?i)^\s*(wifiinfotype)\s*=\s*(auth|encryption|list|phy|quality|ssid)$ 1:keyword 2:value
}
