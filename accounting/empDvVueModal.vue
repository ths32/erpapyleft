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
  <form id="empDvReg" style="position: relative; left: -15%; bottom: 50%">
    <div id="layer1" class="layerType2" style="width: 500px">
      <dl>
        <dt>
          <strong>지출결의서 신청 및 삭제</strong>
        </dt>
        <dd class="content">
          <!-- s : 여기에 내용입력 -->
          <table class="row3">
            <caption>
              caption
            </caption>
            <!-- <colgroup>
            <col width="120px" />
            <col width="*" />
            <col width="120px" />
            <col width="*" />
          </colgroup> -->
            <tbody class="col">
              <tr id="dv_form">
                <th scope="row">결의번호</th>
                <td>
                  <input
                    type="text"
                    class="inputTxt p100"
                    name="dv_code"
                    id="dv_code"
                    v-model="dvCode"
                  />
                </td>
              </tr>
              <tr class="col">
                <th scope="row">아이디</th>
                <td>{{ loginID }}</td>
              </tr>
              <tr>
                <th scope="row">사원명</th>
                <td>{{ name }}</td>
              </tr>
              <tr>
                <th scope="row">계정대분류명<span class="font_red">*</span></th>
                <td colspan="3">
                  <selectComCombo
                    comtype="acc"
                    selectid="acc"
                    type="all"
                    id="baccCode"
                    :selvalue="baccCode"
                    v-model="baccCode"
                    :key="key"
                  ></selectComCombo>
                </td>
              </tr>
              <tr>
                <th scope="row">상세과목명<span class="font_red">*</span></th>
                <td colspan="3">
                  <selectComCombo
                    comtype="accd"
                    selectid="accs"
                    type="cel"
                    :searchkey="baccCode"
                    :selvalue="daccCode"
                    v-model="daccCode"
                    id="daccCode"
                    :key="key"
                  ></selectComCombo>
                </td>
              </tr>

              <tr>
                <th scope="row">거래처명<span class="font_red">*</span></th>
                <td colspan="3">
                  <selectComCombo
                    comtype="cli"
                    selectid="clientcomcombo"
                    type="all"
                    :selvalue="bizCode"
                    v-model="bizCode"
                    id="bizCode"
                    :key="key"
                  ></selectComCombo>
                </td>
              </tr>
              <tr>
                <th scope="row">신청일자</th>
                <td colspan="3">
                  <input
                    type="text"
                    class="inputTxt p100"
                    name="dv_date"
                    id="dv_reg_date"
                    v-model="dvDate"
                    readonly
                  />
                </td>
              </tr>
              <tr>
                <th scope="row">사용일자<span class="font_red">*</span></th>
                <td colspan="3">
                  <input
                    type="date"
                    name="dvUdate"
                    id="dvUdate"
                    v-model="dvUdate"
                    class="inputTxt p100"
                    style="font-size: 92%"
                  />
                </td>
              </tr>
              <tr>
                <th scope="row">지출금액<span class="font_red">*</span></th>
                <td colspan="3">
                  <input
                    type="text"
                    class="inputTxt p100"
                    name="dvFee"
                    id="dvFee"
                    v-model="dvFee"
                  />
                </td>
              </tr>
              <tr id="att_file_form">
                <th scope="row">증빙서류<span class="font_red">*</span></th>
                <td colspan="3">
                  <span id="filePreview"></span>
                  <input
                    type="file"
                    name="att_file"
                    id="att_file"
                    @change="onFileChange"
                  />
                  <div style="font-size: 11px; color: #e76161">
                    *이미지 파일이 여러 장일 경우 압축하여 업로드하세요.
                    <div
                      v-html="insertHTML"
                      @click.prevent="fileDownload()"
                    ></div>
                  </div>
                </td>
              </tr>
              <tr style="height: 100px">
                <th scope="row">비고</th>
                <td colspan="3">
                  <textarea
                    cols="20"
                    rows="10"
                    name="dvMemo"
                    id="dvMemo"
                    v-model="dvMemo"
                    class="p100"
                    style="height: 100px"
                  ></textarea>
                </td>
              </tr>
              <tr id="dv_return_form" v-if="dvSign == 2">
                <th scope="row">반려사유</th>
                <td colspan="3">
                  <textarea
                    cols="20"
                    rows="10"
                    name="dvReres"
                    id="dv_return"
                    v-model="dvReres"
                    readonly
                  ></textarea>
                </td>
              </tr>
            </tbody>
          </table>

          <!-- e : 여기에 내용입력 -->

          <div class="btn_areaC mt30">
            <a
              class="btnType blue"
              id="btnSaveEmpDv"
              name="btn"
              @click.prevent="save('save')"
              ><span>저장</span></a
            >
            <template v-if="action != 'I'">
              <a
                href=""
                @click.prevent="deleteDv()"
                class="btnType blue"
                id="btnDeleteEmpDv"
                name="btn"
                ><span>삭제</span></a
              >
            </template>
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
  </form>
</template>
<script>
import { vueListAxios } from '../accounting';
import selectComCombo from '@/components/common/selectComCombo.vue';
import { closeModal } from 'jenesius-vue-modal';
import axios from 'axios';
export default {
  props: {
    modalDvCode: String,
    dvAction: String,
  },
  components: { selectComCombo },
  data: function () {
    return {
      dvCode: '',
      loginID: '',
      name: '',
      baccName: '',
      daccName: '',
      dvDate: '',
      dvUdate: '',
      dvFee: '',
      dvMemo: '',
      dvReres: '',
      dvSign: '',
      daccCode: '',
      baccCode: '',
      bizCode: '',
      fileCode: '',
      fileName: '',
      fileSize: '',
      fileNadd: '',
      file_madd: '',
      action: '',
      key: 0,
      insertHTML: '',
    };
  },
  mounted() {
    this.dvCode = this.modalDvCode;
    this.action = this.dvAction;

    if (this.action == 'I') {
      this.dvCode = '';
      this.loginID = this.$session.get('loginId');
      this.name = this.$session.get('userNm');
      this.dvDate = this.setNowTimes();
      this.baccCode = '';
    } else {
      this.fn_empDvModalDetail();
    }
  },
  watch: {
    baccName: function () {
      this.key += 1;
    },
  },
  methods: {
    fn_empDvModalDetail: function () {
      let params = new URLSearchParams();
      params.append('dv_code', this.dvCode);

      vueListAxios('/accounting/dvDetail.do', params).then((res) => {
        console.log(JSON.stringify(res.data.dvDetail));
        this.dvCode = res.data.dvDetail.dv_code;
        this.loginID = res.data.dvDetail.loginID;
        this.name = res.data.dvDetail.name;
        this.baccName = res.data.dvDetail.bacc_name;
        this.daccName = res.data.dvDetail.dacc_name;
        this.dvDate = res.data.dvDetail.dv_date;
        this.dvUdate = res.data.dvDetail.dv_udate;
        this.dvFee = res.data.dvDetail.dv_fee;
        this.dvMemo = res.data.dvDetail.dv_memo;
        this.dvReres = res.data.dvDetail.dv_reres;
        this.dvSign = res.data.dvDetail.dv_sign;
        this.daccCode = res.data.dvDetail.dacc_code;
        this.baccCode = res.data.dvDetail.bacc_code;
        this.bizCode = res.data.dvDetail.biz_code;
        console.log('파일사이즈' + res.data.dvDetail.file_size);
        if (res.data.dvDetail.file_size > 0) {
          this.fileName = res.data.dvDetail.file_name;
          this.fileCode = res.data.dvDetail.file_code;
          this.fileSize = res.data.dvDetail.file_size;
          this.fileNadd = res.data.dvDetail.file_nadd;
          this.fileMadd = res.data.dvDetail.file_madd;

          let fileNameArr = this.fileName.split('.');
          if (
            fileNameArr[1] == 'png' ||
            fileNameArr[1] == 'jpg' ||
            fileNameArr[1] == 'jpeg' ||
            fileNameArr[1] == 'bmp'
          ) {
            this.insertHTML =
              "<a href = '' @click.prevent='fileDownload()''><img src='" +
              res.data.dvDetail.file_nadd +
              "' style='width : 150px; height :200px;'/><b style='color: ; text-align:bottom'>💾다운로드</b></a>";
          } else {
            this.insertHTML = res.data.dvDetail.file_name;
          }
        }
      });
    },
    setNowTimes() {
      let myDate = new Date();
      let yy = String(myDate.getFullYear());
      let mm = myDate.getMonth() + 1;
      let dd = myDate.getDate();
      if (mm < 10) {
        mm = '0' + mm;
      }
      if (dd < 10) {
        dd = '0' + dd;
      }

      return yy + '-' + mm + '-' + dd;
    },
    modalClose: function () {
      closeModal();
    },
    save: function () {
      if (!this.fValidate()) {
        return;
      }
      let formData = new FormData(document.getElementById('empDvReg'));
      formData.append('action', this.action);
      formData.append('loginID', this.$session.get('loginId'));
      formData.append('dv_code', this.dvCode);
      formData.append('bacc_code', this.baccCode);
      formData.append('dacc_code', this.daccCode);
      formData.append('dv_udate', this.dvUdate);
      formData.append('dv_fee', this.dvFee);
      formData.append('biz_code', this.bizCode);
      formData.append('file_code', this.fileCode);

      this.axios
        .post('/accounting/dvSave.do', formData)
        .then((result) => {
          if (result.status == 200) {
            alert('저장되었습니다.');
            closeModal(this);
          }
        })
        .catch((err) => {
          alert(err);
        });
    },
    deleteDv: function () {
      this.action = 'D';
      let params = new URLSearchParams();
      params.append('action', this.action);
      params.append('dv_code', this.dvCode);
      axios.post('/accounting/dvSave.do', params).then((result) => {
        if (result.status == 200) {
          alert('삭제되었습니다.');
          closeModal(this);
        }
      });
    },
    onFileChange: function (e) {
      let files = e.target.files;
      let fileType = files[0].type;

      if (
        fileType == 'image/png' ||
        fileType == 'image/jpg' ||
        fileType == 'image/jpeg' ||
        fileType == 'image/bmp'
      ) {
        this.insertHTML =
          "<img src='" +
          window.URL.createObjectURL(e.target.files[0]) +
          "'style='width : 150px; height :200px;' />";
      }
    },
    fileDownload: function () {
      let params = new URLSearchParams();
      params.append('dv_code', this.dvCode);
      params.append('filemadd', this.fileMadd);
      params.append('fileName', this.fileName);
      console.log('파람스 : ' + params);
      axios
        .post('/accounting/dvFileDownload.do', params)
        .then((result) => {
          if (result.status == 200) {
            let FILE = window.URL.createObjectURL(new Blob([result.data]));
            console.log('파일 : ' + FILE);
            let docURL = document.createElement('a');
            docURL.href = FILE;
            docURL.setAttribute('download', this.fileName);
            document.body.appendChild(docURL);
            docURL.click();
          }
        })
        .catch((err) => {
          alert(err);
        });
    },
    fValidate: function () {
      let chk = this.$checkNotEmpty([
        ['baccCode', '계정대분류명을 입력하세요'],
        ['daccCode', '상세과목명을 입력하세요'],
        ['bizCode', '거래처명을 입력하세요'],
        ['dvUdate', '사용일자를 입력하세요'],
        ['dvFee', '지출금액을 입력하세요'],
        ['att_file', '증빙서류를 첨부하세요.'],
      ]);

      let numRules = /^(\(?\+?[0-9]*\)?)?[0-9_\- ()]*$/;

      if (!numRules.test(this.dvFee)) {
        alert('지출금액은 숫자만 입력해주세요.');
        return false;
      }
      if (!chk) {
        return;
      }
      return true;
    },
  },
};
</script>
