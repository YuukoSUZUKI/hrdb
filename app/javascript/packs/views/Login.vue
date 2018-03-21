<template>
  <div class="login-background">
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-position="left" label-width="0px" class="demo-ruleForm login-container">
      <div class="title"><i class="el-icon-search"></i>meru
        <span class="subtitle">“クメル”で才能を検索</span>
      </div>
      <el-form-item prop="account">
        <el-input type="text" v-model="ruleForm.account" auto-complete="off" placeholder="アカウント" clearable></el-input>
      </el-form-item>
      <el-form-item prop="checkPass">
        <el-input type="password" v-model="ruleForm.checkPass" auto-complete="off" placeholder="パスワード" clearable></el-input>
      </el-form-item>
      <el-form-item style="width:100%;">
        <el-button type="primary" style="width:100%;" @click.native.prevent="handleSubmit" :loading="logining">ログイン</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import { requestLogin } from '../api/api';
  export default {
    data() {
      return {
        logining: false,
        ruleForm: {
          account: 'h-katou',
          checkPass: 'password'
        },
        rules: {
          account: [
            { required: true, message: 'アカウントを入力してください', trigger: 'blur' },
          ],
          checkPass: [
            { required: true, message: 'パスワードを入力してください', trigger: 'blur' },
          ]
        },
      };
    },
    methods: {
      handleSubmit(ev) {
        var _this = this;
        this.$refs.ruleForm.validate((valid) => {
          if (! valid) {
            //バリデーションエラー
						this.$message.error('入力してください。');
            return false;
          }
            
            this.logining = true;
            var loginParams = { account: this.ruleForm.account, password: this.ruleForm.checkPass };
            requestLogin(loginParams).then(data => {
              this.logining = false;
              //生成された認証トークンを保持
              sessionStorage.setItem('AUTH_TOKEN', JSON.stringify(data.token));
              //スキル検索に遷移
              this.$router.push({ path: '/user' });
            })
            .catch(error => {
              console.log(error);
							if (error.response && error.response.data && error.response.data.errors) {
								//レスポンスにエラーメッセージがある場合、それを表示
								let msg = error.response.data.errors.join('、')
								this.$message.error(msg);
							} else {
								this.$message.error('エラーが発生しました。');
							}
							this.logining = false;
						});
        });
      }
    }
  }

</script>

<style lang="scss" scoped>
  .login-background {
    position: absolute;
    width: 100vw;
    height: 100vh;
    background: linear-gradient(to right, rgba(166, 255, 203, 0.9), rgba(18, 216, 250, 0.8), rgba(31, 162, 255, 0.9)) ,url(../assets/bg-login.jpg) center;
    background-size:cover;
    background-repeat:no-repeat;
    
  }
  .login-container {


    border-radius: 5px;
    background-clip: padding-box;
    margin: 180px auto;
    width: 350px;
    padding: 35px 35px 15px 35px;
    background: #fff;
    .title {
      margin: 0px auto 40px auto;
      text-align: center;
      color: #505458;
      font-size : 40px;
    }
    .subtitle {
      display : block;
      font-size : 12px;
      margin-top : 0.5rem;
    }
    .remember {
      margin: 0px 0px 35px 0px;
    }
  }
</style>