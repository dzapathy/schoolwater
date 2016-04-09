/**
 * ueditor鐎瑰本鏆ｉ柊宥囩枂妞わ拷
 * 閸欘垯浜掗崷銊ㄧ箹闁插矂鍘ょ純顔芥殻娑擃亞绱潏鎴濇珤閻ㄥ嫮澹掗幀锟� */
/**************************閹绘劗銇�*******************************
 * 閹碉拷婀佺悮顐ｆ暈闁插﹦娈戦柊宥囩枂妞ょ懓娼庢稉绡ditor姒涙顓婚崐绗猴拷
 * 娣囶喗鏁兼妯款吇闁板秶鐤嗙拠鐑筋湚閸忓牏鈥樻穱婵嗗嚒缂佸繐鐣崗銊︽绾喛顕氶崣鍌涙殶閻ㄥ嫮婀＄�鐐垫暏闁柣锟�
 * 娑撴槒顪呴張澶夎⒈缁夊秳鎱ㄩ弨瑙勬煙濡楀牞绱濇稉锟筋瀸閺勵垰褰囧☉鍫燁劃婢跺嫭鏁為柌濠忕礉閻掕泛鎮楁穱顔芥暭閹存劕顕惔鏂垮棘閺佸府绱遍崣锔跨缁夊秵妲搁崷銊ョ杽娓氬瀵茬紓鏍帆閸ｃ劍妞傛导鐘插弳鐎电懓绨查崣鍌涙殶閵嗭拷
 * 瑜版挸宕岀痪褏绱潏鎴濇珤閺冭绱濋崣顖滄纯閹恒儰濞囬悽銊︽＋閻楀牓鍘ょ純顔芥瀮娴犺埖娴涢幑銏℃煀閻楀牓鍘ょ純顔芥瀮娴狅拷娑撳秶鏁ら幏鍛妇閺冄呭闁板秶鐤嗛弬鍥︽娑擃厼娲滅紓鍝勭毌閺傛澘濮涢懗鑺ュ闂囷拷娈戦崣鍌涙殶閼板苯顕遍懛纾嬪壖閺堫剚濮ら柨娆嶏拷
 **************************閹绘劗銇�*******************************/

(function () {

    /**
     * 缂傛牞绶崳銊ㄧカ濠ф劖鏋冩禒鑸电壌鐠侯垰绶為妴鍌氱暊閹碉拷銆冪粈铏规畱閸氼偂绠熼弰顖ょ窗娴犮儳绱潏鎴濇珤鐎圭偘绶ラ崠鏍�闂堫枍璐熻ぐ鎾冲鐠侯垰绶為敍灞惧瘹閸氭垹绱潏鎴濇珤鐠у嫭绨弬鍥︽閿涘牆宓哾ialog缁涘鏋冩禒璺恒仚閿涘娈戠捄顖氱窞閵嗭拷
     * 闁寸繝绨鍫濐檵閸氬苯顒熼崷銊ゅ▏閻劎绱潏鎴濇珤閻ㄥ嫭妞傞崐娆忓毉閻滄壆娈戠粔宥囶瀸鐠侯垰绶為梻顕�暯閿涘本顒濇径鍕繁閻戝牆缂撶拋顔笺亣鐎规湹濞囬悽锟介惄绋款嚠娴滃海缍夌粩娆愮壌閻╊喖缍嶉惃鍕祲鐎电鐭惧锟芥潻娑滎攽闁板秶鐤嗛妴锟�     * "閻╃顕禍搴ｇ秹缁旀瑦鐗撮惄顔肩秿閻ㄥ嫮娴夌�纭呯熅瀵帮拷娑旂喎姘ㄩ弰顖欎簰閺傛粍娼锟姐仈閻ㄥ嫬鑸版俊锟�myProject/ueditor/"鏉╂瑦鐗遍惃鍕熅瀵板嫨锟�
     * 婵″倹鐏夌粩娆戝仯娑擃厽婀佹径姘嚋娑撳秴婀崥灞肩鐏炲倻楠囬惃鍕�闂堛垽娓剁憰浣哥杽娓氬瀵茬紓鏍帆閸ｎ煉绱濇稉鏂跨穿閻劋绨￠崥灞肩UEditor閻ㄥ嫭妞傞崐娆欑礉濮濄倕顦甸惃鍒凴L閸欘垵鍏樻稉宥夛拷閻劋绨В蹇庨嚋妞ょ敻娼伴惃鍕椽鏉堟垵娅掗妴锟�     * 閸ョ姵顒濋敍瀛禘ditor閹绘劒绶垫禍鍡涙嫛鐎甸�绗夐崥宀勩�闂堛垻娈戠紓鏍帆閸ｃ劌褰查崡鏇犲闁板秶鐤嗛惃鍕壌鐠侯垰绶為敍灞藉徔娴ｆ挻娼电拠杈剧礉閸︺劑娓剁憰浣哥杽娓氬瀵茬紓鏍帆閸ｃ劎娈戞い鐢告桨閺堬拷銆婇柈銊ュ晸娑撳﹤顪嗘稉瀣╁敩閻礁宓嗛崣顖橈拷瑜版挾鍔ч敍宀勬付鐟曚椒鎶ゅ銈咁樀閻ㄥ垊RL缁涘绨�鐟扮安閻ㄥ嫰鍘ょ純顔猴拷
     * window.UEDITOR_HOME_URL = "/xxxx/xxxx/";
     */
    var URL = window.UEDITOR_HOME_URL || getUEBasePath();

    /**
     * 闁板秶鐤嗘い閫涘瘜娴ｆ挶锟藉▔銊﹀壈閿涘本顒濇径鍕閺堝绉归崣濠傚煂鐠侯垰绶為惃鍕帳缂冾喖鍩嗛柆妤佺础URL閸欐﹢鍣洪妴锟�     */
    window.UEDITOR_CONFIG = {

        //娑撹櫣绱潏鎴濇珤鐎圭偘绶ュǎ璇插娑擄拷閲滅捄顖氱窞閿涘矁绻栨稉顏冪瑝閼冲�顤嗗▔銊╁櫞
        UEDITOR_HOME_URL: URL

        // 閺堝秴濮熼崳銊х埠娑擄拷顕Ч鍌涘复閸欙綀鐭惧锟�        , serverUrl: URL + "jsp/controller.jsp"

        //瀹搞儱鍙块弽蹇庣瑐閻ㄥ嫭澧嶉張澶屾畱閸旂喕鍏橀幐澶愭尦閸滃奔绗呴幏澶嬵攱閿涘苯褰叉禒銉ユ躬new缂傛牞绶崳銊ф畱鐎圭偘绶ラ弮鍫曪拷閹封晞鍤滃閬嶆付鐟曚胶娈戞禒搴㈡煀鐎规矮绠�
        , toolbars: [[
			'undo', 'redo', '|',
			'bold', 'italic', 'underline', 'strikethrough', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|',
			'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
			'paragraph', 'fontfamily', 'fontsize', '|',
			'directionalityltr', 'directionalityrtl', 'indent', '|',
			'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|',
			'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
			'emotion'
        ]]
        //瑜版捇绱堕弽鍥ㄦ杹閸︺劌浼愰崗閿嬬埉娑撳﹥妞傞弰鍓с仛閻ㄥ墖ooltip閹绘劗銇�閻ｆ瑧鈹栭弨顖涘瘮閼奉亜濮╂径姘愁嚔鐟凤拷鍘ょ純顕嗙礉閸氾箑鍨禒銉╁帳缂冾喖锟芥稉鍝勫櫙
        //,labelMap:{
        //    'anchor':'', 'undo':''
        //}

        //鐠囶叀鈻堥柊宥囩枂妞わ拷姒涙顓婚弰鐥緃-cn閵嗗倹婀侀棁锟筋渽閻ㄥ嫯鐦芥稊鐔峰讲娴犮儰濞囬悽銊ヮ渾娑撳绻栭弽椋庢畱閺傜懓绱￠弶銉ㄥ殰閸斻劌顧嬬拠顓♀枅閸掑洦宕查敍灞界秼閻掕绱濋崜宥嗗絹閺夆�娆㈤弰鐥゛ng閺傚洣娆㈡径閫涚瑓鐎涙ê婀�鐟扮安閻ㄥ嫯顕㈢懛锟芥瀮娴犺绱�
        //lang閸婇棿绡冮崣顖欎簰闁俺绻冮懛顏勫З閼惧嘲褰�(navigator.language||navigator.browserLanguage ||navigator.userLanguage).toLowerCase()
        //,lang:"zh-cn"
        //,langPath:URL +"lang/"

        //娑撳顣介柊宥囩枂妞わ拷姒涙顓婚弰鐥檈fault閵嗗倹婀侀棁锟筋渽閻ㄥ嫯鐦芥稊鐔峰讲娴犮儰濞囬悽銊ヮ渾娑撳绻栭弽椋庢畱閺傜懓绱￠弶銉ㄥ殰閸斻劌顧嬫稉濠氼暯閸掑洦宕查敍灞界秼閻掕绱濋崜宥嗗絹閺夆�娆㈤弰鐥秇emes閺傚洣娆㈡径閫涚瑓鐎涙ê婀�鐟扮安閻ㄥ嫪瀵屾０妯绘瀮娴犺绱�
        //閻滅増婀佹俊鍌欑瑓閻喛鍋�default
        //,theme:'default'
        //,themePath:URL +"themes/"

        ,zIndex : 0     //缂傛牞绶崳銊ョ湴缁狙呮畱閸╃儤鏆�姒涙顓婚弰锟�0

        //闁藉牆顕甮etAllHtml閺傝纭堕敍灞肩窗閸︺劌顕惔鏃傛畱head閺嶅洨顒锋稉顓烆杻閸旂姾顕氱紓鏍垳鐠佸墽鐤嗛妴锟�        //,charset:"utf-8"

        //閼汇儱鐤勬笟瀣缂傛牞绶崳銊ф畱妞ょ敻娼伴幍瀣З娣囶喗鏁奸惃鍒main閿涘本顒濇径鍕付鐟曚浇顔曠純顔昏礋true
        //,customDomain:false

        //鐢摜鏁ら柊宥囩枂妞ゅ湱娲�
        //,isShow : true    //姒涙顓婚弰鍓с仛缂傛牞绶崳锟�
        //,textarea:'editorValue' // 閹绘劒姘︾悰銊ュ礋閺冭绱濋張宥呭閸ｃ劏骞忛崣鏍椽鏉堟垵娅掗幓鎰唉閸愬懎顔愰惃鍕閻劎娈戦崣鍌涙殶閿涘苯顧嬬�鐐扮伐閺冭泛褰叉禒銉х舶鐎圭懓娅抧ame鐏炵偞锟介敍灞肩窗鐏忓攳ame缂佹瑥鐣鹃惃鍕拷閺堬拷璐熷В蹇庨嚋鐎圭偘绶ラ惃鍕暛閸婄》绱濇稉宥囨暏濮ｅ繑顐肩�鐐扮伐閸栨牜娈戦弮璺猴拷闁�顔曠純顔跨箹娑擃亜锟�

        //,initialContent:'濞嗐垼绻嬫担璺ㄦ暏ueditor!'    //閸掓繂顬婇崠鏍椽鏉堟垵娅掗惃鍕敶鐎癸拷娑旂喎褰叉禒銉╋拷鏉╁檼extarea/script缂佹瑥锟介敍宀�箙鐎规缍夋笟瀣摍

        //,autoClearinitialContent:true //閺勵垰鎯侀懛顏勫З濞撳懘娅庣紓鏍帆閸ｃ劌鍨垫慨瀣敶鐎圭櫢绱濆▔銊﹀壈閿涙艾顪嗛弸娓噊cus鐏炵偞锟界拋鍓х枂娑撶皪rue,鏉╂瑤閲滄稊鐔惰礋閻噦绱濋柇锝勭疄缂傛牞绶崳銊ょ娑撳﹥娼电亸鍙樼窗鐟欙箑褰傜�鑹板毀閸掓繂顬婇崠鏍畱閸愬懎顔愰惇瀣╃瑝閸掗绨�

        //,focus:false //閸掓繂顬婇崠鏍ㄦ閿涘本妲搁崥锕侇唨缂傛牞绶崳銊ㄥ箯瀵版鍔嶉悙绠價ue閹存潊alse

        //婵″倹鐏夐懛顏勭暰娑斿绱濋張锟姐偨缂佹獤閺嶅洨顒锋俊鍌欑瑓閻ㄥ嫯顢戞姗堢礉鐟曚椒绗夋潏鎾冲弳娑擃厽鏋冮弮璁圭礉娴兼碍婀佺捄鍐插З閹帮拷
        //,initialStyle:'p{line-height:1em}'//缂傛牞绶崳銊ョ湴缁狙呮畱閸╃儤鏆�閸欘垯浜掗悽銊︽降閺�懓褰夌�妞剧秼缁涳拷

        //,iframeCssUrl: URL + '/themes/iframe.css' //缂佹瑧绱潏鎴濇珤閸愬懘鍎村鏇炲弳娑擄拷閲渃ss閺傚洣娆�

        //indentValue
        //妫ｆ牞顢戠紓鈺勭箻鐠烘繄顪�姒涙顓婚弰锟絜m
        //,indentValue:'2em'

        //,initialFrameWidth:1000  //閸掓繂顬婇崠鏍椽鏉堟垵娅掔�钘夊,姒涙顓�000
        ,initialFrameHeight:200  //閸掓繂顬婇崠鏍椽鏉堟垵娅掓妯哄,姒涙顓�20

        //,readonly : false //缂傛牞绶崳銊ュ灥婵瀵茬紒鎾存将閸氾拷缂傛牞绶崠鍝勭厵閺勵垰鎯侀弰顖氬涧鐠囪崵娈戦敍宀勭帛鐠併倖妲竑alse

        //,autoClearEmptyNode : true //getContent閺冭绱濋弰顖氭儊閸掔娀娅庣粚铏规畱inlineElement閼哄倻鍋ｉ敍鍫濆瘶閹奉剙绁垫總妤冩畱閹懎鍠岄敍锟�
        //閸氼垳鏁ら懛顏勫З娣囨繂鐡�
        //,enableAutoSave: true
        //閼奉亜濮╂穱婵嗙摠闂傛挳娈ч弮鍫曟？閿涳拷閸楁洑缍卪s
        //,saveInterval: 500

        ,fullscreen : false //閺勵垰鎯佸锟芥儙閸掓繂顬婇崠鏍ㄦ閸楀啿鍙忕仦蹇ョ礉姒涙顓婚崗鎶芥４

        //,imagePopup:true      //閸ュ墽澧栭幙宥勭稊閻ㄥ嫭璇炵仦鍌氱磻閸忕绱濇妯款吇閹垫挸绱�

        //,autoSyncData:true //閼奉亜濮╅崥灞绢劄缂傛牞绶崳銊渽閹绘劒姘﹂惃鍕殶閹癸拷
        //,emotionLocalization:false //閺勵垰鎯佸锟芥儙鐞涖劍鍎忛張顒�勾閸栨牭绱濇妯款吇閸忔娊妫撮妴鍌濆鐟曚礁绱戦崥顖濐嚞绾喕绻歟motion閺傚洣娆㈡径閫涚瑓閸栧懎鎯堢�妯肩秹閹绘劒绶甸惃鍒琺ages鐞涖劍鍎忛弬鍥︽婢讹拷

        //缁鍒涢崣顏冪箽閻ｆ瑦鐖ｇ粵鎾呯礉閸樺娅庨弽鍥╊劮閹碉拷婀佺仦鐐达拷
        //,retainOnlyLabelPasted: false

        //,pasteplain:false  //閺勵垰鎯佹妯款吇娑撹櫣鍑介弬鍥ㄦ拱缁鍒涢妴淇lse娑撹桨绗夋担璺ㄦ暏缁绢垱鏋冮張顒傜煒鐠愯揪绱漷rue娑撹桨濞囬悽銊у嚱閺傚洦婀扮划妯垮垱
        //缁绢垱鏋冮張顒傜煒鐠愬瓨膩瀵繋绗呴惃鍕箖濠娿倛顬冮崚锟�        //'filterTxtRules' : function(){
        //    function transP(node){
        //        node.tagName = 'p';
        //        node.setStyle();
        //    }
        //    return {
        //        //閻╁瓨甯撮崚鐘绘珟閸欏﹤鍙剧�妤勫Ν閻愮懓鍞寸�锟�        //        '-' : 'script style object iframe embed input select',
        //        'p': {$:{}},
        //        'br':{$:{}},
        //        'div':{'$':{}},
        //        'li':{'$':{}},
        //        'caption':transP,
        //        'th':transP,
        //        'tr':transP,
        //        'h1':transP,'h2':transP,'h3':transP,'h4':transP,'h5':transP,'h6':transP,
        //        'td':function(node){
        //            //濞屸剝婀侀崘鍛啇閻ㄥ墖d閻╁瓨甯撮崚鐘冲竴
        //            var txt = !!node.innerText();
        //            if(txt){
        //                node.parentNode.insertAfter(UE.uNode.createText(' &nbsp; &nbsp;'),node);
        //            }
        //            node.parentNode.removeChild(node,node.innerText())
        //        }
        //    }
        //}()

        //,allHtmlEnabled:false //閹绘劒姘﹂崚鏉挎倵閸欐壆娈戦弫鐗堝祦閺勵垰鎯侀崠鍛儓閺佺繝閲渉tml鐎涙顑佹稉锟�
        //insertorderedlist
        //閺堝绨崚妤勩�閻ㄥ嫪绗呴幏澶愬帳缂冿拷閸婅偐鏆�粚鐑樻閺�垱瀵旀径姘愁嚔鐟凤拷鍤滈崝銊ㄧ槕閸掝偓绱濋懟銉╁帳缂冾喖锟介敍灞藉灟娴犮儲顒濋崐闂磋礋閸戯拷
        //,'insertorderedlist':{
        //      //閼奉亜鐣鹃惃鍕壉瀵拷
        //        'num':'1,2,3...',
        //        'num1':'1),2),3)...',
        //        'num2':'(1),(2),(3)...',
        //        'cn':'娑擄拷娴滐拷娑擄拷...',
        //        'cn1':'娑擄拷,娴滐拷,娑擄拷....',
        //        'cn2':'(娑擄拷,(娴滐拷,(娑擄拷....',
        //     //缁崵绮洪懛顏勭敨
        //     'decimal' : '' ,         //'1,2,3...'
        //     'lower-alpha' : '' ,    // 'a,b,c...'
        //     'lower-roman' : '' ,    //'i,ii,iii...'
        //     'upper-alpha' : '' , lang   //'A,B,C'
        //     'upper-roman' : ''      //'I,II,III...'
        //}

        //insertunorderedlist
        //閺冪姴绨崚妤勩�閻ㄥ嫪绗呴幏澶愬帳缂冾噯绱濋崐鑲╂殌缁岀儤妞傞弨顖涘瘮婢舵俺顕㈢懛锟藉殰閸斻劏鐦戦崚顐礉閼汇儵鍘ょ純顔硷拷閿涘苯鍨禒銉︻劃閸婇棿璐熼崙锟�        //,insertunorderedlist : { //閼奉亜鐣鹃惃鍕壉瀵拷
        //    'dash' :'閳ワ拷閻瓨濮岄崣锟� //-閻瓨濮岄崣锟�        //    'dot':' 閵嗭拷鐏忓繐娓鹃崷锟� //缁崵绮洪懛顏勭敨
        //    'circle' : '',  // '閳硷拷鐏忓繐娓鹃崷锟�
        //    'disc' : '',    // '閳硷拷鐏忓繐娓鹃悙锟�
        //    'square' : ''   //'閳伙拷鐏忓繑鏌熼崸锟�
        //}
        //,listDefaultPaddingLeft : '30'//姒涙顓婚惃鍕箯鏉堝湱缂夋潻娑氭畱閸╃儤鏆熼崐锟�        //,listiconpath : 'http://bs.baidu.com/listicon/'//閼奉亜鐣炬稊澶嬬垼閸欓娈戠捄顖氱窞
        //,maxListLevel : 3 //闂勬劕鍩楅崣顖欎簰tab閻ㄥ嫮楠囬弫锟�鐠佸墽鐤�1娑撹桨绗夐梽鎰煑

        //,autoTransWordToList:false  //缁備焦顒泈ord娑擃厾鐭樼拹纾嬬箻閺夈儳娈戦崚妤勩�閼奉亜濮╅崣妯诲灇閸掓銆冮弽鍥╊劮

        //fontfamily
        //鐎涙ぞ缍嬬拋鍓х枂 label閻ｆ瑧鈹栭弨顖涘瘮婢舵俺顕㈢懛锟藉殰閸斻劌鍨忛幑顤庣礉閼汇儵鍘ょ純顕嗙礉閸掓瑤浜掗柊宥囩枂閸婇棿璐熼崙锟�        //,'fontfamily':[
        //    { label:'',name:'songti',val:'鐎瑰缍�SimSun'},
        //    { label:'',name:'kaiti',val:'濡よ渹缍�濡よ渹缍媉GB2312, SimKai'},
        //    { label:'',name:'yahei',val:'瀵邦喛钂嬮梿鍛寸拨,Microsoft YaHei'},
        //    { label:'',name:'heiti',val:'姒涙垳缍� SimHei'},
        //    { label:'',name:'lishu',val:'闂呮湹鍔� SimLi'},
        //    { label:'',name:'andaleMono',val:'andale mono'},
        //    { label:'',name:'arial',val:'arial, helvetica,sans-serif'},
        //    { label:'',name:'arialBlack',val:'arial black,avant garde'},
        //    { label:'',name:'comicSansMs',val:'comic sans ms'},
        //    { label:'',name:'impact',val:'impact,chicago'},
        //    { label:'',name:'timesNewRoman',val:'times new roman'}
        //]

        //fontsize
        //鐎涙褰�
        //,'fontsize':[10, 11, 12, 14, 16, 18, 20, 24, 36]

        //paragraph
        //濞堜絻鎯ら弽鐓庣础 閸婅偐鏆�粚鐑樻閺�垱瀵旀径姘愁嚔鐟凤拷鍤滈崝銊ㄧ槕閸掝偓绱濋懟銉╁帳缂冾噯绱濋崚娆庝簰闁板秶鐤嗛崐闂磋礋閸戯拷
        //,'paragraph':{'p':'', 'h1':'', 'h2':'', 'h3':'', 'h4':'', 'h5':'', 'h6':''}

        //rowspacingtop
        //濞堢敻妫跨捄锟介崐鐓庢嫲閺勫墽銇氶惃鍕倳鐎涙娴夐崥锟�        //,'rowspacingtop':['5', '10', '15', '20', '25']

        //rowspacingBottom
        //濞堢敻妫跨捄锟介崐鐓庢嫲閺勫墽銇氶惃鍕倳鐎涙娴夐崥锟�        //,'rowspacingbottom':['5', '10', '15', '20', '25']

        //lineheight
        //鐞涘苯鍞撮梻纾嬬獩 閸婄厧鎷伴弰鍓с仛閻ㄥ嫬鎮曠�妤冩祲閸氾拷
        //,'lineheight':['1', '1.5','1.75','2', '3', '4', '5']

        //customstyle
        //閼奉亜鐣炬稊澶嬬壉瀵骏绱濇稉宥嗘暜閹镐礁娴楅梽鍛閿涘本顒濇径鍕帳缂冾喖锟介崡鍐插讲閺堬拷鎮楅弰鍓с仛閸婏拷
        //block閻ㄥ嫬鍘撶槐鐘虫Ц娓氭繃宓佺拋鍓х枂濞堜絻鎯ら惃鍕拷鏉堟垼顔曠純顔炬畱閿涘nline閻ㄥ嫬鍘撶槐鐘辩贩閹圭摳IU閻ㄥ嫰锟芥潏鎴ｎ啎缂冿拷
        //鐏忎粙鍣烘担璺ㄦ暏娑擄拷绨虹敮鍝ユ暏閻ㄥ嫭鐖ｇ粵锟�        //閸欏倹鏆熺拠瀛樻
        //tag 娴ｈ法鏁ら惃鍕垼缁涙儳鎮曠�锟�        //label 閺勫墽銇氶惃鍕倳鐎涙ぞ绡冮弰顖滄暏閺夈儲鐖ｇ拠鍡曠瑝閸氬瞼琚崹瀣畱閺嶅洩鐦戠粭锔肩礉濞夈劍鍓版潻娆庨嚋閸婂吋鐦℃稉顏囶渽娑撳秴鎮撻敍锟�        //style 濞ｈ濮為惃鍕壉瀵拷
        //濮ｅ繋绔存稉顏勵嚠鐠炩�姘ㄩ弰顖欑娑擃亣鍤滅�姘疅閻ㄥ嫭鐗卞锟�        //,'customstyle':[
        //    {tag:'h1', name:'tc', label:'', style:'border-bottom:#ccc 2px solid;padding:0 4px 0 0;text-align:center;margin:0 0 20px 0;'},
        //    {tag:'h1', name:'tl',label:'', style:'border-bottom:#ccc 2px solid;padding:0 4px 0 0;margin:0 0 10px 0;'},
        //    {tag:'span',name:'im', label:'', style:'font-style:italic;font-weight:bold'},
        //    {tag:'span',name:'hi', label:'', style:'font-style:italic;font-weight:bold;color:rgb(51, 153, 204)'}
        //]

        //閹垫挸绱戦崣鎶芥暛閼挎粌宕熼崝鐔诲厴
        //,enableContextMenu: true
        //閸欐娊鏁懣婊冨礋閻ㄥ嫬鍞寸�鐧哥礉閸欘垯浜掗崣鍌濓拷plugins/contextmenu.js闁插矁绔熼惃鍕帛鐠併倛褰嶉崡鏇犳畱娓氬鐡欓敍瀹璦bel閻ｆ瑧鈹栭弨顖涘瘮閸ヤ粙妾崠鏍电礉閸氾箑鍨禒銉︻劃闁板秶鐤嗘稉鍝勫櫙
        //,contextMenu:[
        //    {
        //        label:'',       //閺勫墽銇氶惃鍕倳缁夛拷
        //        cmdName:'selectall',//閹笛嗩攽閻ㄥ垻ommand閸涙垝鎶ら敍灞界秼閻愮懓鍤潻娆庨嚋閸欐娊鏁懣婊冨礋閺冿拷
        //        //exec閸欘垶锟介敍灞炬箒娴滃攢xec鐏忓彉绱伴崷銊у仯閸戠粯妞傞幍褑顢戞潻娆庨嚋function閿涘奔绱崗鍫㈤獓妤傛ü绨琧mdName
        //        exec:function () {
        //            //this閺勵垰缍嬮崜宥囩椽鏉堟垵娅掗惃鍕杽娓氾拷
        //            //this.ui._dialogs['inserttableDialog'].open();
        //        }
        //    }
        //]

        //韫囶偅宓庨懣婊冨礋
        //,shortcutMenu:["fontfamily", "fontsize", "bold", "italic", "underline", "forecolor", "backcolor", "insertorderedlist", "insertunorderedlist"]

        //elementPathEnabled
        //閺勵垰鎯侀崥顖滄暏閸忓啰绀岀捄顖氱窞閿涘矂绮拋銈嗘Ц閺勫墽銇�
        ,elementPathEnabled : false

        //wordCount
        ,wordCount:false          //閺勵垰鎯佸锟芥儙鐎涙鏆熺紒鐔活吀
        //,maximumWords:10000       //閸忎浇顔忛惃鍕付婢堆冪摟缁楋附鏆�
        //鐎涙鏆熺紒鐔活吀閹绘劗銇氶敍瀵�count}娴狅綀銆冭ぐ鎾冲鐎涙鏆熼敍瀵�leave}娴狅綀銆冩潻妯哄讲娴犮儴绶崗銉ヮ檵鐏忔垵鐡х粭锔芥殶,閻ｆ瑧鈹栭弨顖涘瘮婢舵俺顕㈢懛锟藉殰閸斻劌鍨忛幑顤庣礉閸氾箑鍨幐澶嬵劃闁板秶鐤嗛弰鍓с仛
        //,wordCountMsg:''   //瑜版挸澧犲鑼剁翻閸忥拷{#count} 娑擃亜鐡х粭锔肩礉閹劏绻曢崣顖欎簰鏉堟挸鍙唟#leave} 娑擃亜鐡х粭锟�        //鐡掑懎鍤�妤佹殶闂勬劕鍩楅幓鎰仛  閻ｆ瑧鈹栭弨顖涘瘮婢舵俺顕㈢懛锟藉殰閸斻劌鍨忛幑顤庣礉閸氾箑鍨幐澶嬵劃闁板秶鐤嗛弰鍓с仛
        //,wordOverFlowMsg:''    //<span style="color:red;">娴ｇ姾绶崗銉ф畱鐎涙顑佹稉顏呮殶瀹歌尙绮＄搾鍛毉閺堬拷銇囬崗浣筋啅閸婄》绱濋張宥呭閸ｃ劌褰查懗鎴掔窗閹锋帞绮锋穱婵嗙摠閿涳拷/span>

        //tab
        //閻愮懓鍤畉ab闁款喗妞傜粔璇插З閻ㄥ嫯绐涚粋锟絫abSize閸婂秵鏆熼敍瀹糰bNode娴狅拷绠炵�妤冾儊閸嬫矮璐熼崡鏇氱秴
        //,tabSize:4
        //,tabNode:'&nbsp;'

        //removeFormat
        //濞撳懘娅庨弽鐓庣础閺冭泛褰叉禒銉ュ灩闂勩倗娈戦弽鍥╊劮閸滃苯鐫橀幀锟�        //removeForamtTags閺嶅洨顒�
        //,removeFormatTags:'b,big,code,del,dfn,em,font,i,ins,kbd,q,samp,small,span,strike,strong,sub,sup,tt,u,var'
        //removeFormatAttributes鐏炵偞锟�
        //,removeFormatAttributes:'class,style,lang,width,height,align,hspace,valign'

        //undo
        //閸欘垯浜掗張锟筋檵閸ョ偤锟介惃鍕偧閺侊拷姒涙顓�0
        //,maxUndoCount:20
        //瑜版捁绶崗銉ф畱鐎涙顑侀弫鎷岀Т鏉╁洩顕氶崐鍏兼閿涘奔绻氱�妯圭濞嗭紕骞囬崷锟�        //,maxInputCount:1

        //autoHeightEnabled
        // 閺勵垰鎯侀懛顏勫З闂�潡鐝�姒涙顓籺rue
        ,autoHeightEnabled:false

        //scaleEnabled
        //閺勵垰鎯侀崣顖欎簰閹峰鍑犻梹鍧楃彯,姒涙顓籺rue(瑜版挸绱戦崥顖涙閿涘矁鍤滈崝銊╂毐妤傛ê銇戦弫锟�
        ,scaleEnabled:false
        //,minFrameWidth:800    //缂傛牞绶崳銊﹀珛閸斻劍妞傞張锟界毈鐎硅棄瀹�姒涙顓�00
        //,minFrameHeight:220  //缂傛牞绶崳銊﹀珛閸斻劍妞傞張锟界毈妤傛ê瀹�姒涙顓�20

        //autoFloatEnabled
        //閺勵垰鎯佹穱婵囧瘮toolbar閻ㄥ嫪缍呯純顔荤瑝閸旓拷姒涙顓籺rue
        //,autoFloatEnabled:true
        //濞搭喖濮╅弮璺轰紣閸忛攱鐖捄婵堫湩濞村繗顬囬崳銊┿�闁劎娈戞妯哄閿涘瞼鏁ゆ禍搴㈢厙娴滄稑鍙块張澶婃祼鐎规艾銇旈柈銊ф畱妞ょ敻娼�
        //,topOffset:30
        //缂傛牞绶崳銊ョ俺闁劏绐涚粋璇蹭紣閸忛攱鐖妯哄(婵″倹鐏夐崣鍌涙殶婢堆傜艾缁涘绨紓鏍帆閸ｃ劑鐝惔锔肩礉閸掓瑨顔曠純顔芥￥閺侊拷
        //,toolbarTopOffset:400

        //pageBreakTag
        //閸掑棝銆夐弽鍥槕缁楋拷姒涙顓婚弰鐥弖editor_page_break_tag_
        //,pageBreakTag:'_ueditor_page_break_tag_'

        //autotypeset
        //閼奉亜濮╅幒鎺斿閸欏倹鏆�
        //,autotypeset: {
        //    mergeEmptyline: true,           //閸氬牆鑻熺粚楦款攽
        //    removeClass: true,              //閸樼粯甯�崘妞剧稇閻ㄥ垻lass
        //    removeEmptyline: false,         //閸樼粯甯�粚楦款攽
        //    textAlign:"left",               //濞堜絻鎯ら惃鍕笓閻楀牊鏌熷蹇ョ礉閸欘垯浜掗弰锟絣eft,right,center,justify 閸樼粯甯�潻娆庨嚋鐏炵偞锟界悰銊с仛娑撳秵澧界悰灞惧笓閻楋拷
        //    imageBlockLine: 'center',       //閸ュ墽澧栭惃鍕癁閸斻劍鏌熷蹇ョ礉閻欘剙宕版稉锟筋攽閸撗傝厬,瀹革箑褰稿ù顔煎З閿涘矂绮拋锟�center,left,right,none 閸樼粯甯�潻娆庨嚋鐏炵偞锟界悰銊с仛娑撳秵澧界悰灞惧笓閻楋拷
        //    pasteFilter: false,             //閺嶈宓佺憴鍕灟鏉╁洦鎶ゅ▽鈥茬皑缁鍒涙潻娑欐降閻ㄥ嫬鍞寸�锟�        //    clearFontSize: false,           //閸樼粯甯�幍锟芥箒閻ㄥ嫬鍞村畵灞界摟閸欏嚖绱濇担璺ㄦ暏缂傛牞绶崳銊╃帛鐠併倗娈戠�妤�娇
        //    clearFontFamily: false,         //閸樼粯甯�幍锟芥箒閻ㄥ嫬鍞村畵灞界摟娴ｆ搫绱濇担璺ㄦ暏缂傛牞绶崳銊╃帛鐠併倗娈戠�妞剧秼
        //    removeEmptyNode: false,         // 閸樼粯甯�粚楦垮Ν閻愶拷
        //    //閸欘垯浜掗崢缁樺竴閻ㄥ嫭鐖ｇ粵锟�        //    removeTagNames: {閺嶅洨顒烽崥宥呯摟:1},
        //    indent: false,                  // 鐞涘矂顪氱紓鈺勭箻
        //    indentValue : '2em',            //鐞涘矂顪氱紓鈺勭箻閻ㄥ嫬銇囩亸锟�        //    bdc2sb: false,
        //    tobdc: false
        //}

        //tableDragable
        //鐞涖劍鐗搁弰顖氭儊閸欘垯浜掗幏鏍ㄥ
        //,tableDragable: true

        //,disabledTableInTable:true  //缁備焦顒涚悰銊︾壐瀹撳苯顨�

        //sourceEditor
        //濠ф劗鐖滈惃鍕叀閻鏌熷锟絚odemirror 閺勵垯鍞惍渚�彯娴滎噯绱漷extarea閺勵垱鏋冮張顒侇攱,姒涙顓婚弰鐥梠demirror
        //濞夈劍鍓版妯款吇codemirror閸欘亣鍏橀崷鈺8+閸滃矂娼猧e娑擃厺濞囬悽锟�        //,sourceEditor:"codemirror"
        //婵″倹鐏塻ourceEditor閺勭棗odemirror閿涘矁绻曢悽銊╁帳缂冾喕绔存稉瀣╄⒈娑擃亜寮弫锟�        //codeMirrorJsUrl js閸旂姾娴囬惃鍕熅瀵板嫸绱濇妯款吇閺勶拷URL + "third-party/codemirror/codemirror.js"
        //,codeMirrorJsUrl:URL + "third-party/codemirror/codemirror.js"
        //codeMirrorCssUrl css閸旂姾娴囬惃鍕熅瀵板嫸绱濇妯款吇閺勶拷URL + "third-party/codemirror/codemirror.css"
        //,codeMirrorCssUrl:URL + "third-party/codemirror/codemirror.css"
        //缂傛牞绶崳銊ュ灥婵瀵茬�灞惧灇閸氬孩妲搁崥锕佺箻閸忋儲绨惍浣鼓佸蹇ョ礉姒涙顓绘稉鍝勬儊閵嗭拷
        //,sourceEditorFirst:false

        //iframeUrlMap
        //dialog閸愬懎顔愰惃鍕熅瀵帮拷閿濈偘绱扮悮顐ｆ禌閹广垺鍨歎RL,閸ㄦ挸鐫橀幀褌绔撮弮锔藉ⅵ瀵拷绱濈亸鍡氼湂閻╂牗澧嶉張澶屾畱dialog閻ㄥ嫰绮拋銈堢熅瀵帮拷
        //,iframeUrlMap:{
        //    'anchor':'~/dialogs/anchor/anchor.html',
        //}

        //webAppKey 閻ф儳瀹虫惔鏃傛暏閻ㄥ嚈PIkey閿涘本鐦℃稉顏嗙彲闂�灝绻�い濠氼湚閸忓牆骞撻惂鎯у鐎规缍夊▔銊ュ斀娑擄拷閲渒ey閸氬孩鏌熼懗鑺ヮ劀鐢晲濞囬悽鈺漰p閸旂喕鍏橀敍灞炬暈閸愬奔绮欑紒宥忕礉http://app.baidu.com/static/cms/getapikey.html
        //, webAppKey: ""
    };

    function getUEBasePath(docUrl, confUrl) {

        return getBasePath(docUrl || self.document.URL || self.location.href, confUrl || getConfigFilePath());

    }

    function getConfigFilePath() {

        var configPath = document.getElementsByTagName('script');

        return configPath[ configPath.length - 1 ].src;

    }

    function getBasePath(docUrl, confUrl) {

        var basePath = confUrl;


        if (/^(\/|\\\\)/.test(confUrl)) {

            basePath = /^.+?\w(\/|\\\\)/.exec(docUrl)[0] + confUrl.replace(/^(\/|\\\\)/, '');

        } else if (!/^[a-z]+:/i.test(confUrl)) {

            docUrl = docUrl.split("#")[0].split("?")[0].replace(/[^\\\/]+$/, '');

            basePath = docUrl + "" + confUrl;

        }

        return optimizationPath(basePath);

    }

    function optimizationPath(path) {

        var protocol = /^[a-z]+:\/\//.exec(path)[ 0 ],
            tmp = null,
            res = [];

        path = path.replace(protocol, "").split("?")[0].split("#")[0];

        path = path.replace(/\\/g, '/').split(/\//);

        path[ path.length - 1 ] = "";

        while (path.length) {

            if (( tmp = path.shift() ) === "..") {
                res.pop();
            } else if (tmp !== ".") {
                res.push(tmp);
            }

        }

        return protocol + res.join("/");

    }

    window.UE = {
        getUEBasePath: getUEBasePath
    };

})();
