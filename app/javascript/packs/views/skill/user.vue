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
					<el-button type="default" >詳細な条件で検索</el-button>
				</el-form-item>
			</el-form>
		</el-col>

		<!--列表-->
		<template>
			<el-table :data="users" highlight-current-row v-loading="loading" style="width: 100%;"
				@row-click="handleRowSelect">
				<el-table-column type="index" width="60">
				</el-table-column>
				<el-table-column prop="employeeId" label="社員No." width="120" sortable>
				</el-table-column>
				<el-table-column prop="name" label="氏名" width="120" sortable>
				</el-table-column>
				<el-table-column prop="sex" label="性别" width="100" :formatter="formatSex" sortable>
				</el-table-column>
				<el-table-column prop="age" label="年齢" width="100" sortable>
				</el-table-column>
				<el-table-column label="" width="60">
					<template slot-scope="scope">
						<i class="el-icon-arrow-right"></i>
		      </template>
				</el-table-column>
			</el-table>
		</template>

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
			}
		},
		methods: {
			//性别表示
			formatSex: function (row, column) {
				return row.sex == 1 ? '男' : row.sex == 0 ? '女' : '不明';
			},
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

<style scoped>

</style>