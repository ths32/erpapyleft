<template>
  <!-- 모달 '등록' 팝업 -->
  <div
    id="AccTitlereg"
    class="layerType2"
    style="width: 600px"
    v-if="action == 'I'"
  >
    <dl>
      <dt>
        <strong>계정과목관리</strong>
      </dt>
      <dd class="content">
        <table class="row3">
          <caption>
            caption
          </caption>
          <tbody>
            <!-- 1 -->
            <!-- Combo box -->
            <tr id="bacc_name_ro">
              <th scope="row">계정대분류명<span class="font_red">*</span></th>
              <td>
                <selectComCombo
                  comtype="acc"
                  selectid="acc"
                  type="all"
                  selvalue=""
                  v-model="bacc_code"
                ></selectComCombo>
              </td>
            </tr>
            <!-- 2 -->
            <!-- text -->
            <tr>
              <th scope="row">계정세부명 <span class="font_red">*</span></th>
              <td colspan="3">
                <input
                  type="text"
                  class="inputTxt p100"
                  style="width: 150px"
                  name="dacc_name"
                  id="dacc_name"
                  required
                  v-model="dacc_name"
                />
              </td>
            </tr>
            <!-- 3 -->
            <!-- text -->
            <tr>
              <th scope="row">상세내용</th>
              <td colspan="3">
                <textarea
                  class="inputTxt p100"
                  name="dacc_detail"
                  id="dacc_detail"
                  required
                  v-model="dacc_detail"
                >
                </textarea>
              </td>
            </tr>
            <!-- 4 -->
            <!-- Combo box -->
            <tr>
              <th scope="row">구분</th>
              <td>
                <select
                  id="dacc_div"
                  name="dacc_div"
                  style="width: 150px"
                  v-model="dacc_div"
                >
                  <option value="">선택</option>
                  <option value="1">지출</option>
                  <option value="2">수입</option>
                </select>
              </td>
            </tr>
          </tbody>
        </table>
        <!-- 모달 하단 -->
        <div class="btn_areaC mt30">
          <a
            href=""
            @click.prevent="getPopUpItems"
            class="btnType blue"
            id="btnSave"
            name="btn"
            ><span>등록</span></a
          >
          <a
            href=""
            @click.prevent="closeThis"
            class="btnType gray"
            id="btnClose"
            name="btn"
            ><span>취소</span></a
          >
        </div>
      </dd>
    </dl>
    <a href="" @click.prevent="closeThis" class="closePop"
      ><span class="hidden">닫기</span></a
    >
  </div>
  <!-- ---------------------------------------------------------------- -->
  <!-- 모달 '수정' 팝업 -->
  <div
    id="AccTitlereg2"
    class="layerType2"
    style="width: 600px"
    v-if="action == 'U'"
  >
    <dl>
      <dt>
        <strong>계정과목관리</strong>
      </dt>
      <dd class="content">
        <table class="row3">
          <caption>
            caption
          </caption>

          <tbody>
            <tr id="bacc_name_rd">
              <th scope="row">계정대분류명<span class="font_red">*</span></th>
              <td colspan="3">
                <input
                  type="text"
                  class="inputTxt p100"
                  name="paccall_rd"
                  id="paccall_rd"
                  readonly
                  required
                  v-model="bacc_name"
                />
              </td>
            </tr>
            <tr>
              <th scope="row">계정세부명 <span class="font_red">*</span></th>
              <td colspan="3">
                <input
                  type="text"
                  class="inputTxt p100"
                  style="width: 150px"
                  name="dacc_name"
                  id="dacc_name"
                  required
                  v-model="dacc_name"
                />
              </td>
            </tr>

            <tr id="dacc_code_rd">
              <th scope="row">세부코드 <span class="font_red">*</span></th>
              <td colspan="3">
                <input
                  type="text"
                  class="inputTxt p100"
                  name="dacc_code"
                  id="dacc_code"
                  readonly
                  required
                  v-model="dacc_code"
                />
              </td>
            </tr>

            <tr>
              <th scope="row">상세내용</th>
              <td colspan="3">
                <textarea
                  class="inputTxt p100"
                  name="dacc_detail"
                  id="dacc_detail"
                  required
                  v-model="dacc_detail"
                >
                </textarea>
              </td>
            </tr>

            <tr id="use_yn_up">
              <th scope="row">사용여부</th>
              <td>
                <select id="use_yn" name="use_yn" v-model="use_yn">
                  <option value="Y" selected="selected">Y</option>
                  <option value="N">N</option>
                </select>
              </td>
            </tr>

            <tr>
              <th scope="row">구분</th>
              <td>
                <select
                  id="dacc_div"
                  name="dacc_div"
                  style="width: 150px"
                  v-model="dacc_div"
                >
                  <option value="">선택</option>
                  <option value="1">지출</option>
                  <option value="2">수입</option>
                </select>
              </td>
            </tr>
          </tbody>
        </table>
        <!-- 모달 하단 -->
        <div class="btn_areaC mt30">
          <a
            href=""
            @click.prevent="updateItems"
            class="btnType blue"
            id="btnUpdate"
            name="btn"
            ><span>수정</span></a
          >
          <a
            href=""
            @click.prevent="closeThis"
            class="btnType gray"
            id="btnClose"
            name="btn"
            ><span>취소</span></a
          >
        </div>
      </dd>
    </dl>
    <a href="" @click.prevent="closeThis" class="closePop"
      ><span class="hidden">닫기</span></a
    >
  </div>
  <!-- ================================================================= -->
</template>
<script>
import { closeModal } from 'jenesius-vue-modal';
import selectComCombo from '@/components/common/selectComCombo.vue';
export default {
  props: {
    paction: String,
    pitem: Object,
    dacc: Number,
    bacc: String,
  },
  data: function () {
    return {
      action: '',
      bacc_code: '',
      dacc_code: '',
      bacc_name: '',
      dacc_name: '',
      dacc_detail: '',
      dacc_div: '',
      use_yn: '',
    };
  },
  mounted() {
    this.action = this.paction;
    // --------------------------
    this.bacc_code = this.bacc;
    this.dacc_code = this.dacc;
    if (this.action == 'U') {
      this.selectItems();
    }
  },
  components: { selectComCombo },
  methods: {
    getPopUpItems: function () {
      // Insert 용도
      let vm = this;
      let params = new URLSearchParams();
      params.append('bacc_code', vm.bacc_code); // 계정 대분류 코드
      params.append('bacc_name', vm.bacc_name); // 계정 대분류명
      params.append('dacc_name', vm.dacc_name); // 계정 세부명
      params.append('dacc_detail', vm.dacc_detail); //상세 내용
      params.append('dacc_div', vm.dacc_div); // 구분    // 1 or 2
      params.append('use_yn', 'Y'); // 사용 여부  // 'Y'
      params.append('action', vm.action); // 'I'
      this.axios
        .post('/accounting/saveAccTitle.do', params)
        .then((res) => {
          console.log('insert 결과 : ' + res.data);
          closeModal(this);
        })
        .catch(function (error) {
          alert('에러! API 요청에 오류가 있습니다. ' + error);
        });
    },
    closeThis: function () {
      closeModal(this);
    },
    selectItems: function () {
      let vm = this;
      let params = new URLSearchParams();
      params.append('bacc_code', vm.bacc_code); // 계정 대분류 코드
      params.append('dacc_code', vm.dacc_code); // 세부코드
      params.append('action', vm.action);
      console.log('params : ' + params);
      this.axios
        .post('/accounting/selectAccTitle.do', params)
        .then((res) => {
          this.bacc_name = res.data.selectAccTitle.bacc_name;
          this.dacc_name = res.data.selectAccTitle.dacc_name;
          this.dacc_code = res.data.selectAccTitle.dacc_code;
          this.dacc_detail = res.data.selectAccTitle.dacc_detail;
          this.use_yn = res.data.selectAccTitle.use_yn;
          this.dacc_div = res.data.selectAccTitle.dacc_div;
        })
        .catch(function (error) {
          alert('에러! API 요청에 오류가 있습니다. ' + error);
        });
    },
    updateItems: function () {
      // 글 수정하는 함수
      let vm = this;
      let params = new URLSearchParams();
      params.append('bacc_code', vm.bacc_code); // 계정 대분류 코드
      params.append('dacc_code', vm.dacc_code); // 세부 코드
      params.append('dacc_name', vm.dacc_name); // 계정 과목명
      params.append('dacc_div', vm.dacc_div); // 구분
      params.append('dacc_detail', vm.dacc_detail); // 상세내용
      params.append('use_yn', vm.use_yn); //사용여부
      params.append('action', vm.action); //
      this.axios
        .post('/accounting/saveAccTitle.do', params)
        .then((res) => {
          console.log('update 결과 : ' + JSON.stringify(res));
          closeModal(this);
        })
        .catch(function (error) {
          alert('에러! API 요청에 오류가 있습니다. ' + error);
        });
    },
  },
};
</script>
<style>
#modalEx {
  width: 100%;
  height: 100%;
  background-color: rgba(12, 1, 1, 0.2);
}
.black-bg {
  width: 100%;
  height: 100%;

  position: fixed;
  padding: 20px;
}
.white-bg {
  width: 50%;
  background: ivory;
  border-radius: 8px;
  padding: 8px;
  margin-left: 20%;
  margin-top: 5%;
}
.fileCss {
  margin-left: 5%;
}
</style>
