<template>
	<el-form ref="employee" :model="employee" label-width="80px" @submit.prevent="onSubmit" style="margin:20px;width:60%;min-width:600px;">
		<el-form-item label="社員番号">
			<el-input v-model="employee.employee_number" placeholder="4桁数値"></el-input>
		</el-form-item>
		<el-form-item label="得意領域">
			<el-input
			  type="textarea"
			  :autosize="{ minRows: 2, maxRows: 4}"
			  placeholder="得意とする領域、特殊な経験を記載ください。"
			  v-model="employee.specialty">
			</el-input>
		</el-form-item>
		<el-form-item label="特記事項">
			<el-input
			  type="textarea"
			  :autosize="{ minRows: 2, maxRows: 4}"
			  placeholder="メモ欄"
			  v-model="employee.memo">
			</el-input>
		</el-form-item>
		
		<!-- TODO 'name'プロパティでスクリプトエラーが出る -->
		<el-from-item label="経験・スキル">
		  <el-checkbox-group v-model="employee.selectedSkills" size="small" text-color="#FFF" fill="#409EFF">
	  	  <!-- スキルタグ -->
	  	  <el-collapse v-model="activeNames">
	        <el-collapse-item v-for="(category, key, index) in dynamicCategories" 
	            :key="category.id" :title="category.catName" :name="category.id">
	          
	          <el-checkbox :key="tag" v-for="tag in category.items" :label="tag" border>
	          </el-checkbox>
	
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
			
		</el-from-item>
		<el-form-item>
			<el-button type="primary">更新</el-button>
			<el-button @click.native.prevent>キャンセル</el-button>
		</el-form-item>
	</el-form>
</template>

<script>
 import axios from 'axios';
	export default {
		data() {
			return {
				employee: {
					employee_number: '',
					specialty: '',
					memo:'',
	        //TODO カテゴリ毎にする必要があるかも？
	        //スキルの選択状態
	        selectedSkills: ['VB','java'],
						
					},
					 //アコーディオンとタグのデータ
	        dynamicCategories: [ {id:'1',catName:'言語', inputVisible:false ,inputValue:'' ,items:['java','C#','PHP','VB']},
	                              {id:'2', catName:'フレームワーク', inputVisible:false ,inputValue:'' , items:['spring','struts2','cakePHP','.net','iBatis','dbflute']},
	                              {id:'3', catName:'OS・DB・ミドルウェア', inputVisible:false ,inputValue:'' ,items:['Linux','Oracle','MySQL','postgresql','Apache','Tomcat','redis','memcached']},
	                              {id:'4', catName:'業種', inputVisible:false ,inputValue:'' ,items:['人材紹介','保険代理店','小売','流通','不動産']},
	                              {id:'5', catName:'ポジション', inputVisible:false ,inputValue:'' ,items:['PM','サブリーダー']},
	                              {id:'6', catName:'フェーズ', inputVisible:false ,inputValue:'' ,items:['要件定義','基本設計(外部設計)','詳細設計(内部設計)','結合テスト','総合テスト']},
	                              {id:'7', catName:'資格', inputVisible:false ,inputValue:'' ,items:['PMP','ITIL','Oracle Gold']},
	                            ],
	        //アコーディオンを最初から全て展開する
	        activeNames: ['1','2','3','4','5','6','7'],
	        

			}
		},
		methods: {
			onSubmit() {
				console.log('submit!');
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
      } ,
			
			
		}
	}

</script>