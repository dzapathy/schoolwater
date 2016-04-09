/**
 * ueditor瀹屾暣閰嶇疆椤�
 * 鍙互鍦ㄨ繖閲岄厤缃暣涓紪杈戝櫒鐨勭壒鎬�
 */
/**************************鎻愮ず********************************
 * 鎵�湁琚敞閲婄殑閰嶇疆椤瑰潎涓篣Editor榛樿鍊笺�
 * 淇敼榛樿閰嶇疆璇烽鍏堢‘淇濆凡缁忓畬鍏ㄦ槑纭鍙傛暟鐨勭湡瀹炵敤閫斻�
 * 涓昏鏈変袱绉嶄慨鏀规柟妗堬紝涓�鏄彇娑堟澶勬敞閲婏紝鐒跺悗淇敼鎴愬搴斿弬鏁帮紱鍙︿竴绉嶆槸鍦ㄥ疄渚嬪寲缂栬緫鍣ㄦ椂浼犲叆瀵瑰簲鍙傛暟銆�
 * 褰撳崌绾х紪杈戝櫒鏃讹紝鍙洿鎺ヤ娇鐢ㄦ棫鐗堥厤缃枃浠舵浛鎹㈡柊鐗堥厤缃枃浠�涓嶇敤鎷呭績鏃х増閰嶇疆鏂囦欢涓洜缂哄皯鏂板姛鑳芥墍闇�殑鍙傛暟鑰屽鑷磋剼鏈姤閿欍�
 **************************鎻愮ず********************************/

(function () {

    /**
     * 缂栬緫鍣ㄨ祫婧愭枃浠舵牴璺緞銆傚畠鎵�〃绀虹殑鍚箟鏄細浠ョ紪杈戝櫒瀹炰緥鍖栭〉闈负褰撳墠璺緞锛屾寚鍚戠紪杈戝櫒璧勬簮鏂囦欢锛堝嵆dialog绛夋枃浠跺す锛夌殑璺緞銆�
     * 閴翠簬寰堝鍚屽鍦ㄤ娇鐢ㄧ紪杈戝櫒鐨勬椂鍊欏嚭鐜扮殑绉嶇璺緞闂锛屾澶勫己鐑堝缓璁ぇ瀹朵娇鐢�鐩稿浜庣綉绔欐牴鐩綍鐨勭浉瀵硅矾寰�杩涜閰嶇疆銆�
     * "鐩稿浜庣綉绔欐牴鐩綍鐨勭浉瀵硅矾寰�涔熷氨鏄互鏂滄潬寮�ご鐨勫舰濡�/myProject/ueditor/"杩欐牱鐨勮矾寰勩�
     * 濡傛灉绔欑偣涓湁澶氫釜涓嶅湪鍚屼竴灞傜骇鐨勯〉闈㈤渶瑕佸疄渚嬪寲缂栬緫鍣紝涓斿紩鐢ㄤ簡鍚屼竴UEditor鐨勬椂鍊欙紝姝ゅ鐨刄RL鍙兘涓嶉�鐢ㄤ簬姣忎釜椤甸潰鐨勭紪杈戝櫒銆�
     * 鍥犳锛孶Editor鎻愪緵浜嗛拡瀵逛笉鍚岄〉闈㈢殑缂栬緫鍣ㄥ彲鍗曠嫭閰嶇疆鐨勬牴璺緞锛屽叿浣撴潵璇达紝鍦ㄩ渶瑕佸疄渚嬪寲缂栬緫鍣ㄧ殑椤甸潰鏈�《閮ㄥ啓涓婂涓嬩唬鐮佸嵆鍙�褰撶劧锛岄渶瑕佷护姝ゅ鐨刄RL绛変簬瀵瑰簲鐨勯厤缃�
     * window.UEDITOR_HOME_URL = "/xxxx/xxxx/";
     */
    var URL = window.UEDITOR_HOME_URL || getUEBasePath();

    /**
     * 閰嶇疆椤逛富浣撱�娉ㄦ剰锛屾澶勬墍鏈夋秹鍙婂埌璺緞鐨勯厤缃埆閬楁紡URL鍙橀噺銆�
     */
    window.UEDITOR_CONFIG = {

        //涓虹紪杈戝櫒瀹炰緥娣诲姞涓�釜璺緞锛岃繖涓笉鑳借娉ㄩ噴
        UEDITOR_HOME_URL: URL

        // 鏈嶅姟鍣ㄧ粺涓�姹傛帴鍙ｈ矾寰�
        , serverUrl: URL + "jsp/controller.jsp"

        //宸ュ叿鏍忎笂鐨勬墍鏈夌殑鍔熻兘鎸夐挳鍜屼笅鎷夋锛屽彲浠ュ湪new缂栬緫鍣ㄧ殑瀹炰緥鏃堕�鎷╄嚜宸遍渶瑕佺殑浠庢柊瀹氫箟
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
        //褰撻紶鏍囨斁鍦ㄥ伐鍏锋爮涓婃椂鏄剧ず鐨則ooltip鎻愮ず,鐣欑┖鏀寔鑷姩澶氳瑷�厤缃紝鍚﹀垯浠ラ厤缃�涓哄噯
        //,labelMap:{
        //    'anchor':'', 'undo':''
        //}

        //璇█閰嶇疆椤�榛樿鏄痾h-cn銆傛湁闇�鐨勮瘽涔熷彲浠ヤ娇鐢ㄥ涓嬭繖鏍风殑鏂瑰紡鏉ヨ嚜鍔ㄥ璇█鍒囨崲锛屽綋鐒讹紝鍓嶆彁鏉′欢鏄痩ang鏂囦欢澶逛笅瀛樺湪瀵瑰簲鐨勮瑷�枃浠讹細
        //lang鍊间篃鍙互閫氳繃鑷姩鑾峰彇 (navigator.language||navigator.browserLanguage ||navigator.userLanguage).toLowerCase()
        //,lang:"zh-cn"
        //,langPath:URL +"lang/"

        //涓婚閰嶇疆椤�榛樿鏄痙efault銆傛湁闇�鐨勮瘽涔熷彲浠ヤ娇鐢ㄥ涓嬭繖鏍风殑鏂瑰紡鏉ヨ嚜鍔ㄥ涓婚鍒囨崲锛屽綋鐒讹紝鍓嶆彁鏉′欢鏄痶hemes鏂囦欢澶逛笅瀛樺湪瀵瑰簲鐨勪富棰樻枃浠讹細
        //鐜版湁濡備笅鐨偆:default
        //,theme:'default'
        //,themePath:URL +"themes/"

        ,zIndex : 0     //缂栬緫鍣ㄥ眰绾х殑鍩烘暟,榛樿鏄�00

        //閽堝getAllHtml鏂规硶锛屼細鍦ㄥ搴旂殑head鏍囩涓鍔犺缂栫爜璁剧疆銆�
        //,charset:"utf-8"

        //鑻ュ疄渚嬪寲缂栬緫鍣ㄧ殑椤甸潰鎵嬪姩淇敼鐨刣omain锛屾澶勯渶瑕佽缃负true
        //,customDomain:false

        //甯哥敤閰嶇疆椤圭洰
        //,isShow : true    //榛樿鏄剧ず缂栬緫鍣�

        //,textarea:'editorValue' // 鎻愪氦琛ㄥ崟鏃讹紝鏈嶅姟鍣ㄨ幏鍙栫紪杈戝櫒鎻愪氦鍐呭鐨勬墍鐢ㄧ殑鍙傛暟锛屽瀹炰緥鏃跺彲浠ョ粰瀹瑰櫒name灞炴�锛屼細灏唍ame缁欏畾鐨勫�鏈�负姣忎釜瀹炰緥鐨勯敭鍊硷紝涓嶇敤姣忔瀹炰緥鍖栫殑鏃跺�閮借缃繖涓�

        //,initialContent:'娆㈣繋浣跨敤ueditor!'    //鍒濆鍖栫紪杈戝櫒鐨勫唴瀹�涔熷彲浠ラ�杩噒extarea/script缁欏�锛岀湅瀹樼綉渚嬪瓙

        //,autoClearinitialContent:true //鏄惁鑷姩娓呴櫎缂栬緫鍣ㄥ垵濮嬪唴瀹癸紝娉ㄦ剰锛氬鏋渇ocus灞炴�璁剧疆涓簍rue,杩欎釜涔熶负鐪燂紝閭ｄ箞缂栬緫鍣ㄤ竴涓婃潵灏变細瑙﹀彂瀵艰嚧鍒濆鍖栫殑鍐呭鐪嬩笉鍒颁簡

        //,focus:false //鍒濆鍖栨椂锛屾槸鍚﹁缂栬緫鍣ㄨ幏寰楃劍鐐箃rue鎴杅alse

        //濡傛灉鑷畾涔夛紝鏈�ソ缁檖鏍囩濡備笅鐨勮楂橈紝瑕佷笉杈撳叆涓枃鏃讹紝浼氭湁璺冲姩鎰�
        //,initialStyle:'p{line-height:1em}'//缂栬緫鍣ㄥ眰绾х殑鍩烘暟,鍙互鐢ㄦ潵鏀瑰彉瀛椾綋绛�

        //,iframeCssUrl: URL + '/themes/iframe.css' //缁欑紪杈戝櫒鍐呴儴寮曞叆涓�釜css鏂囦欢

        //indentValue
        //棣栬缂╄繘璺濈,榛樿鏄�em
        //,indentValue:'2em'

        //,initialFrameWidth:1000  //鍒濆鍖栫紪杈戝櫒瀹藉害,榛樿1000
        ,initialFrameHeight:400  //鍒濆鍖栫紪杈戝櫒楂樺害,榛樿320

        //,readonly : false //缂栬緫鍣ㄥ垵濮嬪寲缁撴潫鍚�缂栬緫鍖哄煙鏄惁鏄彧璇荤殑锛岄粯璁ゆ槸false

        //,autoClearEmptyNode : true //getContent鏃讹紝鏄惁鍒犻櫎绌虹殑inlineElement鑺傜偣锛堝寘鎷祵濂楃殑鎯呭喌锛�

        //鍚敤鑷姩淇濆瓨
        //,enableAutoSave: true
        //鑷姩淇濆瓨闂撮殧鏃堕棿锛�鍗曚綅ms
        //,saveInterval: 500

        ,fullscreen : false //鏄惁寮�惎鍒濆鍖栨椂鍗冲叏灞忥紝榛樿鍏抽棴

        //,imagePopup:true      //鍥剧墖鎿嶄綔鐨勬诞灞傚紑鍏筹紝榛樿鎵撳紑

        //,autoSyncData:true //鑷姩鍚屾缂栬緫鍣ㄨ鎻愪氦鐨勬暟鎹�
        //,emotionLocalization:false //鏄惁寮�惎琛ㄦ儏鏈湴鍖栵紝榛樿鍏抽棴銆傝嫢瑕佸紑鍚纭繚emotion鏂囦欢澶逛笅鍖呭惈瀹樼綉鎻愪緵鐨刬mages琛ㄦ儏鏂囦欢澶�

        //绮樿创鍙繚鐣欐爣绛撅紝鍘婚櫎鏍囩鎵�湁灞炴�
        //,retainOnlyLabelPasted: false

        //,pasteplain:false  //鏄惁榛樿涓虹函鏂囨湰绮樿创銆俧alse涓轰笉浣跨敤绾枃鏈矘璐达紝true涓轰娇鐢ㄧ函鏂囨湰绮樿创
        //绾枃鏈矘璐存ā寮忎笅鐨勮繃婊よ鍒�
        //'filterTxtRules' : function(){
        //    function transP(node){
        //        node.tagName = 'p';
        //        node.setStyle();
        //    }
        //    return {
        //        //鐩存帴鍒犻櫎鍙婂叾瀛楄妭鐐瑰唴瀹�
        //        '-' : 'script style object iframe embed input select',
        //        'p': {$:{}},
        //        'br':{$:{}},
        //        'div':{'$':{}},
        //        'li':{'$':{}},
        //        'caption':transP,
        //        'th':transP,
        //        'tr':transP,
        //        'h1':transP,'h2':transP,'h3':transP,'h4':transP,'h5':transP,'h6':transP,
        //        'td':function(node){
        //            //娌℃湁鍐呭鐨則d鐩存帴鍒犳帀
        //            var txt = !!node.innerText();
        //            if(txt){
        //                node.parentNode.insertAfter(UE.uNode.createText(' &nbsp; &nbsp;'),node);
        //            }
        //            node.parentNode.removeChild(node,node.innerText())
        //        }
        //    }
        //}()

        //,allHtmlEnabled:false //鎻愪氦鍒板悗鍙扮殑鏁版嵁鏄惁鍖呭惈鏁翠釜html瀛楃涓�

        //insertorderedlist
        //鏈夊簭鍒楄〃鐨勪笅鎷夐厤缃�鍊肩暀绌烘椂鏀寔澶氳瑷�嚜鍔ㄨ瘑鍒紝鑻ラ厤缃�锛屽垯浠ユ鍊间负鍑�
        //,'insertorderedlist':{
        //      //鑷畾鐨勬牱寮�
        //        'num':'1,2,3...',
        //        'num1':'1),2),3)...',
        //        'num2':'(1),(2),(3)...',
        //        'cn':'涓�浜�涓�...',
        //        'cn1':'涓�,浜�,涓�....',
        //        'cn2':'(涓�,(浜�,(涓�....',
        //     //绯荤粺鑷甫
        //     'decimal' : '' ,         //'1,2,3...'
        //     'lower-alpha' : '' ,    // 'a,b,c...'
        //     'lower-roman' : '' ,    //'i,ii,iii...'
        //     'upper-alpha' : '' , lang   //'A,B,C'
        //     'upper-roman' : ''      //'I,II,III...'
        //}

        //insertunorderedlist
        //鏃犲簭鍒楄〃鐨勪笅鎷夐厤缃紝鍊肩暀绌烘椂鏀寔澶氳瑷�嚜鍔ㄨ瘑鍒紝鑻ラ厤缃�锛屽垯浠ユ鍊间负鍑�
        //,insertunorderedlist : { //鑷畾鐨勬牱寮�
        //    'dash' :'鈥�鐮存姌鍙�, //-鐮存姌鍙�
        //    'dot':' 銆�灏忓渾鍦�, //绯荤粺鑷甫
        //    'circle' : '',  // '鈼�灏忓渾鍦�
        //    'disc' : '',    // '鈼�灏忓渾鐐�
        //    'square' : ''   //'鈻�灏忔柟鍧�
        //}
        //,listDefaultPaddingLeft : '30'//榛樿鐨勫乏杈圭缉杩涚殑鍩烘暟鍊�
        //,listiconpath : 'http://bs.baidu.com/listicon/'//鑷畾涔夋爣鍙风殑璺緞
        //,maxListLevel : 3 //闄愬埗鍙互tab鐨勭骇鏁� 璁剧疆-1涓轰笉闄愬埗

        //,autoTransWordToList:false  //绂佹word涓矘璐磋繘鏉ョ殑鍒楄〃鑷姩鍙樻垚鍒楄〃鏍囩

        //fontfamily
        //瀛椾綋璁剧疆 label鐣欑┖鏀寔澶氳瑷�嚜鍔ㄥ垏鎹紝鑻ラ厤缃紝鍒欎互閰嶇疆鍊间负鍑�
        //,'fontfamily':[
        //    { label:'',name:'songti',val:'瀹嬩綋,SimSun'},
        //    { label:'',name:'kaiti',val:'妤蜂綋,妤蜂綋_GB2312, SimKai'},
        //    { label:'',name:'yahei',val:'寰蒋闆呴粦,Microsoft YaHei'},
        //    { label:'',name:'heiti',val:'榛戜綋, SimHei'},
        //    { label:'',name:'lishu',val:'闅朵功, SimLi'},
        //    { label:'',name:'andaleMono',val:'andale mono'},
        //    { label:'',name:'arial',val:'arial, helvetica,sans-serif'},
        //    { label:'',name:'arialBlack',val:'arial black,avant garde'},
        //    { label:'',name:'comicSansMs',val:'comic sans ms'},
        //    { label:'',name:'impact',val:'impact,chicago'},
        //    { label:'',name:'timesNewRoman',val:'times new roman'}
        //]

        //fontsize
        //瀛楀彿
        //,'fontsize':[10, 11, 12, 14, 16, 18, 20, 24, 36]

        //paragraph
        //娈佃惤鏍煎紡 鍊肩暀绌烘椂鏀寔澶氳瑷�嚜鍔ㄨ瘑鍒紝鑻ラ厤缃紝鍒欎互閰嶇疆鍊间负鍑�
        //,'paragraph':{'p':'', 'h1':'', 'h2':'', 'h3':'', 'h4':'', 'h5':'', 'h6':''}

        //rowspacingtop
        //娈甸棿璺�鍊煎拰鏄剧ず鐨勫悕瀛楃浉鍚�
        //,'rowspacingtop':['5', '10', '15', '20', '25']

        //rowspacingBottom
        //娈甸棿璺�鍊煎拰鏄剧ず鐨勫悕瀛楃浉鍚�
        //,'rowspacingbottom':['5', '10', '15', '20', '25']

        //lineheight
        //琛屽唴闂磋窛 鍊煎拰鏄剧ず鐨勫悕瀛楃浉鍚�
        //,'lineheight':['1', '1.5','1.75','2', '3', '4', '5']

        //customstyle
        //鑷畾涔夋牱寮忥紝涓嶆敮鎸佸浗闄呭寲锛屾澶勯厤缃�鍗冲彲鏈�悗鏄剧ず鍊�
        //block鐨勫厓绱犳槸渚濇嵁璁剧疆娈佃惤鐨勯�杈戣缃殑锛宨nline鐨勫厓绱犱緷鎹瓸IU鐨勯�杈戣缃�
        //灏介噺浣跨敤涓�簺甯哥敤鐨勬爣绛�
        //鍙傛暟璇存槑
        //tag 浣跨敤鐨勬爣绛惧悕瀛�
        //label 鏄剧ず鐨勫悕瀛椾篃鏄敤鏉ユ爣璇嗕笉鍚岀被鍨嬬殑鏍囪瘑绗︼紝娉ㄦ剰杩欎釜鍊兼瘡涓涓嶅悓锛�
        //style 娣诲姞鐨勬牱寮�
        //姣忎竴涓璞″氨鏄竴涓嚜瀹氫箟鐨勬牱寮�
        //,'customstyle':[
        //    {tag:'h1', name:'tc', label:'', style:'border-bottom:#ccc 2px solid;padding:0 4px 0 0;text-align:center;margin:0 0 20px 0;'},
        //    {tag:'h1', name:'tl',label:'', style:'border-bottom:#ccc 2px solid;padding:0 4px 0 0;margin:0 0 10px 0;'},
        //    {tag:'span',name:'im', label:'', style:'font-style:italic;font-weight:bold'},
        //    {tag:'span',name:'hi', label:'', style:'font-style:italic;font-weight:bold;color:rgb(51, 153, 204)'}
        //]

        //鎵撳紑鍙抽敭鑿滃崟鍔熻兘
        //,enableContextMenu: true
        //鍙抽敭鑿滃崟鐨勫唴瀹癸紝鍙互鍙傝�plugins/contextmenu.js閲岃竟鐨勯粯璁よ彍鍗曠殑渚嬪瓙锛宭abel鐣欑┖鏀寔鍥介檯鍖栵紝鍚﹀垯浠ユ閰嶇疆涓哄噯
        //,contextMenu:[
        //    {
        //        label:'',       //鏄剧ず鐨勫悕绉�
        //        cmdName:'selectall',//鎵ц鐨刢ommand鍛戒护锛屽綋鐐瑰嚮杩欎釜鍙抽敭鑿滃崟鏃�
        //        //exec鍙�锛屾湁浜唀xec灏变細鍦ㄧ偣鍑绘椂鎵ц杩欎釜function锛屼紭鍏堢骇楂樹簬cmdName
        //        exec:function () {
        //            //this鏄綋鍓嶇紪杈戝櫒鐨勫疄渚�
        //            //this.ui._dialogs['inserttableDialog'].open();
        //        }
        //    }
        //]

        //蹇嵎鑿滃崟
        //,shortcutMenu:["fontfamily", "fontsize", "bold", "italic", "underline", "forecolor", "backcolor", "insertorderedlist", "insertunorderedlist"]

        //elementPathEnabled
        //鏄惁鍚敤鍏冪礌璺緞锛岄粯璁ゆ槸鏄剧ず
        ,elementPathEnabled : false

        //wordCount
        //,wordCount:true          //鏄惁寮�惎瀛楁暟缁熻
        //,maximumWords:10000       //鍏佽鐨勬渶澶у瓧绗︽暟
        //瀛楁暟缁熻鎻愮ず锛寋#count}浠ｈ〃褰撳墠瀛楁暟锛寋#leave}浠ｈ〃杩樺彲浠ヨ緭鍏ュ灏戝瓧绗︽暟,鐣欑┖鏀寔澶氳瑷�嚜鍔ㄥ垏鎹紝鍚﹀垯鎸夋閰嶇疆鏄剧ず
        //,wordCountMsg:''   //褰撳墠宸茶緭鍏�{#count} 涓瓧绗︼紝鎮ㄨ繕鍙互杈撳叆{#leave} 涓瓧绗�
        //瓒呭嚭瀛楁暟闄愬埗鎻愮ず  鐣欑┖鏀寔澶氳瑷�嚜鍔ㄥ垏鎹紝鍚﹀垯鎸夋閰嶇疆鏄剧ず
        //,wordOverFlowMsg:''    //<span style="color:red;">浣犺緭鍏ョ殑瀛楃涓暟宸茬粡瓒呭嚭鏈�ぇ鍏佽鍊硷紝鏈嶅姟鍣ㄥ彲鑳戒細鎷掔粷淇濆瓨锛�/span>

        //tab
        //鐐瑰嚮tab閿椂绉诲姩鐨勮窛绂�tabSize鍊嶆暟锛宼abNode浠�箞瀛楃鍋氫负鍗曚綅
        //,tabSize:4
        //,tabNode:'&nbsp;'

        //removeFormat
        //娓呴櫎鏍煎紡鏃跺彲浠ュ垹闄ょ殑鏍囩鍜屽睘鎬�
        //removeForamtTags鏍囩
        //,removeFormatTags:'b,big,code,del,dfn,em,font,i,ins,kbd,q,samp,small,span,strike,strong,sub,sup,tt,u,var'
        //removeFormatAttributes灞炴�
        //,removeFormatAttributes:'class,style,lang,width,height,align,hspace,valign'

        //undo
        //鍙互鏈�鍥為�鐨勬鏁�榛樿20
        //,maxUndoCount:20
        //褰撹緭鍏ョ殑瀛楃鏁拌秴杩囪鍊兼椂锛屼繚瀛樹竴娆＄幇鍦�
        //,maxInputCount:1

        //autoHeightEnabled
        // 鏄惁鑷姩闀块珮,榛樿true
        ,autoHeightEnabled:false

        //scaleEnabled
        //鏄惁鍙互鎷変几闀块珮,榛樿true(褰撳紑鍚椂锛岃嚜鍔ㄩ暱楂樺け鏁�
        ,scaleEnabled:false
        //,minFrameWidth:800    //缂栬緫鍣ㄦ嫋鍔ㄦ椂鏈�皬瀹藉害,榛樿800
        //,minFrameHeight:220  //缂栬緫鍣ㄦ嫋鍔ㄦ椂鏈�皬楂樺害,榛樿220

        //autoFloatEnabled
        //鏄惁淇濇寔toolbar鐨勪綅缃笉鍔�榛樿true
        //,autoFloatEnabled:true
        //娴姩鏃跺伐鍏锋爮璺濈娴忚鍣ㄩ《閮ㄧ殑楂樺害锛岀敤浜庢煇浜涘叿鏈夊浐瀹氬ご閮ㄧ殑椤甸潰
        //,topOffset:30
        //缂栬緫鍣ㄥ簳閮ㄨ窛绂诲伐鍏锋爮楂樺害(濡傛灉鍙傛暟澶т簬绛変簬缂栬緫鍣ㄩ珮搴︼紝鍒欒缃棤鏁�
        //,toolbarTopOffset:400

        //pageBreakTag
        //鍒嗛〉鏍囪瘑绗�榛樿鏄痏ueditor_page_break_tag_
        //,pageBreakTag:'_ueditor_page_break_tag_'

        //autotypeset
        //鑷姩鎺掔増鍙傛暟
        //,autotypeset: {
        //    mergeEmptyline: true,           //鍚堝苟绌鸿
        //    removeClass: true,              //鍘绘帀鍐椾綑鐨刢lass
        //    removeEmptyline: false,         //鍘绘帀绌鸿
        //    textAlign:"left",               //娈佃惤鐨勬帓鐗堟柟寮忥紝鍙互鏄�left,right,center,justify 鍘绘帀杩欎釜灞炴�琛ㄧず涓嶆墽琛屾帓鐗�
        //    imageBlockLine: 'center',       //鍥剧墖鐨勬诞鍔ㄦ柟寮忥紝鐙崰涓�鍓т腑,宸﹀彸娴姩锛岄粯璁� center,left,right,none 鍘绘帀杩欎釜灞炴�琛ㄧず涓嶆墽琛屾帓鐗�
        //    pasteFilter: false,             //鏍规嵁瑙勫垯杩囨护娌′簨绮樿创杩涙潵鐨勫唴瀹�
        //    clearFontSize: false,           //鍘绘帀鎵�湁鐨勫唴宓屽瓧鍙凤紝浣跨敤缂栬緫鍣ㄩ粯璁ょ殑瀛楀彿
        //    clearFontFamily: false,         //鍘绘帀鎵�湁鐨勫唴宓屽瓧浣擄紝浣跨敤缂栬緫鍣ㄩ粯璁ょ殑瀛椾綋
        //    removeEmptyNode: false,         // 鍘绘帀绌鸿妭鐐�
        //    //鍙互鍘绘帀鐨勬爣绛�
        //    removeTagNames: {鏍囩鍚嶅瓧:1},
        //    indent: false,                  // 琛岄缂╄繘
        //    indentValue : '2em',            //琛岄缂╄繘鐨勫ぇ灏�
        //    bdc2sb: false,
        //    tobdc: false
        //}

        //tableDragable
        //琛ㄦ牸鏄惁鍙互鎷栨嫿
        //,tableDragable: true

        //,disabledTableInTable:true  //绂佹琛ㄦ牸宓屽

        //sourceEditor
        //婧愮爜鐨勬煡鐪嬫柟寮�codemirror 鏄唬鐮侀珮浜紝textarea鏄枃鏈,榛樿鏄痗odemirror
        //娉ㄦ剰榛樿codemirror鍙兘鍦╥e8+鍜岄潪ie涓娇鐢�
        //,sourceEditor:"codemirror"
        //濡傛灉sourceEditor鏄痗odemirror锛岃繕鐢ㄩ厤缃竴涓嬩袱涓弬鏁�
        //codeMirrorJsUrl js鍔犺浇鐨勮矾寰勶紝榛樿鏄�URL + "third-party/codemirror/codemirror.js"
        //,codeMirrorJsUrl:URL + "third-party/codemirror/codemirror.js"
        //codeMirrorCssUrl css鍔犺浇鐨勮矾寰勶紝榛樿鏄�URL + "third-party/codemirror/codemirror.css"
        //,codeMirrorCssUrl:URL + "third-party/codemirror/codemirror.css"
        //缂栬緫鍣ㄥ垵濮嬪寲瀹屾垚鍚庢槸鍚﹁繘鍏ユ簮鐮佹ā寮忥紝榛樿涓哄惁銆�
        //,sourceEditorFirst:false

        //iframeUrlMap
        //dialog鍐呭鐨勮矾寰�锝炰細琚浛鎹㈡垚URL,鍨撳睘鎬т竴鏃︽墦寮�紝灏嗚鐩栨墍鏈夌殑dialog鐨勯粯璁よ矾寰�
        //,iframeUrlMap:{
        //    'anchor':'~/dialogs/anchor/anchor.html',
        //}

        //webAppKey 鐧惧害搴旂敤鐨凙PIkey锛屾瘡涓珯闀垮繀椤婚鍏堝幓鐧惧害瀹樼綉娉ㄥ唽涓�釜key鍚庢柟鑳芥甯镐娇鐢╝pp鍔熻兘锛屾敞鍐屼粙缁嶏紝http://app.baidu.com/static/cms/getapikey.html
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
