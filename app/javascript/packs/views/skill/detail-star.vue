<!-- 星型入力のイメージ //TODO 仮実装なので用が済んだら消す -->
<template>
	<section>
	  <!-- 基本情報 -->
	  <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span >人財太郎</span>
        <el-button style="float: right; padding: 3px 0" type="text">何かの操作</el-button>
      </div>
      <div class="text item">
        社員No.
      </div>
      <div class="text item">
        氏名
      </div>
      <div class="text item">
        備考
      </div>
    </el-card>
	  
	  <el-checkbox-group v-model="selectedSkills" size="small" text-color="#FFF" fill="#409EFF">
  	  <!-- スキルタグ -->
  	  <el-collapse v-model="activeNames">
        <el-collapse-item v-for="(category, key, index) in dynamicCategories" 
            :key="category.id" :title="category.name" :name="category.id">
          
          <!--
          <el-checkbox :key="tag" v-for="tag in category.items" :label="tag" border>
          </el-checkbox>
          -->
          
          <el-tag
            :key="tag"
            v-for="tag in category.items"
            closable
            :disable-transitions="false"
            @close="handleClose(category.items,tag)">
            {{tag}}
            <el-rate :max="3"></el-rate>

          </el-tag>
          
          <el-input
            class="input-new-tag"
            v-show="category.inputVisible"
            v-model="category.inputValue"
            ref="saveTagInput"
            size="mini"
            @keyup.enter.native="handleInputConfirm(category)"
            @blur="handleInputConfirm(category)"
          >
          </el-input>
          <el-button v-show="category.inputVisible === false" class="button-new-tag" size="small" @click="showInput(category)">+ 追加</el-button>        
  
        </el-collapse-item>
      </el-collapse>
    </el-checkbox-group>

	</section>
</template>


<script>
  export default {
    data() {
      return {
        //アコーディオンとタグのデータ
        dynamicCategories: [ {id:'1',name:'言語', inputVisible:false ,inputValue:'' ,items:['java','C#','PHP','VB']},
                              {id:'2', name:'フレームワーク', inputVisible:false ,inputValue:'' , items:['spring','struts2','cakePHP','.net','iBatis','dbflute']},
                              {id:'3', name:'OS・DB・ミドルウェア', inputVisible:false ,inputValue:'' ,items:['Linux','Oracle','MySQL','postgresql','Apache','Tomcat','redis','memcached']},
                              {id:'4', name:'業種', inputVisible:false ,inputValue:'' ,items:['人材紹介','保険代理店','小売','流通','不動産']},
                              {id:'5', name:'ポジション', inputVisible:false ,inputValue:'' ,items:['PM','サブリーダー']},
                              {id:'6', name:'フェーズ', inputVisible:false ,inputValue:'' ,items:['要件定義','基本設計(外部設計)','詳細設計(内部設計)','結合テスト','総合テスト']},
                              {id:'7', name:'資格', inputVisible:false ,inputValue:'' ,items:['PMP','ITIL','Oracle Gold']},
                            ],
        //アコーディオンを最初から全て展開する
        activeNames: ['1','2','3','4','5','6','7'],
        
        //タグ
        selectedSkills: ['VB','java']
        // inputVisible: false,
        // inputValue: ''
        
      };
    },
    methods: {
      //タグ削除
      handleClose(items,tag) {
        console.log(items);
        console.log(tag);
        items.splice(items.indexOf(tag), 1);
      },
      
      //タグ追加のテキストボックス表示
      showInput(category) {
        //表示フラグを立てる
        category.inputVisible = true;
        //テキストボックスが表示されるまでタイムラグがあるので nextTickに表示後の処理
        this.$nextTick(_ => {
          //対象のテキストボックスにフォーカスを当てる
          let index = this.dynamicCategories.indexOf(category) ;
          let input = this.$refs.saveTagInput[index];
          input.focus();
        });
      },
      //タグ新規追加
      handleInputConfirm(category) {
        let inputValue = category.inputValue;
        //テキスト未入力の場合は、追加しない
        if (inputValue ) {
          //TODO 重複チェックは追加時にサーバ側でやった方がいい
          // 同カテゴリの既存タグと重複する場合はエラー
          if (category.items.indexOf(inputValue) >= 0) {
            this.$message.error('入力されたスキルはリストにあります。リストから選択ください。');
          } else {
            //タグ追加
            category.items.push(inputValue);
          }
        }
        category.inputVisible = false;
        category.inputValue = '';
      }      
    }
  }
</script>

<style>
/* 基本情報カードのスタイル */
  .item {
    margin-bottom: 18px;
  }

  .clearfix:before,
  .clearfix:after {
    display: table;
    content: "";
  }
  .clearfix:after {
    clear: both
  }

  .box-card {
    width: 480px;
  }

/* タグのスタイル */
  .el-tag + .el-tag {
    margin-left: 10px;
  }
  .button-new-tag {
    margin-left: 10px;
    height: 32px;
    line-height: 30px;
    padding-top: 0;
    padding-bottom: 0;
  }
  .input-new-tag {
    width: 90px;
    margin-left: 10px;
    vertical-align: bottom;
  }
</style>