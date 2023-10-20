<style type="text/css">
.btnType {
  float: right;
}

.app_date_apply {
  height: 25px;
  margin-bottom: 5px;
}

.selectEmpDv {
  margin-bottom: 10px;
  overflow: hidden;
}

.selectEmpDv li {
  float: left;
  margin-right: 30px;
}

#empDvReg {
  border: 1px solid #000;
}

#dv_form {
  display: none;
}
</style>
<template>
  <div id="layer1" class="layerType2" style="width: 600px">
    <dl>
      <dt>
        <strong>지출결의서 상세조회 및 승인</strong>
      </dt>
      <dd class="content">
        <!-- s : 여기에 내용입력 -->
        <table class="row3">
          <caption>
            caption
          </caption>
          <colgroup>
            <col width="120px" />
            <col width="*" />
            <col width="120px" />
            <col width="*" />
          </colgroup>
          <tbody>
            <tr id="dv_form">
              <th scope="row">결의번호</th>
              <td>
                <input
                  type="text"
                  class="inputTxt p100"
                  name="dv_code"
                  id="dv_code"
                  v-model="bmDvObject.dv_code"
                />
              </td>
            </tr>
            <tr>
              <th scope="row">아이디</th>
              <td>
                <input
                  type="text"
                  class="inputTxt p100"
                  name="loginID"
                  id="loginID"
                  v-model="bmDvObject.loginID"
                  readonly
                />
              </td>
            </tr>
            <tr>
              <th scope="row">사원명</th>
              <td>
                <input
                  type="text"
                  class="inputTxt p100"
                  name="name"
                  id="name"
                  v-model="bmDvObject.name"
                  readonly
                />
              </td>
            </tr>
            <tr>
              <th scope="row">
                계정대분류명<span class="font_red" readonly>*</span>
              </th>
              <td colspan="3">
                <input
                  type="text"
                  id="account_cd_modals"
                  name="bacc_code"
                  v-model="bmDvObject.bacc_name"
                  class="inputTxt p100"
                  readonly
                />
              </td>
            </tr>
            <tr>
              <th scope="row">
                상세과목명<span class="font_red" readonly>*</span>
              </th>
              <td colspan="3">
                <input
                  type="text"
                  id="detail_account_cd_modal"
                  name="detail_account_cd_modal"
                  v-model="bmDvObject.dacc_name"
                  class="inputTxt p100"
                  readonly
                />
              </td>
            </tr>
            <tr>
              <th scope="row">승인여부<span class="font_red">*</span></th>
              <td colspan="3">
                <select
                  id="detail_yn_modal"
                  name="dv_sign"
                  v-model="bmDvObject.dv_sign"
                ></select>
              </td>
            </tr>
            <tr>
              <th scope="row">거래처명<span class="font_red">*</span></th>
              <td colspan="3">
                <input
                  type="text"
                  class="inputTxt p100"
                  name="acc_name"
                  id="biz_name"
                  v-model="bmDvObject.biz_name"
                  readonly
                />
              </td>
            </tr>
            <tr>
              <th scope="row">신청일자</th>
              <td colspan="3">
                <input
                  type="text"
                  class="inputTxt p100"
                  name="dv_reg_date"
                  id="dv_date"
                  v-model="bmDvObject.dv_date"
                  readonly
                />
              </td>
            </tr>
            <tr>
              <th scope="row">사용일자<span class="font_red">*</span></th>
              <td colspan="3">
                <input
                  type="text"
                  name="dv_use_date"
                  id="dv_udate"
                  v-model="bmDvObject.dv_udate"
                  class="inputTxt p100"
                  style="font-size: 92%"
                  readonly
                />
              </td>
            </tr>
            <tr>
              <th scope="row">지출금액<span class="font_red">*</span></th>
              <td colspan="3">
                <input
                  type="text"
                  class="inputTxt p100"
                  name="dv_fee"
                  id="dv_amt"
                  v-model="bmDvObject.dv_fee"
                  readonly
                />
              </td>
            </tr>
            <tr id="att_file_form">
              <th scope="row">증빙서류</th>
              <td colspan="3">
                <span id="filePreview"></span>
                <div v-html="insertHTML"></div>
                <a
                  class="btnType gray att_file_open"
                  href="javascript:fDownloadAttFile()"
                  name="att_file_download"
                  ><span id="att_file_download">다운로드</span></a
                ><br />
              </td>
            </tr>
            <tr style="height: 100px">
              <th scope="row">비고</th>
              <td colspan="3">
                <textarea
                  cols="20"
                  rows="10"
                  name="dv_memo"
                  id="dv_memo"
                  v-model="bmDvObject.dv_memo"
                  class="p100"
                  style="height: 100px"
                  readonly
                ></textarea>
              </td>
            </tr>
            <tr id="dvrsh">
              <th scope="row">반려사유</th>
              <td colspan="3">
                <textarea
                  cols="20"
                  rows="10"
                  name="dv_reres"
                  id="dv_return"
                  v-model="bmDvObject.dv_reres"
                ></textarea>
              </td>
            </tr>
          </tbody>
        </table>

        <!-- e : 여기에 내용입력 -->

        <div style="text-align: center">
          <a href="" class="btnType blue" id="btnSaveEmpDv" name="btn"
            ><span>저장</span></a
          >
          <a
            href=""
            @click.prevent="modalClose()"
            class="btnType gray"
            id="btnCloseEmpDv"
            name="btn"
            ><span>닫기</span></a
          >
        </div>
      </dd>
    </dl>
    <a href="" @click.prevent="modalClose()" class="closePop"
      ><span class="hidden">닫기</span></a
    >
  </div>
</template>
<script>
import { vueListAxios } from '../accounting';
import { closeModal } from 'jenesius-vue-modal';
// import axios from 'axios';
export default {
  props: {
    mdlBmDvCode: Number,
    bmDvAction: String,
  },
  data: function () {
    return {
      bmDvCode: '',
      // loginID: '',
      // name: '',
      // baccName: '',
      // daccName: '',
      // dvDate: '',
      // dv_udate: '',
      // dv_fee: '',
      // dv_memo: '',
      // dv_reres: '',
      // dvSign: '',
      // daccCode: '',
      // baccCode: '',
      // bizCode: '',
      // fileCode: '',
      // fileName: '',
      // file_size: '',
      // fileNadd: '',
      // file_madd: '',
      action: '',
      key: 0,
      insertHTML: '',
      bmDvObject: {},
    };
  },
  mounted() {
    this.bmDvCode = this.mdlBmDvCode;
    console.log(this.bmDvCode);
    this.action = this.bmDvAction;
    this.bmDvModal();
  },
  methods: {
    modalClose: function () {
      closeModal();
    },
    bmDvModal: function () {
      let params = new URLSearchParams();
      params.append('num', this.bmDvCode);
      params.append('dv_code', this.bmDvCode);

      vueListAxios('/accounting/detail.do', params)
        .then((result) => {
          this.bmDvObject = result.data.detail;
          console.log(this.bmDvObject);
          if (result.data.detail.file_size > 0) {
            let fileNm = result.data.detail.file_name;
            let fileNameArr = fileNm.split('.');

            this.fileName = result.data.detail.file_name;
            this.fileMadd = result.data.detail.file_madd;

            if (
              fileNameArr[1] == 'png' ||
              fileNameArr[1] == 'jpg' ||
              fileNameArr[1] == 'jpeg' ||
              fileNameArr[1] == 'bmp'
            ) {
              this.insertHTML =
                "<a href = '' @click.prevent='fileDownload()''><img src='" +
                result.data.detail.file_nadd +
                "' style='width : 150px; height :200px;'/></a>";
            } else {
              this.insertHTML = result.data.detail.file_name;
            }
          }
        })
        .catch((err) => {
          alert(err);
        });
    },
  },
};
</script>
