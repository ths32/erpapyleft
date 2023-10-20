<template>
  <p class="Location">
    <a href="#" class="btn_set home">메인으로</a>
    <a href="#" class="btn_nav">회계</a>
    <span class="btn_nav bold">지출결의서 조회 및 승인</span>
    <a href="#" class="btn_set refresh">새로고침</a>
  </p>

  <p class="conTitle">
    <span>지출결의서 조회</span>
  </p>

  <!-- 지출결의서 조회 조건 -->

  <div class="app_date_apply">
    <b>신청일자</b>
    <input type="date" id="from_date" v-model="fromDate" />~
    <input type="date" id="to_date" v-model="toDate" />
  </div>

  <div class="selectEmpDv">
    <b>계정대분류명</b>
    <selectComCombo
      comtype="acc"
      selectid="acc"
      type="all"
      selvalue=""
      v-model="accountCd"
    ></selectComCombo>
    <b>상세분류명</b>
    <selectComCombo
      comtype="accd"
      selectid="accs"
      type="cel"
      :searchkey="accountCd"
      selvalue=""
      v-model="detailAccountCd"
    ></selectComCombo>
    <b>승인여부</b>
    <select id="dv_sign" name="dv_sign" v-model="dvSign">
      <option value="" selected>전체</option>
      <option value="1">승인</option>
      <option value="2">반려</option>
      <option value="3">승인대기중</option>
    </select>
    <span class="fr">
      <a class="btnType blue" name="search" @click.prevent="search()">
        <span id="searchEnter">조회</span> </a
      ><br />
    </span>
  </div>

  <!-- 페이지에 출력할 컬럼명 -->

  <div class="divDvList">
    <table class="col">
      <caption>
        caption
      </caption>
      <colgroup>
        <col width="20%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="7%" />
        <col width="7%" />
      </colgroup>

      <thead>
        <tr>
          <th scope="col">결의번호</th>
          <th scope="col">계정대분류명</th>
          <th scope="col">상세분류명</th>
          <th scope="col">거래처명</th>
          <th scope="col">신청일자</th>
          <th scope="col">사용일자</th>
          <th scope="col">지출금액</th>
          <th scope="col">승인여부</th>
          <th scope="col">승인자</th>
        </tr>
      </thead>
      <template v-if="bmDvListCnt == 0">
        <tbody>
          <td colspan="9">데이터가 존재하지 않습니다.</td>
        </tbody>
      </template>
      <tbody v-for="(list, item) in bmDvList" :key="item">
        <tr @click.prevent="detailModal(list.dv_code, 'I')">
          <td>B-{{ list.dv_code }}-{{ list.dv_date }}</td>
          <td>{{ list.bacc_name }}</td>
          <td>{{ list.dacc_name }}</td>
          <td>{{ list.biz_name }}</td>
          <td>{{ list.dv_date }}</td>
          <td>{{ list.dv_udate }}</td>
          <td>{{ $comma(list.dv_fee) }}</td>
          <td>{{ list.detail_name }}</td>
          <td>{{ list.signName }}</td>
        </tr>
      </tbody>
    </table>
    <div
      class="paging_area"
      id="bmDvPagination"
      style="position: relative; bottom: 25.1px"
    >
      <paginate
        class="justify-content-center"
        v-model="cpage"
        :page-count="totalPage"
        :page-range="5"
        :margin-pages="0"
        :click-handler="fbmDvList"
        :prev-text="'Prev'"
        :next-text="'Next'"
        :container-class="'pagination'"
        :page-class="'page-item'"
        v-if="bmDvListCnt > 0"
      >
      </paginate>
    </div>
  </div>
</template>
<script>
import { vueListAxios } from '../accounting';
import paginate from 'vuejs-paginate-next';
import selectComCombo from '@/components/common/selectComCombo.vue';
import { openModal } from 'jenesius-vue-modal';
import bmDvVueModal from './bmDvVueModal.vue';
export default {
  components: {
    selectComCombo,
    paginate,
  },
  data() {
    return {
      bmDvList: [],
      bmDvListCnt: '',
      fromDate: '',
      toDate: '',
      accountCd: '',
      detailAccountCd: '',
      dvSign: '',
      pageSize: 5,
      cpage: 1,
      totalPage: 1,

      loginID: this.$session.get('loginId'),
      userNm: this.$session.get('userNm'),
    };
  },
  mounted() {
    this.fbmDvList();
  },
  methods: {
    fbmDvList: function (cpage) {
      this.cpage = cpage || 1;
      let params = new URLSearchParams();
      params.append('from_date', this.fromDate);
      params.append('to_date', this.toDate);
      params.append('account_cd', this.accountCd);
      params.append('detail_account_cd', this.detailAccountCd);
      params.append('dv_sign', this.dvSign);
      params.append('cpage', this.cpage);
      params.append('loginID', this.loginID);
      params.append('userNm', this.userNm);
      params.append('pageSize', this.pageSize);

      vueListAxios('/accounting/bmDvlistVue.do', params)
        .then((result) => {
          this.bmDvList = result.data.bmDvlist;
          this.bmDvListCnt = result.data.totalcnt;
          this.totalPage = this.page();
        })
        .catch((err) => {
          alert(err);
        });
    },
    page: function () {
      let total = this.bmDvListCnt;
      let page = this.pageSize;
      let xx = total % page;
      let result = parseInt(total / page);
      if (xx == 0) {
        return result;
      } else {
        result = result + 1;
        return result;
      }
    },
    search: function () {
      this.fbmDvList();
    },
    detailModal: async function (dv_code, action) {
      console.log('dv_code : ' + JSON.stringify(dv_code));
      console.log('action : ' + JSON.stringify(action));

      const modal = await openModal(bmDvVueModal, {
        mdlBmDvCode: dv_code,
        bmDvAction: action,
      });
      modal.onclose = () => {
        this.fbmDvList();
      };
    },
  },
};
</script>
