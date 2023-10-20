<!-- eslint-disable prettier/prettier -->
<template>
  <div id="container">
    <!-- <ul>
				<li class="contents"> -->
    <!-- content -->
    <div class="content">
      <p class="Location">
        <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
        <span class="btn_nav bold">회계</span>
        <span class="btn_nav bold">계정과목관리</span>
        <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
      </p>
      <p class="conTitle" style="height: auto">
        <span>계정과목관리</span>
        <span class="fr">
          <a
            href=""
            class="btnType blue"
            id="btnInsert"
            @click.prevent="btnInsert('I')"
          >
            <span> 등록 </span>
          </a>
        </span>
      </p>
      <!-- --------------------------------------------------------------------- -->
      <!--검색창  -->
      <table
        width="100%"
        cellpadding="5"
        cellspacing="0"
        border="1"
        style="border-collapse: collapse; border: 1px #50bcdf"
      >
        <tr style="border: 10px; border-color: blue" align="center">
          <td width="100" height="25" style="font-size: 100%">계정대분류</td>
          <td>
            <selectComCombo
              comtype="acc"
              selectid="acc"
              type="all"
              selvalue=""
              v-model="accall"
            ></selectComCombo>
          </td>
          <td width="100" height="25" style="font-size: 100%">계정중분류</td>
          <td>
            <selectComCombo
              comtype="accd"
              selectid="acc"
              type="all"
              selvalue=""
              v-model="daccall"
              :searchkey="accall"
              :key="key"
            ></selectComCombo>
          </td>

          <td width="100" height="25" style="font-size: 100%">구분</td>
          <td>
            <ComCombo
              group_code="dacc_div"
              selectid="comcombo"
              type="all"
              selvalue=""
              v-model="gbn"
            ></ComCombo>
          </td>
          <!-- ------------------------------------------------------------- -->
          <td width="100" height="25" style="font-size: 100%">사용여부</td>
          <td>
            <select
              id="S_daccT"
              name="S_daccT"
              style="width: 100px"
              v-model="S_daccT"
            >
              <option value="">전체</option>
              <option value="Y">Y</option>
              <option value="N">N</option>
            </select>
          </td>

          <td width="110" height="60" style="font-size: 120%">
            <a
              href=""
              class="btnType blue"
              id="searchBtn"
              @click.prevent="AccTitlelist()"
            >
              <span> 조회 </span>
            </a>
          </td>
        </tr>
      </table>

      <!-- ---------- MAIN ---------------------------------------------- -->
      <div class="divAccTitleList">
        <table class="col">
          <caption>
            caption
          </caption>

          <colgroup>
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="35%" />
            <col width="8%" />
          </colgroup>
          <thead>
            <tr>
              <th scope="col">계정대분류코드</th>
              <th scope="col">계정대분류명</th>
              <th scope="col">계정세부코드</th>
              <th scope="col">계정세부명</th>
              <th scope="col">구분</th>
              <th scope="col">상세내용</th>
              <th scope="col">사용여부</th>
            </tr>
          </thead>
          <tbody scope="col" id="listNotice">
            <tr v-for="(item, index) in armngList" :key="index">
              <!-- <td>{{ pageSize * (cpage - 1) + 1 + index }}</td> -->
              <td>{{ item.bacc_code }}</td>
              <td>{{ item.bacc_name }}</td>
              <td>{{ item.dacc_code }}</td>
              <td>
                <a href="" @click.prevent="btnUpdate('U', item)">{{
                  item.dacc_name
                }}</a>
              </td>
              <td>{{ item.detail_name }}</td>
              <td>{{ item.dacc_detail }}</td>
              <td>{{ item.use_yn }}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- TEMP -->
    </div>
  </div>
  <!-- ------------------------------------------------------------ -->
  <!-- 페이징 처리  -->
  <div
    style="position: relative; bottom: 111.1px"
    class="paging_area"
    id="noticePagination"
  >
    <paginate
      class="justify-content-center"
      v-model="cpage"
      :page-count="totalPage"
      :page-range="5"
      :margin-pages="0"
      :click-handler="AccTitlelist"
      :prev-text="'Prev'"
      :next-text="'Next'"
      :container-class="'pagination'"
      :page-class="'page-item'"
    >
    </paginate>
  </div>
</template>
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
<script>
import selectComCombo from '@/components/common/selectComCombo.vue';
import ComCombo from '@/components/common/ComCombo.vue';
import axios from 'axios';
import Paginate from 'vuejs-paginate-next';
//-- MODAL --------------------------------------------------------------------
import { openModal } from 'jenesius-vue-modal';
//import acctitleVueModal from './acctitleVueModal.vue'; // 모달1 : 등록 팝업
//import acctitleVueModal2 from './acctitleVueModal2.vue'; // 모달2 : 수정 팝업
import acctitleVueModal from './acctitleVueModal3.vue';
// -----------------------------------------------------------------------------
export default {
  props: {},
  data: function () {
    return {
      accall: '',
      bacc_code: '',
      bacc_name: '',
      dacc_code: '',
      dacc_name: '',
      detail_name: '',
      use_yn: '',
      dacc_div: '',
      dacc_detail: '',
      daccall: '',
      R_F: '',
      SR_F: '',
      S_daccT: '',
      cpage: 1,
      pageSize: 10,
      pageBlockSize: 5,
      listNotice: [],
      listResult: [],
      armngList: [],
      totalPage: 1,
      totalCnt: 0,
      accd: '',
      gbn: '',
      noticePagination: '',
      key: 0,
      popUpItems: '',
      paction: '',
      listResult2: [],
    };
  },
  watch: {
    // 조회 초기화
    accall() {
      if (this.accall == '') {
        this.daccall = '';
        //this.dacc_div = '';
        this.S_daccT = '';
      }
      this.key += 1;
    },
  },
  mounted() {
    this.AccTitlelist();
  },
  components: {
    Paginate: Paginate,
    selectComCombo,
    ComCombo,
  },
  methods: {
    closeThis: function () {
      this.emitter.emit('close', null);
    },
    test: function () {
      console.log();
    },
    AccTitlelist: function (cpage) {
      let vm = this;
      this.cpage = cpage || 1;
      let params = new URLSearchParams();
      params.append('pageSize', vm.pageSize);
      params.append('cpage', vm.cpage);
      params.append('bacc_code', vm.accall);
      params.append('dacc_code', vm.daccall);
      params.append('R_F', vm.gbn);
      params.append('S_daccT', vm.S_daccT);
      axios
        .post('/accounting/listAccTitleVue.do', params)
        .then((res) => {
          vm.armngList = res.data.listAccTitle;
          vm.totalCnt = res.data.counthnoticelist;
          vm.totalPage = this.$page(this.totalCnt, this.pageSize);
          vm.listResult = res.data.listAccTitle;
        })
        .catch(function (error) {
          alert('에러! API 요청에 오류가 있습니다. ' + error);
        });
    },
    btnInsert: async function (action) {
      this.action = action;
      const modal = await openModal(acctitleVueModal, {
        popUpItems: this.listResult,
        paction: this.action,
      });
      console.log('btnInsert is called ...');
      modal.onclose = () => {
        console.log('the modal popup btnInsert is closed ...');
        this.AccTitlelist(this.cpage);
      };
    },
    btnUpdate: async function (action, item) {
      this.action = action;

      const modal = await openModal(acctitleVueModal, {
        pitem: this.listResult2,
        paction: this.action,
        dacc: item.dacc_code,
        bacc: item.bacc_code,
      });
      console.log('btnUpdate is called ... ');
      modal.onclose = () => {
        console.log('the modal popup btnUpdate is closed ...');
        this.AccTitlelist(this.cpage);
      };
    },
  },
};
</script>
