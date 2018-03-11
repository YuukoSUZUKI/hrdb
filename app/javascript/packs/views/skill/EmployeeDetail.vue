
<template>
	<el-dialog title="個人詳細" :visible="dialogVisible" @open="handleOpen" @close="handleClose" custom-class="dialog-detail">
		<!-- 個人詳細画面のコンポーネント -->
		<div class="employee-detail-container">
  	<section>

	  <!-- 基本情報 -->
	  <el-card class="box-card" v-loading="loading">
      <div slot="header" class="clearfix">
        <span class="employee-name">{{name}}</span>
        <!--<el-button style="float: right; padding: 3px 0" type="text">何かの操作</el-button>-->
      </div>
      <el-row :gutter="20">
        <el-col :span="12">
          <div class="item label">社員No.</div>
          <div class="text content">
            {{employee_number}}
          </div>
        </el-col>
        <el-col :span="12">
          <div class="text label">年齢</div>
          <div class="text content">
            {{age}}
          </div>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24">
          <div class="text label">得意領域</div>
          <div class="text content">
            {{speciality}}
          </div>
        </el-col>
      </el-row>      
      <el-row>
        <el-col :span="24">
          <div class="text label">特記事項</div>
          <div class="text content">
            {{memo}}
          </div>
        </el-col>
      </el-row>      
    </el-card>
    <el-tabs type="border-card" v-model="activeTabName" class="detail-tabs">
      <el-tab-pane label="保有スキル" name="skill">
        <!-- スキルタグ -->
    	  <el-collapse v-model="activeNames">
          <el-collapse-item v-for="(category, key, index) in skillCategories" 
              :key="category.id" :name="category.id">
            <template slot="title">
              {{category.skill_category_name}} <el-tag size="mini" type="info" class="skill-count">{{category.skills.length}}</el-tag>
            </template>
            <el-tag
              :key="skill.id"
              v-for="skill in category.skills"
              :disable-transitions="false"
              >
              {{skill.skill_name}}
            </el-tag>
          </el-collapse-item>
        </el-collapse>
      </el-tab-pane>
      <el-tab-pane label="職務経歴" name="history">
        TODO 職務経歴を表示する
      </el-tab-pane>
	  </el-tabs>

	</section>
	</div>
  <span slot="footer" class="dialog-footer">
    <el-button @click="handleClose">閉じる</el-button>
  </span>
</el-dialog>

</template>


<script>
	import { getEmployee } from '../../api/api';
	
  export default {
    props: ['employee_id' , 'dialogVisible'],
    data: function() {
      return {
        name: '',
        employee_number: '',
        age: '',
        speciality: '',
        memo: '',
        //アコーディオンとタグのデータ(モック時の初期値)
        skillCategories: [ {id:'1',skill_category_name:'言語', skills:[{skill_name:'java'},{skill_name:'C#'},{skill_name:'PHP'},{skill_name:'VB'}]},
                              {id:'2', skill_category_name:'フレームワーク',  skills:[{skill_name:'spring'},{skill_name:'struts2'},{skill_name:'cakePHP'},{skill_name:'.net'},{skill_name:'iBatis'},{skill_name:'dbflute'}]},
                              {id:'3', skill_category_name:'OS・DB・ミドルウェア', skills:[{skill_name:'Linux'},{skill_name:'Oracle'},{skill_name:'MySQL'},{skill_name:'postgresql'},{skill_name:'Apache'},{skill_name:'Tomcat'},{skill_name:'redis'},{skill_name:'memcached'}]},
                              {id:'4', skill_category_name:'業種', skills:[{skill_name:'人材紹介'},{skill_name:'保険代理店'},{skill_name:'小売'},{skill_name:'流通'},{skill_name:'不動産'}]},
                              {id:'5', skill_category_name:'ポジション', skills:[{skill_name:'PM'},{skill_name:'サブリーダー'}]},
                              {id:'6', skill_category_name:'フェーズ', skills:[{skill_name:'要件定義'},{skill_name:'基本設計(外部設計)'},{skill_name:'詳細設計(内部設計)'},{skill_name:'結合テスト'},{skill_name:'総合テスト'}]},
                              {id:'7', skill_category_name:'資格', skills:[{skill_name:'PMP'},{skill_name:'ITIL'},{skill_name:'Oracle Gold'}]},
                            ],
        //アコーディオンを最初から全て展開する
        activeNames: [],
        activeTabName: 'skill',
        //ローディングアイコン
        loading: false,
      };
    },
    methods: {
      handleOpen:function(){
        this.loading = true; //ローディングアイコン
        //employee_idをキーに個人詳細情報を取得
        var vueInstance = this ;
				getEmployee(this.employee_id).then(response => {
				  //APIの結果を画面にセット
					vueInstance.name = response.data.name;
					vueInstance.employee_number = response.data.employee_number;
					vueInstance.speciality = response.data.speciality;
					vueInstance.memo = response.data.memo;
					//スキル階層
					vueInstance.skillCategories = response.data.skill_categories;
					
					response.data.skill_categories.forEach(function(category){
						console.log('activeNames'+ category.id)
					  vueInstance.activeNames.push(category.id);
					});
					vueInstance.loading = false;
				})
				.catch(error => {
					if (! error.response) {
						console.log('error: network error.')
					} else {
						console.log(error);
					}
					vueInstance.loading = false;
				})
      },
      //ダイアログを閉じる処理
      handleClose: function(){
        //モデルを初期化
        this.name= '',
        this.employee_number= '',
        this.age= '',
        this.speciality= '',
        this.memo= '',
        this.skillCategories=[];
        this.activeNames= [];
        this.activeTabName= 'skill';

        //親コンポーネントへダイアログが閉じたことを通知
        this.$emit('update:dialogVisible', false)
      },
    },
  }
</script>

<style scoped lang="scss">
  .dialog-detail {
	  min-width :650px;
  }
  .employee-detail-container {
  	width :600px;
  	margin : 0 auto;
  }
/* 基本情報カードのスタイル */
  .box-card {
    width: 600px;
    margin-top: 16px;
  }
  .employee-name {
    font-size : 20px;
  }
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
    font-size : 12px;
    color : #777;
  }
  .content {
    font-size : 16px;
  }

  .clearfix:before,
  .clearfix:after {
    display: table;
    content: "";
  }
  .clearfix:after {
    clear: both
  }
/* スキル数のバッジ*/
  .skill-count {
    margin-left:0.5rem;
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
  .detail-tabs {
    margin-top:2em;
  }
</style>