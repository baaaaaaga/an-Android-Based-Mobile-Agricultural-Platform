<template>
  <view class="page_schedule" id="page_schedule" :style="{ paddingTop: vuex_custom_bar_height + 'px' }">
    <tn-nav-bar>日程管理</tn-nav-bar>
    <view class="schedule">
      <view class="schedule-header">
        <view class="schedule-header-row">
          <view class="schedule-header-left">
            <span class="title"></span>
          </view>
          <view class="schedule-header-right">
            <view @click="show_add_schedule" class="btn-schedule">添加日程</view>
          </view>
        </view>
        <view class="schedule-header-row">
          <view class="schedule-header-left">
            <view class="day-date">
              {{ get_cur_date() }}
            </view>
          </view>
          <view class="schedule-header-right">
            <view class="schedule-btn-group">
              <view class="schedule-btn prev" @click="prev_month">上一个月</view>
              <view class="schedule-btn center" @click="go_to_current_day">今天</view>
              <view class="schedule-btn next" @click="next_month">下一个月</view>
            </view>
          </view>
        </view>
      </view>
      <view class="schedule-body">
        <table class="parent-table">
          <thead>
            <th>一</th>
            <th>二</th>
            <th>三</th>
            <th>四</th>
            <th>五</th>
            <th>六</th>
            <th>日</th>
          </thead>
          <tbody>
            <tr v-for="(week, windex) in weeks" :key="windex">
              <td
                v-for="(day, dindex) in week"
                @click.stop="select_day(day)"
                :class="{ 'highlight-bg': is_selected_day(day.date) || is_to_day(day.date) }"
                :key="dindex"
              >
                <view
                  class="content"
                  :class="{
                    faded: !is_current_month(day.date),
                  }"
                >
                  <view
                    class="top-day"
                    :class="{ 'highlight-text': is_selected_day(day.date) || is_to_day(day.date) }"
                  >
                    {{ day.date.getDate() }}
                  </view>
                  <view class="trip" v-if="day.schedule_list.length > 0"></view>
                </view>
              </td>
            </tr>
          </tbody>
        </table>
      </view>

      <view class="remind-wrapper" v-if="select_schedule.schedule_list.length > 0">
        <view class="remind-title">{{ select_schedule.dateText }}日程</view>
        <view class="remind-list">
          <span
            class="remind-item"
            @click="show_set_schedule(item)"
            v-for="(item, index) in select_schedule.schedule_list"
            :key="index"
            >{{ index + 1 }}. {{ item.content }}</span
          >
        </view>
      </view>

      <tn-popup mode="center" v-model="visible_add" width="90%" :zIndex="99">
        <view class="schedule-popup">
          <view class="schedule-popup-header">
            <view class="schedule-popup-title">添加日程</view>
            <view @click="visible_add = false"><text class="tn-icon-close"></text></view>
          </view>
          <view class="schedule-popup-content">
            <tn-input
              v-model="form_add.content"
              type="textarea"
              :border="true"
              :maxLength="200"
              :height="200"
              placeholder="请输入日程内容"
            />
          </view>
          <view class="schedule-popup-footer">
            <view class="me-btn cancle-btn" @click="visible_add = false">取 消</view>
            <view class="me-btn confirm-btn" @click="add_schedule">确 定</view>
          </view>
        </view>
      </tn-popup>

      <tn-popup mode="center" v-model="visible_set" width="90%" :zIndex="99">
        <view class="schedule-popup">
          <view class="schedule-popup-header">
            <view class="schedule-popup-title">查看日程</view>
            <view @click="visible_set = false"><text class="tn-icon-close"></text></view>
          </view>
          <view class="schedule-popup-content">
            <tn-input
              v-model="form_set.content"
              type="textarea"
              :border="true"
              :maxLength="200"
              :height="200"
              placeholder="请输入日程内容"
            />
          </view>
          <view class="schedule-popup-footer">
            <view class="me-btn cancle-btn" @click="visible_set = false">取 消</view>
            <view class="me-btn delete-btn" @click="del_schedule">删 除</view>
            <view class="me-btn confirm-btn" @click="set_schedule">确 定</view>
          </view>
        </view>
      </tn-popup>

      <tn-popup mode="center" v-model="visible_remind" width="90%" :zIndex="99">
        <view class="schedule-popup">
          <view class="schedule-popup-content">
            <view class="remind-wrapper">
              <view class="remind-title">明日待办:</view>
              <view class="remind-list">
                <span class="remind-item" v-for="(item, index) in remind_schedule_list" :key="index"
                  >{{ index + 1 }}. {{ item.content }}</span
                >
              </view>
            </view>
          </view>
          <view class="schedule-popup-footer">
            <view class="me-btn confirm-btn" @click="visible_remind = false">确 定</view>
          </view>
        </view>
      </tn-popup>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      is_loading: false,
      loading_submit: false,
      // 获取数据地址
      url_get_list: '~/api/schedule/get_list',
      // 查询
      query: {
        size: 9999,
        page: 1,
        orderby: 'create_time desc',
        user_id: '',
        scheduled_time_min: `${this.$toTime(
          this.getFirstDayOfPrevMonth(new Date()),
          'yyyy-MM-dd'
        )} 00:00:00`,
        scheduled_time_max: `${this.$toTime(
          this.getLastDayOfNextMonth(new Date()),
          'yyyy-MM-dd'
        )} 23:59:59`,
      },
      // 数据
      list: [],
      current: new Date(),
      today: new Date(),
      visible_add: false,
      visible_set: false,
      visible_remind: false,
      is_remind: false,
      form_add: {
        content: '',
        scheduled_time: this.$toTime(new Date(), 'yyyy-MM-dd hh:mm:ss'),
      },
      form_set: {},
      selected_date: new Date(),
      weeks: [],
      schedule_obj: {},
      select_schedule: {
        schedule_list: [],
      },
      remind_schedule_list: [],
    };
  },
  created() {
    this.query.user_id = this.userInfo.user_id;
    this.get_weeks();
    this.get_list_schedule();
  },
  // watch: {
  //   current(val) {
  //     console.log(this.$toTime(val, "yyyy-MM-dd"))
  //     this.query.scheduled_time_min = `${this.$toTime(new Date(val).setMonth(new Date(val).getMonth(), 0), "yyyy-MM-dd")} 00:00:00`
  //     this.query.scheduled_time_min = `${this.$toTime(new Date(val).setMonth(new Date(val).getMonth(), 0), "yyyy-MM-dd")} 00:00:00`
  //   },
  // },
  methods: {
    set_query_date() {
      // this.get_month_date(this.current, 1)
      this.query.scheduled_time_min = `${this.$toTime(
        this.getFirstDayOfPrevMonth(this.current),
        'yyyy-MM-dd'
      )} 00:00:00`;
      this.query.scheduled_time_max = `${this.$toTime(
        this.getLastDayOfNextMonth(this.current),
        'yyyy-MM-dd'
      )} 00:00:00`;
      // this.query.scheduled_time_min = `${this.$toTime(new Date(this.current).setMonth(this.get_month_date(this.current, 1).getMonth(), 0), "yyyy-MM-dd")} 00:00:00`
      // this.query.scheduled_time_min = `${this.$toTime(new Date(this.current).setMonth(this.get_month_date(this.current, 1).getMonth(), 0), "yyyy-MM-dd")} 00:00:00`
    },
    get_list_schedule() {
      if (this.is_loading) return;
      this.is_loading = true;
      this.$get(this.url_get_list, { ...this.query }, (json) => {
        if (json.result) {
          this.list = json.result.list;
		  this.list.map(item => {
		  	item.scheduled_time = this.$toTime(item.scheduled_time, 'yyyy-MM-dd');
		  })
          let tempList = JSON.parse(JSON.stringify(this.list));
          this.schedule_obj = this.groupByDate(tempList, 'scheduled_time', 2);
          this.get_weeks();
          const dayDateText = this.$toTime(this.selected_date, 'yyyy-MM-dd');

          this.select_schedule = {
            date: this.selected_date,
            dateText: dayDateText,
            schedule_list: this.schedule_obj[dayDateText] || [],
          };
          if (!this.is_remind) {
            let today = new Date(); // 获取当前日期
            today.setDate(today.getDate() + 1); // 设置为当前日期加上1天
            const dayDateText = this.$toTime(today, 'yyyy-MM-dd');
            this.remind_schedule_list = this.schedule_obj[dayDateText];

            if (this.remind_schedule_list.length > 0) {
              this.is_remind = true;
              this.visible_remind = true;
            }
          }
        }
        this.is_loading = false;
      }).catch((err) => {
        this.is_loading = false;
      });
    },
    get_weeks() {
      this.weeks = this.get_month_data(this.current.getFullYear(), this.current.getMonth() + 1);
    },
    show_add_schedule() {
      this.form_add.content = '';
      this.visible_add = true;
    },
    show_set_schedule(item) {
      this.form_set = {
        schedule_id: item.schedule_id,
        content: item.content,
      };
      this.visible_set = true;
    },
    handle_add_close(done) {
      done();
    },
    handle_set_close(done) {
      done();
    },
    add_schedule() {
      if (!this.form_add.content) {
        this.$toast('请输入日程内容');
        return;
      }
      if (this.loading_submit) return;

      this.loading_submit = true;
      this.form_add.scheduled_time = this.$toTime(this.selected_date, 'yyyy-MM-dd hh:mm:ss');
      this.$post(
        `~/api/schedule/add?`,
        { ...this.form_add, user_id: this.userInfo.user_id },
        (res) => {
          if (res.result === 1) {
            this.$toast('添加成功');
            this.get_list_schedule();
          } else {
            this.$toast('添加失败');
          }
          this.loading_submit = false;
          this.visible_add = false;
        }
      ).catch(() => {
        this.loading_submit = false;
        this.visible_add = false;
      });
    },
    set_schedule() {
      if (!this.form_set.content) {
        this.$toast('请输入日程内容');
        return;
      }
      if (this.loading_submit) return;
      this.loading_submit = true;
      this.$post(
        `~/api/schedule/set?schedule_id=${this.form_set.schedule_id}`,
        { ...this.form_set },
        (res) => {
          if (res.result === 1) {
            this.$toast('编辑成功');
            this.get_list_schedule();
          } else {
            this.$toast('编辑失败');
          }
          this.loading_submit = false;
          this.visible_set = false;
        }
      ).catch(() => {
        this.loading_submit = false;
        this.visible_set = false;
      });
    },
    del_schedule() {
      this.visible_set = false;
      if (!this.form_set.schedule_id) {
        this.$toast('删除失败');
      }

      uni.showModal({
        title: '提示',
        content: '是否确认删除日程?',
        success: (res) => {
          if (res.confirm) {
            if (this.loading_submit) return;
            this.loading_submit = true;
            this.$get(`~/api/schedule/del`, { schedule_id: this.form_set.schedule_id }, (res) => {
              if (res.result === 1) {
                this.$toast('删除成功');
                this.get_list_schedule();
              } else {
                this.$toast('删除失败');
              }
              this.loading_submit = false;
              this.visible_add = false;
            }).catch(() => {
              this.loading_submit = false;
              this.visible_add = false;
            });
          } else if (res.cancel) {
          }
        },
      });
    },
    select_day(date) {
      this.select_schedule = date;
      this.selected_date = date.date;
    },
    get_cur_date() {
      const year = this.current.getFullYear();
      let month = this.current.getMonth() + 1; // getMonth() returns a zero-based value (0-11)
      if (month < 10) {
        month = '0' + month; // add a leading zero if the month is a single digit
      }
      return year + '-' + month;
    },
    is_selected_day(date) {
      return this.$toTime(this.selected_date, 'yyyy-MM-dd') === this.$toTime(date, 'yyyy-MM-dd');
    },
    is_to_day(date) {
      return this.$toTime(new Date(), 'yyyy-MM-dd') === this.$toTime(date, 'yyyy-MM-dd');
    },
    go_to_current_day() {
      this.current = new Date(this.today);
      this.selected_date = this.current;
      this.set_query_date();
      this.get_list_schedule();
    },
    is_current_month(date) {
      return date.getMonth() === this.current.getMonth();
    },
    prev_month() {
      this.current.setMonth(this.current.getMonth() - 1);
      this.current = new Date(this.current);
      this.selected_date = undefined;
      this.set_query_date();
      this.get_list_schedule();
      // console.log(this.current.getFullYear(), 'dedede')
    },
    next_month() {
      this.current.setMonth(this.current.getMonth() + 1);
      this.current = new Date(this.current);
      this.selected_date = undefined;
      this.set_query_date();
      this.get_list_schedule();
    },
    go_to_current_month() {
      this.current = new Date();
      this.set_query_date();
    },
    get_month_data(year, month) {
      let weeks = [];
      let firstDay = new Date(year, month - 1, 1); // 这个月的第一天
      let lastDayOfCurrentMonth = new Date(year, month, 0); // 这个月的最后一天
      let lastDayOfPrevMonth = new Date(year, month - 1, 0); // 上个月的最后一天

      //这里的0有一个特殊的意义，它可以返回上个月的最后一天。也就是说，如果你想知道某个月有多少天，你可以创建一个日期对象，年份和月份设置为你想知道的月份，日期设置为0，然后调用getDate()方法，返回的就是那个月的天数。
      // new Date(year, month - 1, 0) 最后一个参数，超过当月天数重新排序，比如1月31天，最后一个参数为33返回2
      let startDayOfWeek = firstDay.getDay() === 0 ? 7 : firstDay.getDay(); // 开始是周几
      let dayCount = 1; // 当前日期的变量，初始值为1
      // 上一个月的天数
      let prev_monthDayCount = lastDayOfPrevMonth.getDate() - startDayOfWeek + 2; // 这是为了在日历中填充上个月的日期。
      // console.log(lastDayOfPrevMonth.getDate(), startDayOfWeek, prev_monthDayCount)
      for (let i = 0; i < 6; i++) {
        let week = [];
        for (let j = 0; j < 7; j++) {
          // 日期为上个月的日期，然后将这个日期对象添加到`week`数组中，同时`prev_monthDayCount`加1。
          if (i === 0 && j < startDayOfWeek - 1) {
            // this.schedule_obj

            const dateText = this.$toTime(
              new Date(year, month - 2, prev_monthDayCount),
              'yyyy-MM-dd'
            );

            const schedule_list = this.schedule_obj[dateText] || [];
            week.push({
              date: new Date(year, month - 2, prev_monthDayCount++),
              dateText,
              schedule_list,
            });
            // 日期为下个月的日期，然后将这个日期对象添加到`week`数组中，同时`dayCount`加1
          } else if (dayCount > lastDayOfCurrentMonth.getDate()) {
            const dateText = this.$toTime(
              new Date(year, month, dayCount - lastDayOfCurrentMonth.getDate()),
              'yyyy-MM-dd'
            );

            const schedule_list = this.schedule_obj[dateText] || [];
            week.push({
              date: new Date(year, month, dayCount++ - lastDayOfCurrentMonth.getDate()),
              dateText,
              schedule_list,
            });
            // 日期为这个月的日期，然后将这个日期对象添加到`week`数组中，同时`dayCount`加1
          } else {
            const dateText = this.$toTime(new Date(year, month - 1, dayCount), 'yyyy-MM-dd');

            const schedule_list = this.schedule_obj[dateText] || [];
            week.push({
              date: new Date(year, month - 1, dayCount++),
              dateText,
              schedule_list,
            });
          }
        }
        weeks.push(week);
      }
      return weeks;
    },

    /**
     * 集合根据日期分组
     * @param {Array} list
     * @param {String} dateKey 分组日期属性
     * @param {Number} [type=1]  分组类型 0.年 1.月 2.日
     *
     * @returns {Map<String, Array>} 日期(yyyy-MM-dd)-集合
     */
    groupByDate(list, dateKey, type = 1) {
      const result = {};
      if (!list || !list.length || !dateKey) return result;

      function generateMapKey(date) {
        date = date.substring(0, 10);
        if (type === 2) {
          return date;
        }

        const dates = date.split('-');
        if (type === 0) {
          return `${dates[0]}-1-1`;
        }
        if (type === 1) {
          return `${dates[0]}-${dates[1]}-1`;
        }
      }

      list.map((item) => {
        const mapKey = generateMapKey(item[dateKey]);
        let dataList = [];
        if (result[mapKey]) {
          result[mapKey].push(item);
        } else {
          dataList.push(item);
          result[mapKey] = dataList;
        }
      });

      return result;
    },
    getFirstDayOfPrevMonth(currentDate) {
      currentDate.setMonth(currentDate.getMonth() - 1);
      let prevYear = currentDate.getFullYear();
      let prevMonth = currentDate.getMonth();
      return new Date(prevYear, prevMonth, 1);
    },
    getLastDayOfNextMonth(currentDate) {
      currentDate.setMonth(currentDate.getMonth() + 1);
      let nextMonth = currentDate.getMonth() + 1;
      let nextYear = currentDate.getFullYear();
      return new Date(nextYear, nextMonth + 1, 0);
    },
  },
};
</script>
<style lang="scss" scoped>
@import 'styles/pagesB/index.scss';
</style>
