<template>
	<section>
		<!--工具条-->
		<el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
			<el-form :inline="true" :model="filters">
				<!-- 検索ボックス(オートコンプリート) -->
				<el-form-item>
					<el-autocomplete
				      class="inline-input"
				      v-model="filters.name"
				      :fetch-suggestions="querySearch"
				      placeholder="スキル・業種"
				      @select="handleSelect"
				    >
					</el-autocomplete>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" icon="el-icon-search" v-on:click="getUser">検索</el-button>
				</el-form-item>
				<el-form-item>
					<el-button type="default" @click="dialogFormVisible = true" >詳細な条件で検索</el-button>
				</el-form-item>
			</el-form>
		</el-col>

		<!--列表-->
		<template>
			<el-table :data="users" highlight-current-row v-loading="loading" style="width: 100%;"
				@row-click="handleRowSelect">
				<el-table-column type="index" width="60">
				</el-table-column>
				<el-table-column prop="employee_number" label="社員No." width="120" sortable>
				</el-table-column>
				<el-table-column prop="name" label="氏名" width="120" sortable>
				</el-table-column>
				<el-table-column prop="speciality" label="得意領域">
				</el-table-column>
				<el-table-column label="" width="60">
					<template slot-scope="scope">
						<i class="el-icon-arrow-right"></i>
		      </template>
				</el-table-column>
			</el-table>
		</template>

		<!-- 詳細検索ダイアログ -->
		<el-dialog title="スキル詳細検索" :visible.sync="dialogFormVisible" :center=true custom-class="dialog-search">
		  <el-form :model="detailform" label-position="left">
		    <el-form-item label="氏名" :label-width="formLabelWidth">
		      <el-input v-model="detailform.name" auto-complete="off"></el-input>
		    </el-form-item>
				  <el-checkbox-group v-model="detailform.selectedSkills" size="small" text-color="#FFF" fill="#409EFF">
			  	  <!-- スキルタグ -->
			  	  <el-collapse >
			        <el-collapse-item v-for="(category, key, index) in dynamicCategories" 
			            :key="category.id" :title="category.catName" >
			          
			          <el-checkbox :key="tag" v-for="tag in category.items" :label="tag" border>
			          </el-checkbox>
			          
			        </el-collapse-item>
			      </el-collapse>
			    </el-checkbox-group>

		  </el-form>
		  <span slot="footer" class="dialog-footer">
		    <el-button @click="dialogFormVisible = false">キャンセル</el-button>
		    <el-button type="primary" icon="el-icon-search" @click="detailedSearch">検索</el-button>
		  </span>
		</el-dialog>


	</section>
</template>
<script>
	import { getUserList } from '../../api/api';
	//import NProgress from 'nprogress'
	export default {
		data() {
			return {
				filters: {
					name: ''
				},
				loading: false,
				users: [
				],
        links: [], 
        
        //詳細検索ダイアログ
        dialogFormVisible: false,
        detailform: {
          name: '二郎',
          //スキルチェックボックス
	        selectedSkills: ['VB','java'],
        },
        formLabelWidth: '120px',
        //アコーディオンとタグのデータ
	      dynamicCategories: [ {id:'1',catName:'言語', inputVisible:false ,inputValue:'' ,items:['java','C#','PHP','VB']},
	                              {id:'2', catName:'フレームワーク', inputVisible:false ,inputValue:'' , items:['spring','struts2','cakePHP','.net','iBatis','dbflute']},
	                              {id:'3', catName:'OS・DB・ミドルウェア', inputVisible:false ,inputValue:'' ,items:['Linux','Oracle','MySQL','postgresql','Apache','Tomcat','redis','memcached']},
	                              {id:'4', catName:'業種', inputVisible:false ,inputValue:'' ,items:['人材紹介','保険代理店','小売','流通','不動産']},
	                              {id:'5', catName:'ポジション', inputVisible:false ,inputValue:'' ,items:['PM','サブリーダー']},
	                              {id:'6', catName:'フェーズ', inputVisible:false ,inputValue:'' ,items:['要件定義','基本設計(外部設計)','詳細設計(内部設計)','結合テスト','総合テスト']},
	                              {id:'7', catName:'資格', inputVisible:false ,inputValue:'' ,items:['PMP','ITIL','Oracle Gold']},
	                            ],

			}
		},
		methods: {
			//検索処理
			getUser: function () {
				let para = {
					name: this.filters.name
				};
				this.loading = true;
				//NProgress.start();
				getUserList(para).then((res) => {
					this.users = res.data.users;
					this.loading = false;
					//NProgress.done();
				});
			},
			//オートコンプリート関連
			querySearch(queryString, cb) {
        var links = this.links;
        var results = queryString ? links.filter(this.createFilter(queryString)) : links;
        // call callback function to return suggestions
        cb(results);
      },
      createFilter(queryString) {
        return (link) => {
          return (link.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
        };
      },
      loadAll() {
        return [
          { "value": "vue", "link": "https://github.com/vuejs/vue" },
          { "value": "element", "link": "https://github.com/ElemeFE/element" },
          { "value": "cooking", "link": "https://github.com/ElemeFE/cooking" },
          { "value": "mint-ui", "link": "https://github.com/ElemeFE/mint-ui" },
          { "value": "vuex", "link": "https://github.com/vuejs/vuex" },
          { "value": "vue-router", "link": "https://github.com/vuejs/vue-router" },
          { "value": "babel", "link": "https://github.com/babel/babel" }
         ];
      },
      handleSelect(item) {
        console.log(item);
      },
			// /オートコンプリート関連
      
      //詳細検索
      detailedSearch(){
      	this.dialogFormVisible = false;
      	this.getUser();
      },
      
      //行選択
    	handleRowSelect(row, event, column) {
        console.log(column);
        this.$router.push({ path: '/detail', query: { id: row.employeeId }})
			},

		},
		
		mounted() {
			this.getUser();
			//オートコンプリート
      this.links = this.loadAll();
		}
	};

</script>

<style scoped lang="scss">

.dialog-search {
	form {
		overflow-y : scroll;
		height :  350px;
	}
}


</style>