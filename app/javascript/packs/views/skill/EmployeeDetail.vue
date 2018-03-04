
<template>
	<section>
	  <!-- 基本情報 -->
	  <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span >人財太郎</span>
        <el-button style="float: right; padding: 3px 0" type="text">何かの操作</el-button>
      </div>
      <el-row :gutter="20">
        <el-col :span="12">
          <div class="item label">社員No.</div>
          <div class="text content">
            440
          </div>
        </el-col>
        <el-col :span="12">
          <div class="text label">年齢</div>
          <div class="text content">
            37
          </div>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24">
          <div class="text label">得意領域</div>
          <div class="text content">
            JavaでのWeb開発、BtoCサイトのディレクション
            アーキテクト
          </div>
        </el-col>
      </el-row>      
      <el-row>
        <el-col :span="24">
          <div class="text label">特記事項</div>
          <div class="text content">
            最近眼精疲労で長時間の作業が厳しい
          </div>
        </el-col>
      </el-row>      
    </el-card>
	  
	  <!-- スキルタグ -->
	  <el-collapse v-model="activeNames">
      <el-collapse-item v-for="(category, key, index) in dynamicCategories" 
          :key="category.id" :title="category.name" :name="category.id">
        <el-tag
          :key="tag"
          v-for="tag in category.items"
          :disable-transitions="false"
          >
          {{tag}}
        </el-tag>
      </el-collapse-item>
    </el-collapse>

	</section>
</template>


<script>
  export default {
    data() {
      return {
        //アコーディオンとタグのデータ
        dynamicCategories: [ {id:'1',name:'言語', items:['java','C#','PHP','VB']},
                              {id:'2', name:'フレームワーク',  items:['spring','struts2','cakePHP','.net','iBatis','dbflute']},
                              {id:'3', name:'OS・DB・ミドルウェア', items:['Linux','Oracle','MySQL','postgresql','Apache','Tomcat','redis','memcached']},
                              {id:'4', name:'業種', items:['人材紹介','保険代理店','小売','流通','不動産']},
                              {id:'5', name:'ポジション', items:['PM','サブリーダー']},
                              {id:'6', name:'フェーズ', items:['要件定義','基本設計(外部設計)','詳細設計(内部設計)','結合テスト','総合テスト']},
                              {id:'7', name:'資格', items:['PMP','ITIL','Oracle Gold']},
                            ],
        //アコーディオンを最初から全て展開する
        activeNames: ['1','2','3','4','5','6','7'],
        
      };
    },
    methods: {
    }
  }
</script>

<style scoped lang="scss">
/* 基本情報カードのスタイル */
  .el-row {
    margin-bottom: 20px;
    &:last-child {
      margin-bottom: 0;
    }
  }
  
  .item {
    color :red;
  }
  
  .label {
    color : gray;
  }
  
  .content {
    color : navy;
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
    width: 600px;
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