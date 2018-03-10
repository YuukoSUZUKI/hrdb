
<template>
	<section>
	  <el-button type="primary" icon="el-icon-arrow-left"  @click="goPrevious">戻る</el-button>
	  
	  <!-- 基本情報 -->
	  <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span class="employee-name">{{employee.name}}</span>
      </div>
      <el-row :gutter="20">
        <el-col :span="12">
          <div class="item label">社員No.</div>
          <div class="text content">
            {{employee.employee_number}}
          </div>
        </el-col>
        <el-col :span="12">
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24">
          <div class="text label">得意領域</div>
          <div class="text content">
            {{employee.speciality}}
          </div>
        </el-col>
      </el-row>      
      <el-row>
        <el-col :span="24">
          <div class="text label">特記事項</div>
          <div class="text content">
            {{employee.memo}}
          </div>
        </el-col>
      </el-row>      
    </el-card>
	  
	  <!-- スキルタグ -->
	  <el-collapse v-model="activeNames">
      <el-collapse-item v-for="(skill_category,index) in dynamicCategories" 
          :key="skill_category.id" :title="skill_category.skill_category_name" >
        <el-tag :key="skill.id" v-for="skill in skill_category.skills" :label="skill.id" :name="skill.skill_name"
          :disable-transitions="false"
          >
          {{skill.skill_name}}
        </el-tag>
      </el-collapse-item>
    </el-collapse>

	</section>
</template>


<script>
	import { getSkillCategoryMap, getEmployee} from '../../api/api';


  export default {
    data() {
      return {
        //アコーディオンとタグのデータ
        dynamicCategories: [],
        //アコーディオンを最初から全て展開する
        activeNames: [],
        employee:{
        	name:"秋田 太郎",
        	employee_number:1234,
        	speciality:"お座りが出来る",
        	memo:"犬種は秋田犬"
        }
      };
    },
    created:function(){
			// スキルカテゴリ・スキル全取得
			getSkillCategoryMap().then(response => {
				console.log(response.status);
				console.log(response.data);
				this.dynamicCategories = response.data.skill_categories;
				this.activeNames = ['1','2','3','4','5','6','7'];
			})
			.catch(error => {
				if (! error.response) {
					console.log('error: network error.')
				} else {
					console.log(error);
				}
				this.loading = false;
			})
		},
    methods: {
      goPrevious(){
        this.$router.go(-1);
      },
      getEmployeeInfo: function(){
      	console.log(this.$route.params.id)
      	let para = {
					id: this.$route.params.id
				};
      	
      	getEmployee(para).then(response => {
					console.log(response.status);
					console.log(response.data);
					this.employee = response.data.employee;
					this.loading = false;
				})
				.catch(error => {
					if (! error.response) {
						console.log('error: network error.')
					} else {
						console.log(error);
					}
					this.loading = false;
				})
      },
    },
    mounted(){
    	this.getEmployeeInfo();
    }
    
  }

</script>

<style scoped lang="scss">
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