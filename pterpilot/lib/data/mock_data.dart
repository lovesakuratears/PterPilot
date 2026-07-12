import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';

class MockData {
  static List<Movie> get top250 => _top250;
  static List<Movie> get nowPlaying => _nowPlaying;
  static List<Movie> get comingSoon => _comingSoon;
  static List<Site> get sites => _sites;
  static List<Torrent> get searchResults => _searchResults;
  static List<DownloadTask> get downloadTasks => _downloadTasks;
  static List<PluginItem> get plugins => _plugins;

  static Movie getMovieById(String id) {
    final all = [..._top250, ..._nowPlaying, ..._comingSoon].expand((e);
    return all.firstWhere(
      (m) => m.id == id,
      orElse: () => _top250.first,
    );
  }

  static final List<Movie> _top250 = [
    Movie(id: '1292052', rank: 1, title: '肖申克的救赎', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p480747492.jpg', doubanRating: 9.7, year: '1994', region: '美国', genres: ['犯罪', '剧情'], directors: ['弗兰克·德拉邦特'], actors: ['蒂姆·罗宾斯', '摩根·弗里曼'], ratingCount: '2856233人评价', quote: '希望让人自由。', summary: '一场谋杀案使银行家安迪蒙冤入狱，谋杀妻子及其情人的指控将囚禁他终生。在肖申克监狱里，希望似乎虚无缥缈，终身监禁的惩罚无法挽回。安迪的到来，让瑞德重新认识了这个世界，也让肖申克监狱里的每一个人重新看到了希望。', runtime: '142分钟'),
    Movie(id: '1291546', rank: 2, title: '霸王别姬', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2561716440.jpg', doubanRating: 9.6, year: '1993', region: '中国大陆 中国香港', genres: ['剧情', '爱情', '同性'], directors: ['陈凯歌'], actors: ['张国荣', '张丰毅', '巩俐'], ratingCount: '2142206人评价', quote: '风华绝代。', summary: '段小楼与程蝶衣是一对打小一起长大的师兄弟，两人一个演生，一个饰旦，一向配合天衣无缝，尤其一出《霸王别姬》，更是誉满京城。', runtime: '171分钟'),
    Movie(id: '1292720', rank: 3, title: '阿甘正传', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2372307693.jpg', doubanRating: 9.5, year: '1994', region: '美国', genres: ['剧情', '爱情'], directors: ['罗伯特·泽米吉斯'], actors: ['汤姆·汉克斯', '罗宾·怀特'], ratingCount: '2203200人评价', quote: '一部美国近现代史。', summary: '阿甘是个智商只有75的低能儿。在学校里为了躲避别的孩子的欺侮，听从一个朋友珍妮的话而开始"跑"。', runtime: '142分钟'),
    Movie(id: '1295644', rank: 4, title: '这个杀手不太冷', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p511118051.jpg', doubanRating: 9.4, year: '1994', region: '法国 美国', genres: ['剧情', '动作', '犯罪'], directors: ['吕克·贝松'], actors: ['让·雷诺', '娜塔莉·波特曼'], ratingCount: '2289123人评价', quote: '怪蜀黍和小萝莉不得不说的故事。', summary: '里昂是名孤独的职业杀手，受人雇佣。一天，邻居家小姑娘马蒂尔达敲开他的房门，要求在他那里暂避杀身之祸。', runtime: '110分钟'),
    Movie(id: '1292063', rank: 5, title: '泰坦尼克号', cover: 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p457760035.jpg', doubanRating: 9.4, year: '1997', region: '美国 墨西哥', genres: ['剧情', '爱情', '灾难'], directors: ['詹姆斯·卡梅隆'], actors: ['莱昂纳多·迪卡普里奥', '凯特·温斯莱特'], ratingCount: '2171021人评价', quote: '失去的才是永恒的。', runtime: '194分钟'),
    Movie(id: '1292001', rank: 6, title: '美丽人生', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p510861873.jpg', doubanRating: 9.6, year: '1997', region: '意大利', genres: ['剧情', '喜剧', '爱情', '战争'], directors: ['罗伯托·贝尼尼'], actors: ['罗伯托·贝尼尼'], ratingCount: '1389701人评价', quote: '最美的谎言。'),
    Movie(id: '1292000', rank: 7, title: '千与千寻', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2557573348.jpg', doubanRating: 9.4, year: '2001', region: '日本', genres: ['剧情', '动画', '奇幻'], directors: ['宫崎骏'], actors: ['柊瑠美', '入野自由'], ratingCount: '2221019人评价', quote: '最好的宫崎骏，最好的久石让。'),
    Movie(id: '1292056', rank: 8, title: '辛德勒的名单', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p492406163.jpg', doubanRating: 9.5, year: '1993', region: '美国', genres: ['剧情', '历史', '战争'], directors: ['史蒂文·斯皮尔伯格'], actors: ['连姆·尼森'], ratingCount: '1087234人评价', quote: '拯救一个人，就是拯救整个世界。'),
    Movie(id: '1293172', rank: 9, title: '盗梦空间', cover: 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p513344864.jpg', doubanRating: 9.4, year: '2010', region: '美国 英国', genres: ['剧情', '科幻', '悬疑', '冒险'], directors: ['克里斯托弗·诺兰'], actors: ['莱昂纳多·迪卡普里奥'], ratingCount: '2176898人评价', quote: '诺兰给了我们一场无法盗取的梦。'),
    Movie(id: '1295124', rank: 10, title: '星际穿越', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2614359264.jpg', doubanRating: 9.4, year: '2014', region: '美国 英国 加拿大', genres: ['剧情', '科幻', '冒险'], directors: ['克里斯托弗·诺兰'], actors: ['马修·麦康纳'], ratingCount: '1848158人评价', quote: '爱是一种力量，让我们超越时空感知它的存在。'),
  ];

  static final List<Movie> _nowPlaying = [
    Movie(id: '36257860', title: '流浪地球3', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2910381800.jpg', doubanRating: 7.8, year: '2025', region: '中国大陆', genres: ['科幻', '冒险'], directors: ['郭帆'], actors: ['吴京', '刘德华', '李雪健'], ratingCount: '567890人评价'),
    Movie(id: '35267205', title: '哪吒之魔童闹海', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2910999717.jpg', doubanRating: 8.2, year: '2025', region: '中国大陆', genres: ['动画', '奇幻'], directors: ['饺子'], actors: ['吕艳婷', '囧森瑟夫'], ratingCount: '890123人评价'),
    Movie(id: '1292052', title: '肖申克的救赎', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p480747492.jpg', doubanRating: 9.7, year: '1994', region: '美国', genres: ['犯罪', '剧情'], directors: ['弗兰克·德拉邦特'], ratingCount: '2856233人评价'),
    Movie(id: '1295644', title: '这个杀手不太冷', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p511118051.jpg', doubanRating: 9.4, year: '1994', region: '法国 美国'),
    Movie(id: '1292000', title: '千与千寻', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2557573348.jpg', doubanRating: 9.4, year: '2001', region: '日本'),
    Movie(id: '1293172', title: '盗梦空间', cover: 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p513344864.jpg', doubanRating: 9.4, year: '2010', region: '美国 英国'),
  ];

  static final List<Movie> _comingSoon = [
    Movie(id: '35797709', title: '速度与激情11', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2879654321.jpg', doubanRating: 0, year: '2025', releaseDate: '2025年6月', wishCount: '12345人想看'),
    Movie(id: '35575661', title: '复仇者联盟5', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2889765432.jpg', doubanRating: 0, year: '2026', releaseDate: '2026年5月', wishCount: '56789人想看'),
    Movie(id: '36257860', title: '流浪地球3', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2910381800.jpg', doubanRating: 0, year: '2025', releaseDate: '2025年1月', wishCount: '99999人想看'),
    Movie(id: '35267205', title: '哪吒之魔童闹海', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2910999717.jpg', doubanRating: 0, year: '2025', releaseDate: '2025年1月', wishCount: '123456人想看'),
    Movie(id: '1292000', title: '千与千寻', cover: 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2557573348.jpg', doubanRating: 0, year: '2001', releaseDate: '重映待定', wishCount: '8888人想看'),
  ];

  static final List<Site> _sites = [
    Site(name: '馒头PT', url: 'https://mteam.pt', favicon: '', status: SiteStatus.online, vipLevel: 'VIP6', magic: '98,650', upload: '62.3 TB', download: '8.1 TB', ratio: '7.7x'),
    Site(name: '红豆PT', url: 'https://hdcity.work', favicon: '', status: SiteStatus.online, vipLevel: 'VIP6', magic: '120,340', upload: '108.5 TB', download: '12.4 TB', ratio: '8.8x'),
    Site(name: '瓷器PT', url: 'https://site3.pt', favicon: '', status: SiteStatus.online, vipLevel: 'VIP5', magic: '54,210', upload: '45.2 TB', download: '6.3 TB', ratio: '7.2x'),
    Site(name: '友学PT', url: 'https://ubits.pt', favicon: '', status: SiteStatus.online, vipLevel: 'VIP5', magic: '40,210', upload: '32.8 TB', download: '5.1 TB', ratio: '6.4x'),
    Site(name: '天空PT', url: 'https://skyey24.cc', favicon: '', status: SiteStatus.online, vipLevel: 'VIP4', magic: '31,880', upload: '28.6 TB', download: '4.2 TB', ratio: '6.8x'),
    Site(name: '黎明PT', url: 'https://lemonhd.org', favicon: '', status: SiteStatus.online, vipLevel: 'VIP4', magic: '22,190', upload: '18.4 TB', download: '3.7 TB', ratio: '5.0x'),
    Site(name: '憨憨PT', url: 'https://hhanclub.top', favicon: '', status: SiteStatus.cf, vipLevel: 'VIP3', magic: '19,670', upload: '15.2 TB', download: '4.8 TB', ratio: '3.2x'),
    Site(name: '城市PT', url: 'https://citypt.vip', favicon: '', status: SiteStatus.online, vipLevel: 'VIP3', magic: '16,740', upload: '12.8 TB', download: '3.1 TB', ratio: '4.1x'),
    Site(name: '葡萄PT', url: 'https://pt.btschool.club', favicon: '', status: SiteStatus.online, vipLevel: 'VIP4', magic: '24,510', upload: '20.1 TB', download: '4.5 TB', ratio: '4.5x'),
    Site(name: '蝴蝶PT', url: 'https://butter.pt', favicon: '', status: SiteStatus.online, vipLevel: 'VIP3', magic: '14,230', upload: '9.8 TB', download: '2.6 TB', ratio: '3.8x'),
    Site(name: '春田PT', url: 'https://spring.pt', favicon: '', status: SiteStatus.cf, vipLevel: 'VIP2', magic: '10,980', upload: '7.4 TB', download: '3.2 TB', ratio: '2.3x'),
    Site(name: '备胎PT', url: 'https://beitai.pt', favicon: '', status: SiteStatus.offline, vipLevel: 'VIP2', magic: '8,830', upload: '5.2 TB', download: '2.1 TB', ratio: '2.5x'),
  ];

  static final List<Torrent> _searchResults = [
    Torrent(id: '1', title: '阿凡达：水之道 Avatar.The.Way.of.Water.2022.2160p.UHD.Blu-ray REMUX', site: '馒头', siteColor: AppColors.primary, size: '68.5 GB', seeders: 254, leechers: 89, date: '2024-12-15', promo: 'FREE'),
    Torrent(id: '2', title: '阿凡达 Avatar.2009.BluRay.1080p.DTS.x264-CHD', site: '瓷器', siteColor: AppColors.info, size: '12.3 GB', seeders: 182, leechers: 67, date: '2024-10-08', promo: '50%'),
    Torrent(id: '3', title: '阿凡达2：水之道 4K HDR 杜比全景声', site: '天空', siteColor: AppColors.magic, size: '45.8 GB', seeders: 310, leechers: 122, date: '2025-01-20', promo: 'FREE'),
    Torrent(id: '4', title: '阿凡达 水之道 3D ISO 完整原盘', site: '葡萄', siteColor: AppColors.warn, size: '78.2 GB', seeders: 98, leechers: 41, date: '2024-09-22', promo: '50%'),
    Torrent(id: '5', title: 'Avatar.2009.Extended.Cut.2160p.UHD.BluRay.REMUX.HEVC', site: '蝴蝶', siteColor: AppColors.primary, size: '52.1 GB', seeders: 145, leechers: 58, date: '2025-02-14', promo: 'FREE'),
    Torrent(id: '6', title: '阿凡达三部曲 蓝光全集 REMUX 4K HDR', site: '瓷器', siteColor: AppColors.info, size: '156.4 GB', seeders: 78, leechers: 35, date: '2025-05-18', promo: 'FREE'),
  ];

  static final List<DownloadTask> _downloadTasks = [
    DownloadTask(id: '1', title: '阿凡达：水之道.2022.4K.HDR', progress: 0.785, status: DownloadStatus.downloading, size: '68.5 GB', downloadSpeed: '8.2 MB/s', uploadSpeed: '1.1 MB/s', remaining: '3min'),
    DownloadTask(id: '2', title: '流浪地球2.2023.4K.REMUX', progress: 1.0, status: DownloadStatus.seeding, size: '45.2 GB', uploadSpeed: '0 KB/s', ratio: 3.2),
    DownloadTask(id: '3', title: '奥本海默.2023.1080p.BluRay', progress: 0.523, status: DownloadStatus.paused, size: '12.8 GB'),
    DownloadTask(id: '4', title: '蜘蛛侠：纵横宇宙.2023.2160p', progress: 0.0, status: DownloadStatus.error, size: '32.1 GB'),
    DownloadTask(id: '5', title: '银河护卫队3.2023.4K.HDR', progress: 1.0, status: DownloadStatus.seeding, size: '56.7 GB', uploadSpeed: '256 KB/s', ratio: 2.5),
    DownloadTask(id: '6', title: '沙丘2.2024.IMAX.2160p', progress: 0.35, status: DownloadStatus.downloading, size: '72.3 GB', downloadSpeed: '5.6 MB/s', uploadSpeed: '800 KB/s', remaining: '1h 23min'),
    DownloadTask(id: '7', title: '速度与激情10.2023.1080p', progress: 1.0, status: DownloadStatus.seeding, size: '8.5 GB', uploadSpeed: '0 KB/s', ratio: 5.8),
  ];

  static final List<PluginItem> _plugins = [
    PluginItem(name: '下载器管理', version: 'v1.0.0', source: '官方', icon: 'download', description: 'qBittorrent / Transmission 远程控制，种子推送与批量操作', isRunning: true),
    PluginItem(name: '站点管理', version: 'v1.0.0', source: '官方', icon: 'globe', description: '多站点聚合管理，CookieCloud 同步，登录失效检测', isRunning: true),
    PluginItem(name: '聚合搜索', version: 'v1.0.0', source: '官方', icon: 'search', description: '跨站点并发搜索，聚合展示，一键推种', isRunning: true),
    PluginItem(name: '影视资料', version: 'v1.0.0', source: '官方', icon: 'film', description: '豆瓣 / TMDB 影视发现，详情页一键搜种', isRunning: true),
    PluginItem(name: 'MoviePilot 接入', version: 'v0.9.0', source: '官方', icon: 'link', description: 'MoviePilot 订阅与媒体整理功能接入', isRunning: true),
    PluginItem(name: '站点签到', version: 'v0.8.5', source: '社区', icon: 'check_circle', description: '自动批量签到，魔力值增长提醒', isRunning: true, hasUpdate: true),
    PluginItem(name: '数据看板', version: 'v0.7.2', source: '社区', icon: 'bar_chart', description: 'PT 数据可视化看板，上传/下载/魔力趋势图', isRunning: false, hasUpdate: true),
  ];
}
