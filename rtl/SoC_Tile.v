module CSR( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input         io_stall, // @[:@6.4]
  input  [2:0]  io_cmd, // @[:@6.4]
  input  [31:0] io_in, // @[:@6.4]
  output [31:0] io_out, // @[:@6.4]
  input  [31:0] io_pc, // @[:@6.4]
  input  [31:0] io_addr, // @[:@6.4]
  input  [31:0] io_inst, // @[:@6.4]
  input         io_illegal, // @[:@6.4]
  input  [1:0]  io_st_type, // @[:@6.4]
  input  [2:0]  io_ld_type, // @[:@6.4]
  input         io_pc_check, // @[:@6.4]
  output        io_expt, // @[:@6.4]
  output [31:0] io_evec, // @[:@6.4]
  output [31:0] io_epc, // @[:@6.4]
  input         io_irq_uart_irq, // @[:@6.4]
  input         io_irq_spi_irq, // @[:@6.4]
  input         io_irq_m1_irq, // @[:@6.4]
  input         io_irq_m2_irq, // @[:@6.4]
  input         io_irq_m3_irq, // @[:@6.4]
  input         io_br_taken // @[:@6.4]
);
  wire [11:0] csr_addr; // @[csr.scala 108:27:@8.4]
  wire [4:0] rs1_addr; // @[csr.scala 109:27:@9.4]
  reg [31:0] time$; // @[csr.scala 112:27:@10.4]
  reg [31:0] _RAND_0;
  reg [31:0] timeh; // @[csr.scala 113:27:@11.4]
  reg [31:0] _RAND_1;
  reg [31:0] cycle; // @[csr.scala 114:27:@12.4]
  reg [31:0] _RAND_2;
  reg [31:0] cycleh; // @[csr.scala 115:27:@13.4]
  reg [31:0] _RAND_3;
  reg [31:0] instret; // @[csr.scala 116:27:@14.4]
  reg [31:0] _RAND_4;
  reg [31:0] instreth; // @[csr.scala 117:27:@15.4]
  reg [31:0] _RAND_5;
  reg [1:0] mstatus_prv; // @[csr.scala 131:23:@16.4]
  reg [31:0] _RAND_6;
  reg [1:0] mstatus_mpp; // @[csr.scala 131:23:@16.4]
  reg [31:0] _RAND_7;
  reg  mstatus_mpie; // @[csr.scala 131:23:@16.4]
  reg [31:0] _RAND_8;
  reg  mstatus_mie; // @[csr.scala 131:23:@16.4]
  reg [31:0] _RAND_9;
  reg  mie_motor3ie; // @[csr.scala 132:23:@17.4]
  reg [31:0] _RAND_10;
  reg  mie_motor2ie; // @[csr.scala 132:23:@17.4]
  reg [31:0] _RAND_11;
  reg  mie_motor1ie; // @[csr.scala 132:23:@17.4]
  reg [31:0] _RAND_12;
  reg  mie_spiie; // @[csr.scala 132:23:@17.4]
  reg [31:0] _RAND_13;
  reg  mie_uartie; // @[csr.scala 132:23:@17.4]
  reg [31:0] _RAND_14;
  reg  mie_mtie; // @[csr.scala 132:23:@17.4]
  reg [31:0] _RAND_15;
  reg  mie_msie; // @[csr.scala 132:23:@17.4]
  reg [31:0] _RAND_16;
  reg  mip_motor1ip; // @[csr.scala 134:27:@19.4]
  reg [31:0] _RAND_17;
  reg  mip_motor2ip; // @[csr.scala 134:27:@19.4]
  reg [31:0] _RAND_18;
  reg  mip_motor3ip; // @[csr.scala 134:27:@19.4]
  reg [31:0] _RAND_19;
  reg  mip_spiip; // @[csr.scala 134:27:@19.4]
  reg [31:0] _RAND_20;
  reg  mip_uartip; // @[csr.scala 134:27:@19.4]
  reg [31:0] _RAND_21;
  reg  mip_mtip; // @[csr.scala 134:27:@19.4]
  reg [31:0] _RAND_22;
  reg  mip_msip; // @[csr.scala 134:27:@19.4]
  reg [31:0] _RAND_23;
  reg [31:0] mtvec; // @[csr.scala 138:27:@20.4]
  reg [31:0] _RAND_24;
  reg [31:0] mscratch; // @[csr.scala 141:23:@21.4]
  reg [31:0] _RAND_25;
  reg [31:0] mepc; // @[csr.scala 142:23:@22.4]
  reg [31:0] _RAND_26;
  reg [31:0] mcause; // @[csr.scala 143:23:@23.4]
  reg [31:0] _RAND_27;
  reg [31:0] mtval; // @[csr.scala 144:23:@24.4]
  reg [31:0] _RAND_28;
  wire  _GEN_0; // @[csr.scala 148:3:@26.4]
  wire  _GEN_1; // @[csr.scala 148:3:@26.4]
  wire  _GEN_2; // @[csr.scala 148:3:@26.4]
  wire  _GEN_3; // @[csr.scala 148:3:@26.4]
  wire  _GEN_4; // @[csr.scala 148:3:@26.4]
  wire  _GEN_5; // @[csr.scala 148:3:@26.4]
  wire [1:0] _GEN_6; // @[csr.scala 148:3:@26.4]
  wire [1:0] _GEN_7; // @[csr.scala 148:3:@26.4]
  wire [8:0] _T_154; // @[csr.scala 168:34:@43.4]
  wire [31:0] _T_164; // @[csr.scala 168:34:@53.4]
  wire [8:0] _T_172; // @[csr.scala 173:34:@61.4]
  wire [31:0] _T_182; // @[csr.scala 173:34:@71.4]
  wire [12:0] _T_192; // @[csr.scala 174:38:@81.4]
  wire [31:0] _T_203; // @[csr.scala 174:38:@92.4]
  wire  _T_208; // @[Lookup.scala 9:38:@94.4]
  wire  _T_212; // @[Lookup.scala 9:38:@96.4]
  wire  _T_216; // @[Lookup.scala 9:38:@98.4]
  wire  _T_220; // @[Lookup.scala 9:38:@100.4]
  wire  _T_224; // @[Lookup.scala 9:38:@102.4]
  wire  _T_228; // @[Lookup.scala 9:38:@104.4]
  wire  _T_232; // @[Lookup.scala 9:38:@106.4]
  wire  _T_236; // @[Lookup.scala 9:38:@108.4]
  wire  _T_240; // @[Lookup.scala 9:38:@110.4]
  wire  _T_244; // @[Lookup.scala 9:38:@112.4]
  wire  _T_248; // @[Lookup.scala 9:38:@114.4]
  wire  _T_252; // @[Lookup.scala 9:38:@116.4]
  wire  _T_256; // @[Lookup.scala 9:38:@118.4]
  wire  _T_260; // @[Lookup.scala 9:38:@120.4]
  wire  _T_264; // @[Lookup.scala 9:38:@122.4]
  wire [31:0] _T_265; // @[Lookup.scala 11:37:@123.4]
  wire [31:0] _T_266; // @[Lookup.scala 11:37:@124.4]
  wire [31:0] _T_267; // @[Lookup.scala 11:37:@125.4]
  wire [31:0] _T_268; // @[Lookup.scala 11:37:@126.4]
  wire [31:0] _T_269; // @[Lookup.scala 11:37:@127.4]
  wire [31:0] _T_270; // @[Lookup.scala 11:37:@128.4]
  wire [31:0] _T_271; // @[Lookup.scala 11:37:@129.4]
  wire [31:0] _T_272; // @[Lookup.scala 11:37:@130.4]
  wire [31:0] _T_273; // @[Lookup.scala 11:37:@131.4]
  wire [31:0] _T_274; // @[Lookup.scala 11:37:@132.4]
  wire [31:0] _T_275; // @[Lookup.scala 11:37:@133.4]
  wire [31:0] _T_276; // @[Lookup.scala 11:37:@134.4]
  wire [31:0] _T_277; // @[Lookup.scala 11:37:@135.4]
  wire [31:0] _T_278; // @[Lookup.scala 11:37:@136.4]
  wire [1:0] _T_280; // @[csr.scala 182:31:@139.4]
  wire  privValid; // @[csr.scala 182:38:@140.4]
  wire  privInst; // @[csr.scala 183:30:@141.4]
  wire  _T_281; // @[csr.scala 184:44:@142.4]
  wire  _T_283; // @[csr.scala 184:35:@143.4]
  wire  _T_284; // @[csr.scala 184:32:@144.4]
  wire  _T_285; // @[csr.scala 184:60:@145.4]
  wire  _T_287; // @[csr.scala 184:51:@146.4]
  wire  isEcall; // @[csr.scala 184:48:@147.4]
  wire  _T_289; // @[csr.scala 185:32:@149.4]
  wire  isEbreak; // @[csr.scala 185:48:@152.4]
  wire  isEret; // @[csr.scala 186:48:@157.4]
  wire  _T_298; // @[csr.scala 187:45:@158.4]
  wire  iaddrInvalid; // @[csr.scala 187:35:@159.4]
  wire [1:0] _T_300; // @[csr.scala 189:49:@160.4]
  wire  _T_302; // @[csr.scala 189:56:@161.4]
  wire  _T_303; // @[csr.scala 189:77:@162.4]
  wire  _T_305; // @[Mux.scala 46:19:@164.4]
  wire  _T_306; // @[Mux.scala 46:16:@165.4]
  wire  _T_307; // @[Mux.scala 46:19:@166.4]
  wire  _T_308; // @[Mux.scala 46:16:@167.4]
  wire  _T_309; // @[Mux.scala 46:19:@168.4]
  wire  laddrInvalid; // @[Mux.scala 46:16:@169.4]
  wire  _T_315; // @[Mux.scala 46:19:@173.4]
  wire  _T_316; // @[Mux.scala 46:16:@174.4]
  wire  _T_317; // @[Mux.scala 46:19:@175.4]
  wire  saddrInvalid; // @[Mux.scala 46:16:@176.4]
  wire  isMotor1; // @[csr.scala 193:37:@177.4]
  wire  isMotor2; // @[csr.scala 194:37:@178.4]
  wire  isMotor3; // @[csr.scala 195:37:@179.4]
  wire  isSpi; // @[csr.scala 196:35:@180.4]
  wire  isUart; // @[csr.scala 197:36:@181.4]
  wire  isTimer; // @[csr.scala 198:36:@182.4]
  wire  isSoftware; // @[csr.scala 200:36:@184.4]
  wire  _T_378; // @[csr.scala 203:65:@215.4]
  wire  _T_379; // @[csr.scala 203:65:@216.4]
  wire  _T_380; // @[csr.scala 203:65:@217.4]
  wire  _T_381; // @[csr.scala 203:65:@218.4]
  wire  _T_382; // @[csr.scala 203:65:@219.4]
  wire  _T_383; // @[csr.scala 203:65:@220.4]
  wire  _T_384; // @[csr.scala 203:65:@221.4]
  wire  _T_385; // @[csr.scala 203:65:@222.4]
  wire  _T_386; // @[csr.scala 203:65:@223.4]
  wire  _T_387; // @[csr.scala 203:65:@224.4]
  wire  _T_388; // @[csr.scala 203:65:@225.4]
  wire  _T_389; // @[csr.scala 203:65:@226.4]
  wire  _T_390; // @[csr.scala 203:65:@227.4]
  wire  csrValid; // @[csr.scala 203:65:@228.4]
  wire [1:0] _T_391; // @[csr.scala 204:31:@229.4]
  wire [1:0] _T_392; // @[csr.scala 204:40:@230.4]
  wire  csrRO; // @[csr.scala 204:40:@231.4]
  wire  _T_394; // @[csr.scala 205:30:@232.4]
  wire  _T_395; // @[csr.scala 205:49:@233.4]
  wire  _T_397; // @[csr.scala 205:65:@234.4]
  wire  _T_398; // @[csr.scala 205:53:@235.4]
  wire  wen; // @[csr.scala 205:40:@236.4]
  wire [31:0] _T_400; // @[csr.scala 207:68:@237.4]
  wire [31:0] _T_401; // @[csr.scala 208:70:@238.4]
  wire [31:0] _T_402; // @[csr.scala 208:68:@239.4]
  wire  _T_403; // @[Mux.scala 46:19:@240.4]
  wire [31:0] _T_404; // @[Mux.scala 46:16:@241.4]
  wire  _T_405; // @[Mux.scala 46:19:@242.4]
  wire [31:0] _T_406; // @[Mux.scala 46:16:@243.4]
  wire  _T_407; // @[Mux.scala 46:19:@244.4]
  wire [31:0] wdata; // @[Mux.scala 46:16:@245.4]
  wire [29:0] _GEN_175; // @[csr.scala 214:50:@246.4]
  wire [30:0] _T_422; // @[csr.scala 214:50:@246.4]
  wire [29:0] _T_423; // @[csr.scala 214:50:@247.4]
  wire [29:0] _T_424; // @[csr.scala 215:22:@248.4]
  wire [29:0] _T_425; // @[csr.scala 214:22:@249.4]
  wire [29:0] _T_426; // @[csr.scala 213:22:@250.4]
  wire [29:0] _T_427; // @[csr.scala 212:22:@251.4]
  wire [29:0] causeExpt; // @[csr.scala 211:22:@252.4]
  wire [29:0] _T_428; // @[csr.scala 223:22:@253.4]
  wire [29:0] _T_429; // @[csr.scala 222:22:@254.4]
  wire [29:0] _T_430; // @[csr.scala 221:22:@255.4]
  wire [29:0] _T_431; // @[csr.scala 220:22:@256.4]
  wire [29:0] _T_432; // @[csr.scala 219:22:@257.4]
  wire [29:0] causeInt; // @[csr.scala 217:22:@259.4]
  wire  _T_434; // @[csr.scala 226:30:@260.4]
  wire  _T_435; // @[csr.scala 226:42:@261.4]
  wire  _T_436; // @[csr.scala 226:54:@262.4]
  wire  _T_437; // @[csr.scala 226:63:@263.4]
  wire  _T_438; // @[csr.scala 226:73:@264.4]
  wire  _T_440; // @[csr.scala 226:98:@266.4]
  wire  isInt; // @[csr.scala 226:113:@267.4]
  wire [29:0] cause; // @[csr.scala 227:23:@268.4]
  wire [29:0] _T_441; // @[csr.scala 230:26:@269.4]
  wire [31:0] _GEN_176; // @[csr.scala 230:31:@270.4]
  wire [31:0] base; // @[csr.scala 230:31:@270.4]
  wire [1:0] mode; // @[csr.scala 231:25:@271.4]
  wire  _T_442; // @[csr.scala 232:38:@272.4]
  wire  _T_443; // @[csr.scala 232:31:@273.4]
  wire [31:0] _GEN_177; // @[csr.scala 232:57:@274.4]
  wire [31:0] _T_444; // @[csr.scala 232:57:@274.4]
  wire [32:0] _T_445; // @[csr.scala 232:48:@275.4]
  wire [31:0] _T_446; // @[csr.scala 232:48:@276.4]
  wire  _T_448; // @[csr.scala 235:33:@279.4]
  wire  _T_449; // @[csr.scala 235:49:@280.4]
  wire  _T_450; // @[csr.scala 235:65:@281.4]
  wire [1:0] _T_451; // @[csr.scala 236:28:@282.4]
  wire  _T_453; // @[csr.scala 236:35:@283.4]
  wire  _T_455; // @[csr.scala 236:43:@284.4]
  wire  _T_457; // @[csr.scala 236:56:@285.4]
  wire  _T_458; // @[csr.scala 236:53:@286.4]
  wire  _T_459; // @[csr.scala 236:39:@287.4]
  wire  _T_460; // @[csr.scala 235:81:@288.4]
  wire  _T_461; // @[csr.scala 236:75:@289.4]
  wire  _T_462; // @[csr.scala 236:68:@290.4]
  wire  _T_465; // @[csr.scala 237:32:@292.4]
  wire  _T_466; // @[csr.scala 236:84:@293.4]
  wire  _T_467; // @[csr.scala 237:47:@294.4]
  wire  _T_468; // @[csr.scala 237:58:@295.4]
  wire [32:0] _T_471; // @[csr.scala 241:26:@299.4]
  wire [31:0] _T_472; // @[csr.scala 241:26:@300.4]
  wire [31:0] _T_473; // @[csr.scala 242:13:@302.4]
  wire  _T_475; // @[csr.scala 242:13:@303.4]
  wire [32:0] _T_477; // @[csr.scala 243:27:@305.6]
  wire [31:0] _T_478; // @[csr.scala 243:27:@306.6]
  wire [31:0] _GEN_8; // @[csr.scala 242:19:@304.4]
  wire [32:0] _T_480; // @[csr.scala 245:27:@309.4]
  wire [31:0] _T_481; // @[csr.scala 245:27:@310.4]
  wire [31:0] _T_482; // @[csr.scala 246:14:@312.4]
  wire  _T_484; // @[csr.scala 246:14:@313.4]
  wire [32:0] _T_486; // @[csr.scala 247:28:@315.6]
  wire [31:0] _T_487; // @[csr.scala 247:28:@316.6]
  wire [31:0] _GEN_9; // @[csr.scala 246:20:@314.4]
  wire  _T_489; // @[csr.scala 249:28:@319.4]
  wire  _T_491; // @[csr.scala 249:53:@320.4]
  wire  _T_492; // @[csr.scala 249:62:@321.4]
  wire  _T_493; // @[csr.scala 249:73:@322.4]
  wire  _T_494; // @[csr.scala 249:49:@323.4]
  wire  _T_496; // @[csr.scala 249:89:@324.4]
  wire  isInstRet; // @[csr.scala 249:86:@325.4]
  wire [32:0] _T_498; // @[csr.scala 252:29:@327.6]
  wire [31:0] _T_499; // @[csr.scala 252:29:@328.6]
  wire [31:0] _GEN_10; // @[csr.scala 251:19:@326.4]
  wire [31:0] _T_500; // @[csr.scala 254:29:@331.4]
  wire  _T_502; // @[csr.scala 254:29:@332.4]
  wire  _T_503; // @[csr.scala 254:18:@333.4]
  wire [32:0] _T_505; // @[csr.scala 255:30:@335.6]
  wire [31:0] _T_506; // @[csr.scala 255:30:@336.6]
  wire [31:0] _GEN_11; // @[csr.scala 254:35:@334.4]
  reg  wasEret; // @[csr.scala 259:28:@339.4]
  reg [31:0] _RAND_29;
  reg  br_taken; // @[csr.scala 263:30:@341.4]
  reg [31:0] _RAND_30;
  reg  br_taken_delayed; // @[csr.scala 264:30:@342.4]
  reg [31:0] _RAND_31;
  wire  _T_514; // @[csr.scala 273:12:@348.8]
  wire [32:0] _T_516; // @[csr.scala 274:54:@350.10]
  wire [32:0] _T_517; // @[csr.scala 274:54:@351.10]
  wire [31:0] _T_518; // @[csr.scala 274:54:@352.10]
  wire [31:0] _T_519; // @[csr.scala 274:29:@353.10]
  wire [29:0] _T_520; // @[csr.scala 274:69:@354.10]
  wire [31:0] _GEN_178; // @[csr.scala 274:74:@355.10]
  wire [31:0] _T_521; // @[csr.scala 274:74:@355.10]
  wire [31:0] _GEN_12; // @[csr.scala 274:7:@349.8]
  wire [31:0] _T_527; // @[Cat.scala 30:58:@360.8]
  wire  _T_529; // @[csr.scala 282:25:@366.8]
  wire  _T_530; // @[csr.scala 282:41:@367.8]
  wire [31:0] _GEN_13; // @[csr.scala 282:58:@368.8]
  wire  _T_532; // @[csr.scala 289:21:@381.12]
  wire [1:0] _T_533; // @[csr.scala 290:30:@383.14]
  wire  _T_534; // @[csr.scala 291:30:@385.14]
  wire [1:0] _T_535; // @[csr.scala 292:30:@387.14]
  wire  _T_536; // @[csr.scala 293:30:@389.14]
  wire  _T_537; // @[csr.scala 295:26:@393.14]
  wire  _T_538; // @[csr.scala 296:30:@395.16]
  wire  _T_539; // @[csr.scala 297:30:@397.16]
  wire  _T_540; // @[csr.scala 298:30:@399.16]
  wire  _T_541; // @[csr.scala 299:30:@401.16]
  wire  _T_542; // @[csr.scala 300:30:@403.16]
  wire  _T_545; // @[csr.scala 304:26:@411.16]
  wire  _T_553; // @[csr.scala 313:26:@429.18]
  wire  _T_554; // @[csr.scala 314:26:@434.20]
  wire  _T_555; // @[csr.scala 315:26:@439.22]
  wire [31:0] _T_557; // @[csr.scala 315:56:@441.24]
  wire [34:0] _GEN_179; // @[csr.scala 315:63:@442.24]
  wire [34:0] _T_559; // @[csr.scala 315:63:@442.24]
  wire  _T_560; // @[csr.scala 316:26:@446.24]
  wire [31:0] _T_562; // @[csr.scala 316:60:@448.26]
  wire  _T_563; // @[csr.scala 317:26:@452.26]
  wire [31:0] _GEN_14; // @[csr.scala 317:41:@453.26]
  wire [31:0] _GEN_15; // @[csr.scala 316:42:@447.24]
  wire [31:0] _GEN_16; // @[csr.scala 316:42:@447.24]
  wire [34:0] _GEN_17; // @[csr.scala 315:40:@440.22]
  wire [31:0] _GEN_18; // @[csr.scala 315:40:@440.22]
  wire [31:0] _GEN_19; // @[csr.scala 315:40:@440.22]
  wire [31:0] _GEN_20; // @[csr.scala 314:44:@435.20]
  wire [34:0] _GEN_21; // @[csr.scala 314:44:@435.20]
  wire [31:0] _GEN_22; // @[csr.scala 314:44:@435.20]
  wire [31:0] _GEN_23; // @[csr.scala 314:44:@435.20]
  wire [31:0] _GEN_24; // @[csr.scala 313:41:@430.18]
  wire [31:0] _GEN_25; // @[csr.scala 313:41:@430.18]
  wire [34:0] _GEN_26; // @[csr.scala 313:41:@430.18]
  wire [31:0] _GEN_27; // @[csr.scala 313:41:@430.18]
  wire [31:0] _GEN_28; // @[csr.scala 313:41:@430.18]
  wire  _GEN_29; // @[csr.scala 304:39:@412.16]
  wire  _GEN_30; // @[csr.scala 304:39:@412.16]
  wire  _GEN_31; // @[csr.scala 304:39:@412.16]
  wire  _GEN_32; // @[csr.scala 304:39:@412.16]
  wire  _GEN_33; // @[csr.scala 304:39:@412.16]
  wire  _GEN_34; // @[csr.scala 304:39:@412.16]
  wire  _GEN_35; // @[csr.scala 304:39:@412.16]
  wire [31:0] _GEN_36; // @[csr.scala 304:39:@412.16]
  wire [31:0] _GEN_37; // @[csr.scala 304:39:@412.16]
  wire [34:0] _GEN_38; // @[csr.scala 304:39:@412.16]
  wire [31:0] _GEN_39; // @[csr.scala 304:39:@412.16]
  wire [31:0] _GEN_40; // @[csr.scala 304:39:@412.16]
  wire  _GEN_46; // @[csr.scala 295:39:@394.14]
  wire  _GEN_47; // @[csr.scala 295:39:@394.14]
  wire  _GEN_48; // @[csr.scala 295:39:@394.14]
  wire  _GEN_49; // @[csr.scala 295:39:@394.14]
  wire  _GEN_50; // @[csr.scala 295:39:@394.14]
  wire  _GEN_51; // @[csr.scala 295:39:@394.14]
  wire  _GEN_52; // @[csr.scala 295:39:@394.14]
  wire  _GEN_53; // @[csr.scala 295:39:@394.14]
  wire  _GEN_54; // @[csr.scala 295:39:@394.14]
  wire [31:0] _GEN_55; // @[csr.scala 295:39:@394.14]
  wire [31:0] _GEN_56; // @[csr.scala 295:39:@394.14]
  wire [34:0] _GEN_57; // @[csr.scala 295:39:@394.14]
  wire [31:0] _GEN_58; // @[csr.scala 295:39:@394.14]
  wire [31:0] _GEN_59; // @[csr.scala 295:39:@394.14]
  wire [1:0] _GEN_60; // @[csr.scala 289:38:@382.12]
  wire  _GEN_61; // @[csr.scala 289:38:@382.12]
  wire [1:0] _GEN_62; // @[csr.scala 289:38:@382.12]
  wire  _GEN_63; // @[csr.scala 289:38:@382.12]
  wire  _GEN_69; // @[csr.scala 289:38:@382.12]
  wire  _GEN_70; // @[csr.scala 289:38:@382.12]
  wire  _GEN_71; // @[csr.scala 289:38:@382.12]
  wire  _GEN_72; // @[csr.scala 289:38:@382.12]
  wire  _GEN_73; // @[csr.scala 289:38:@382.12]
  wire  _GEN_74; // @[csr.scala 289:38:@382.12]
  wire  _GEN_75; // @[csr.scala 289:38:@382.12]
  wire  _GEN_76; // @[csr.scala 289:38:@382.12]
  wire  _GEN_77; // @[csr.scala 289:38:@382.12]
  wire [31:0] _GEN_78; // @[csr.scala 289:38:@382.12]
  wire [31:0] _GEN_79; // @[csr.scala 289:38:@382.12]
  wire [34:0] _GEN_80; // @[csr.scala 289:38:@382.12]
  wire [31:0] _GEN_81; // @[csr.scala 289:38:@382.12]
  wire [31:0] _GEN_82; // @[csr.scala 289:38:@382.12]
  wire [1:0] _GEN_83; // @[csr.scala 288:21:@380.10]
  wire  _GEN_84; // @[csr.scala 288:21:@380.10]
  wire [1:0] _GEN_85; // @[csr.scala 288:21:@380.10]
  wire  _GEN_86; // @[csr.scala 288:21:@380.10]
  wire  _GEN_92; // @[csr.scala 288:21:@380.10]
  wire  _GEN_93; // @[csr.scala 288:21:@380.10]
  wire  _GEN_94; // @[csr.scala 288:21:@380.10]
  wire  _GEN_95; // @[csr.scala 288:21:@380.10]
  wire  _GEN_96; // @[csr.scala 288:21:@380.10]
  wire  _GEN_97; // @[csr.scala 288:21:@380.10]
  wire  _GEN_98; // @[csr.scala 288:21:@380.10]
  wire  _GEN_99; // @[csr.scala 288:21:@380.10]
  wire  _GEN_100; // @[csr.scala 288:21:@380.10]
  wire [31:0] _GEN_101; // @[csr.scala 288:21:@380.10]
  wire [31:0] _GEN_102; // @[csr.scala 288:21:@380.10]
  wire [34:0] _GEN_103; // @[csr.scala 288:21:@380.10]
  wire [31:0] _GEN_104; // @[csr.scala 288:21:@380.10]
  wire [31:0] _GEN_105; // @[csr.scala 288:21:@380.10]
  wire [1:0] _GEN_106; // @[csr.scala 283:24:@373.8]
  wire  _GEN_107; // @[csr.scala 283:24:@373.8]
  wire [1:0] _GEN_108; // @[csr.scala 283:24:@373.8]
  wire  _GEN_109; // @[csr.scala 283:24:@373.8]
  wire  _GEN_115; // @[csr.scala 283:24:@373.8]
  wire  _GEN_116; // @[csr.scala 283:24:@373.8]
  wire  _GEN_117; // @[csr.scala 283:24:@373.8]
  wire  _GEN_118; // @[csr.scala 283:24:@373.8]
  wire  _GEN_119; // @[csr.scala 283:24:@373.8]
  wire  _GEN_120; // @[csr.scala 283:24:@373.8]
  wire  _GEN_121; // @[csr.scala 283:24:@373.8]
  wire  _GEN_122; // @[csr.scala 283:24:@373.8]
  wire  _GEN_123; // @[csr.scala 283:24:@373.8]
  wire [31:0] _GEN_124; // @[csr.scala 283:24:@373.8]
  wire [31:0] _GEN_125; // @[csr.scala 283:24:@373.8]
  wire [34:0] _GEN_126; // @[csr.scala 283:24:@373.8]
  wire [31:0] _GEN_127; // @[csr.scala 283:24:@373.8]
  wire [31:0] _GEN_128; // @[csr.scala 283:24:@373.8]
  wire [34:0] _GEN_129; // @[csr.scala 269:19:@347.6]
  wire [31:0] _GEN_130; // @[csr.scala 269:19:@347.6]
  wire [1:0] _GEN_131; // @[csr.scala 269:19:@347.6]
  wire  _GEN_132; // @[csr.scala 269:19:@347.6]
  wire [1:0] _GEN_133; // @[csr.scala 269:19:@347.6]
  wire  _GEN_134; // @[csr.scala 269:19:@347.6]
  wire [31:0] _GEN_135; // @[csr.scala 269:19:@347.6]
  wire  _GEN_141; // @[csr.scala 269:19:@347.6]
  wire  _GEN_142; // @[csr.scala 269:19:@347.6]
  wire  _GEN_143; // @[csr.scala 269:19:@347.6]
  wire  _GEN_144; // @[csr.scala 269:19:@347.6]
  wire  _GEN_145; // @[csr.scala 269:19:@347.6]
  wire  _GEN_146; // @[csr.scala 269:19:@347.6]
  wire  _GEN_147; // @[csr.scala 269:19:@347.6]
  wire  _GEN_148; // @[csr.scala 269:19:@347.6]
  wire  _GEN_149; // @[csr.scala 269:19:@347.6]
  wire [31:0] _GEN_150; // @[csr.scala 269:19:@347.6]
  wire [31:0] _GEN_151; // @[csr.scala 269:19:@347.6]
  wire [34:0] _GEN_152; // @[csr.scala 268:20:@346.4]
  wire  _GEN_159; // @[csr.scala 268:20:@346.4]
  wire  _GEN_160; // @[csr.scala 268:20:@346.4]
  wire  _GEN_161; // @[csr.scala 268:20:@346.4]
  wire  _GEN_162; // @[csr.scala 268:20:@346.4]
  wire  _GEN_163; // @[csr.scala 268:20:@346.4]
  wire  _GEN_164; // @[csr.scala 268:20:@346.4]
  wire  _GEN_165; // @[csr.scala 268:20:@346.4]
  wire [31:0] _GEN_173; // @[csr.scala 268:20:@346.4]
  assign csr_addr = io_inst[31:20]; // @[csr.scala 108:27:@8.4]
  assign rs1_addr = io_inst[19:15]; // @[csr.scala 109:27:@9.4]
  assign _GEN_0 = reset ? 1'h0 : mie_motor3ie; // @[csr.scala 148:3:@26.4]
  assign _GEN_1 = reset ? 1'h0 : mie_motor2ie; // @[csr.scala 148:3:@26.4]
  assign _GEN_2 = reset ? 1'h0 : mie_motor1ie; // @[csr.scala 148:3:@26.4]
  assign _GEN_3 = reset ? 1'h0 : mie_spiie; // @[csr.scala 148:3:@26.4]
  assign _GEN_4 = reset ? 1'h1 : mie_uartie; // @[csr.scala 148:3:@26.4]
  assign _GEN_5 = reset ? 1'h1 : mstatus_mie; // @[csr.scala 148:3:@26.4]
  assign _GEN_6 = reset ? 2'h3 : mstatus_prv; // @[csr.scala 148:3:@26.4]
  assign _GEN_7 = reset ? 2'h3 : mstatus_mpp; // @[csr.scala 148:3:@26.4]
  assign _T_154 = {1'h0,mie_mtie,1'h0,2'h0,mie_msie,1'h0,2'h0}; // @[csr.scala 168:34:@43.4]
  assign _T_164 = {11'h0,mie_motor3ie,mie_motor2ie,mie_motor1ie,mie_spiie,mie_uartie,4'h0,1'h0,2'h0,_T_154}; // @[csr.scala 168:34:@53.4]
  assign _T_172 = {1'h0,mip_mtip,1'h0,2'h0,mip_msip,1'h0,2'h0}; // @[csr.scala 173:34:@61.4]
  assign _T_182 = {11'h0,mip_motor1ip,mip_motor2ip,mip_motor3ip,mip_spiip,mip_uartip,4'h0,1'h0,2'h0,_T_172}; // @[csr.scala 173:34:@71.4]
  assign _T_192 = {mstatus_mpp,2'h0,1'h0,mstatus_mpie,1'h0,1'h0,1'h0,mstatus_mie,1'h0,2'h0}; // @[csr.scala 174:38:@81.4]
  assign _T_203 = {7'h0,mstatus_prv,3'h0,7'h0,_T_192}; // @[csr.scala 174:38:@92.4]
  assign _T_208 = 12'hc00 == csr_addr; // @[Lookup.scala 9:38:@94.4]
  assign _T_212 = 12'hc01 == csr_addr; // @[Lookup.scala 9:38:@96.4]
  assign _T_216 = 12'hc02 == csr_addr; // @[Lookup.scala 9:38:@98.4]
  assign _T_220 = 12'hc80 == csr_addr; // @[Lookup.scala 9:38:@100.4]
  assign _T_224 = 12'hc81 == csr_addr; // @[Lookup.scala 9:38:@102.4]
  assign _T_228 = 12'hc82 == csr_addr; // @[Lookup.scala 9:38:@104.4]
  assign _T_232 = 12'h305 == csr_addr; // @[Lookup.scala 9:38:@106.4]
  assign _T_236 = 12'h304 == csr_addr; // @[Lookup.scala 9:38:@108.4]
  assign _T_240 = 12'h340 == csr_addr; // @[Lookup.scala 9:38:@110.4]
  assign _T_244 = 12'h341 == csr_addr; // @[Lookup.scala 9:38:@112.4]
  assign _T_248 = 12'h342 == csr_addr; // @[Lookup.scala 9:38:@114.4]
  assign _T_252 = 12'h343 == csr_addr; // @[Lookup.scala 9:38:@116.4]
  assign _T_256 = 12'h344 == csr_addr; // @[Lookup.scala 9:38:@118.4]
  assign _T_260 = 12'h300 == csr_addr; // @[Lookup.scala 9:38:@120.4]
  assign _T_264 = 12'h301 == csr_addr; // @[Lookup.scala 9:38:@122.4]
  assign _T_265 = _T_264 ? 32'h40000100 : 32'h0; // @[Lookup.scala 11:37:@123.4]
  assign _T_266 = _T_260 ? _T_203 : _T_265; // @[Lookup.scala 11:37:@124.4]
  assign _T_267 = _T_256 ? _T_182 : _T_266; // @[Lookup.scala 11:37:@125.4]
  assign _T_268 = _T_252 ? mtval : _T_267; // @[Lookup.scala 11:37:@126.4]
  assign _T_269 = _T_248 ? mcause : _T_268; // @[Lookup.scala 11:37:@127.4]
  assign _T_270 = _T_244 ? mepc : _T_269; // @[Lookup.scala 11:37:@128.4]
  assign _T_271 = _T_240 ? mscratch : _T_270; // @[Lookup.scala 11:37:@129.4]
  assign _T_272 = _T_236 ? _T_164 : _T_271; // @[Lookup.scala 11:37:@130.4]
  assign _T_273 = _T_232 ? mtvec : _T_272; // @[Lookup.scala 11:37:@131.4]
  assign _T_274 = _T_228 ? instreth : _T_273; // @[Lookup.scala 11:37:@132.4]
  assign _T_275 = _T_224 ? timeh : _T_274; // @[Lookup.scala 11:37:@133.4]
  assign _T_276 = _T_220 ? cycleh : _T_275; // @[Lookup.scala 11:37:@134.4]
  assign _T_277 = _T_216 ? instret : _T_276; // @[Lookup.scala 11:37:@135.4]
  assign _T_278 = _T_212 ? time$ : _T_277; // @[Lookup.scala 11:37:@136.4]
  assign _T_280 = csr_addr[9:8]; // @[csr.scala 182:31:@139.4]
  assign privValid = _T_280 <= mstatus_prv; // @[csr.scala 182:38:@140.4]
  assign privInst = io_cmd == 3'h4; // @[csr.scala 183:30:@141.4]
  assign _T_281 = csr_addr[0]; // @[csr.scala 184:44:@142.4]
  assign _T_283 = _T_281 == 1'h0; // @[csr.scala 184:35:@143.4]
  assign _T_284 = privInst & _T_283; // @[csr.scala 184:32:@144.4]
  assign _T_285 = csr_addr[8]; // @[csr.scala 184:60:@145.4]
  assign _T_287 = _T_285 == 1'h0; // @[csr.scala 184:51:@146.4]
  assign isEcall = _T_284 & _T_287; // @[csr.scala 184:48:@147.4]
  assign _T_289 = privInst & _T_281; // @[csr.scala 185:32:@149.4]
  assign isEbreak = _T_289 & _T_287; // @[csr.scala 185:48:@152.4]
  assign isEret = _T_284 & _T_285; // @[csr.scala 186:48:@157.4]
  assign _T_298 = io_addr[1]; // @[csr.scala 187:45:@158.4]
  assign iaddrInvalid = io_pc_check & _T_298; // @[csr.scala 187:35:@159.4]
  assign _T_300 = io_addr[1:0]; // @[csr.scala 189:49:@160.4]
  assign _T_302 = _T_300 != 2'h0; // @[csr.scala 189:56:@161.4]
  assign _T_303 = io_addr[0]; // @[csr.scala 189:77:@162.4]
  assign _T_305 = 3'h4 == io_ld_type; // @[Mux.scala 46:19:@164.4]
  assign _T_306 = _T_305 ? _T_303 : 1'h0; // @[Mux.scala 46:16:@165.4]
  assign _T_307 = 3'h2 == io_ld_type; // @[Mux.scala 46:19:@166.4]
  assign _T_308 = _T_307 ? _T_303 : _T_306; // @[Mux.scala 46:16:@167.4]
  assign _T_309 = 3'h1 == io_ld_type; // @[Mux.scala 46:19:@168.4]
  assign laddrInvalid = _T_309 ? _T_302 : _T_308; // @[Mux.scala 46:16:@169.4]
  assign _T_315 = 2'h2 == io_st_type; // @[Mux.scala 46:19:@173.4]
  assign _T_316 = _T_315 ? _T_303 : 1'h0; // @[Mux.scala 46:16:@174.4]
  assign _T_317 = 2'h1 == io_st_type; // @[Mux.scala 46:19:@175.4]
  assign saddrInvalid = _T_317 ? _T_302 : _T_316; // @[Mux.scala 46:16:@176.4]
  assign isMotor1 = mip_motor1ip & mie_motor1ie; // @[csr.scala 193:37:@177.4]
  assign isMotor2 = mip_motor2ip & mie_motor2ie; // @[csr.scala 194:37:@178.4]
  assign isMotor3 = mip_motor3ip & mie_motor3ie; // @[csr.scala 195:37:@179.4]
  assign isSpi = mip_spiip & mie_spiie; // @[csr.scala 196:35:@180.4]
  assign isUart = mip_uartip & mie_uartie; // @[csr.scala 197:36:@181.4]
  assign isTimer = mip_mtip & mie_mtie; // @[csr.scala 198:36:@182.4]
  assign isSoftware = mip_msip & mie_msie; // @[csr.scala 200:36:@184.4]
  assign _T_378 = _T_208 | _T_212; // @[csr.scala 203:65:@215.4]
  assign _T_379 = _T_378 | _T_216; // @[csr.scala 203:65:@216.4]
  assign _T_380 = _T_379 | _T_220; // @[csr.scala 203:65:@217.4]
  assign _T_381 = _T_380 | _T_224; // @[csr.scala 203:65:@218.4]
  assign _T_382 = _T_381 | _T_228; // @[csr.scala 203:65:@219.4]
  assign _T_383 = _T_382 | _T_232; // @[csr.scala 203:65:@220.4]
  assign _T_384 = _T_383 | _T_236; // @[csr.scala 203:65:@221.4]
  assign _T_385 = _T_384 | _T_240; // @[csr.scala 203:65:@222.4]
  assign _T_386 = _T_385 | _T_244; // @[csr.scala 203:65:@223.4]
  assign _T_387 = _T_386 | _T_248; // @[csr.scala 203:65:@224.4]
  assign _T_388 = _T_387 | _T_252; // @[csr.scala 203:65:@225.4]
  assign _T_389 = _T_388 | _T_256; // @[csr.scala 203:65:@226.4]
  assign _T_390 = _T_389 | _T_260; // @[csr.scala 203:65:@227.4]
  assign csrValid = _T_390 | _T_264; // @[csr.scala 203:65:@228.4]
  assign _T_391 = csr_addr[11:10]; // @[csr.scala 204:31:@229.4]
  assign _T_392 = ~ _T_391; // @[csr.scala 204:40:@230.4]
  assign csrRO = _T_392 == 2'h0; // @[csr.scala 204:40:@231.4]
  assign _T_394 = io_cmd == 3'h1; // @[csr.scala 205:30:@232.4]
  assign _T_395 = io_cmd[1]; // @[csr.scala 205:49:@233.4]
  assign _T_397 = rs1_addr != 5'h0; // @[csr.scala 205:65:@234.4]
  assign _T_398 = _T_395 & _T_397; // @[csr.scala 205:53:@235.4]
  assign wen = _T_394 | _T_398; // @[csr.scala 205:40:@236.4]
  assign _T_400 = io_out | io_in; // @[csr.scala 207:68:@237.4]
  assign _T_401 = ~ io_in; // @[csr.scala 208:70:@238.4]
  assign _T_402 = io_out & _T_401; // @[csr.scala 208:68:@239.4]
  assign _T_403 = 3'h3 == io_cmd; // @[Mux.scala 46:19:@240.4]
  assign _T_404 = _T_403 ? _T_402 : 32'h0; // @[Mux.scala 46:16:@241.4]
  assign _T_405 = 3'h2 == io_cmd; // @[Mux.scala 46:19:@242.4]
  assign _T_406 = _T_405 ? _T_400 : _T_404; // @[Mux.scala 46:16:@243.4]
  assign _T_407 = 3'h1 == io_cmd; // @[Mux.scala 46:19:@244.4]
  assign wdata = _T_407 ? io_in : _T_406; // @[Mux.scala 46:16:@245.4]
  assign _GEN_175 = {{28'd0}, mstatus_prv}; // @[csr.scala 214:50:@246.4]
  assign _T_422 = 30'h8 + _GEN_175; // @[csr.scala 214:50:@246.4]
  assign _T_423 = 30'h8 + _GEN_175; // @[csr.scala 214:50:@247.4]
  assign _T_424 = isEbreak ? 30'h3 : 30'h2; // @[csr.scala 215:22:@248.4]
  assign _T_425 = isEcall ? _T_423 : _T_424; // @[csr.scala 214:22:@249.4]
  assign _T_426 = saddrInvalid ? 30'h6 : _T_425; // @[csr.scala 213:22:@250.4]
  assign _T_427 = laddrInvalid ? 30'h4 : _T_426; // @[csr.scala 212:22:@251.4]
  assign causeExpt = iaddrInvalid ? 30'h0 : _T_427; // @[csr.scala 211:22:@252.4]
  assign _T_428 = isMotor2 ? 30'h13 : 30'h14; // @[csr.scala 223:22:@253.4]
  assign _T_429 = isMotor1 ? 30'h12 : _T_428; // @[csr.scala 222:22:@254.4]
  assign _T_430 = isSpi ? 30'h11 : _T_429; // @[csr.scala 221:22:@255.4]
  assign _T_431 = isUart ? 30'h10 : _T_430; // @[csr.scala 220:22:@256.4]
  assign _T_432 = isTimer ? 30'h7 : _T_431; // @[csr.scala 219:22:@257.4]
  assign causeInt = isSoftware ? 30'h3 : _T_432; // @[csr.scala 217:22:@259.4]
  assign _T_434 = isMotor1 | isMotor2; // @[csr.scala 226:30:@260.4]
  assign _T_435 = _T_434 | isMotor3; // @[csr.scala 226:42:@261.4]
  assign _T_436 = _T_435 | isSpi; // @[csr.scala 226:54:@262.4]
  assign _T_437 = _T_436 | isUart; // @[csr.scala 226:63:@263.4]
  assign _T_438 = _T_437 | isTimer; // @[csr.scala 226:73:@264.4]
  assign _T_440 = _T_438 | isSoftware; // @[csr.scala 226:98:@266.4]
  assign isInt = _T_440 & mstatus_mie; // @[csr.scala 226:113:@267.4]
  assign cause = isInt ? causeInt : causeExpt; // @[csr.scala 227:23:@268.4]
  assign _T_441 = mtvec[31:2]; // @[csr.scala 230:26:@269.4]
  assign _GEN_176 = {{2'd0}, _T_441}; // @[csr.scala 230:31:@270.4]
  assign base = _GEN_176 << 2; // @[csr.scala 230:31:@270.4]
  assign mode = mtvec[1:0]; // @[csr.scala 231:25:@271.4]
  assign _T_442 = mode[0]; // @[csr.scala 232:38:@272.4]
  assign _T_443 = isInt & _T_442; // @[csr.scala 232:31:@273.4]
  assign _GEN_177 = {{2'd0}, cause}; // @[csr.scala 232:57:@274.4]
  assign _T_444 = _GEN_177 << 2; // @[csr.scala 232:57:@274.4]
  assign _T_445 = base + _T_444; // @[csr.scala 232:48:@275.4]
  assign _T_446 = base + _T_444; // @[csr.scala 232:48:@276.4]
  assign _T_448 = io_illegal | iaddrInvalid; // @[csr.scala 235:33:@279.4]
  assign _T_449 = _T_448 | laddrInvalid; // @[csr.scala 235:49:@280.4]
  assign _T_450 = _T_449 | saddrInvalid; // @[csr.scala 235:65:@281.4]
  assign _T_451 = io_cmd[1:0]; // @[csr.scala 236:28:@282.4]
  assign _T_453 = _T_451 != 2'h0; // @[csr.scala 236:35:@283.4]
  assign _T_455 = csrValid == 1'h0; // @[csr.scala 236:43:@284.4]
  assign _T_457 = privValid == 1'h0; // @[csr.scala 236:56:@285.4]
  assign _T_458 = _T_455 | _T_457; // @[csr.scala 236:53:@286.4]
  assign _T_459 = _T_453 & _T_458; // @[csr.scala 236:39:@287.4]
  assign _T_460 = _T_450 | _T_459; // @[csr.scala 235:81:@288.4]
  assign _T_461 = wen & csrRO; // @[csr.scala 236:75:@289.4]
  assign _T_462 = _T_460 | _T_461; // @[csr.scala 236:68:@290.4]
  assign _T_465 = privInst & _T_457; // @[csr.scala 237:32:@292.4]
  assign _T_466 = _T_462 | _T_465; // @[csr.scala 236:84:@293.4]
  assign _T_467 = _T_466 | isEcall; // @[csr.scala 237:47:@294.4]
  assign _T_468 = _T_467 | isEbreak; // @[csr.scala 237:58:@295.4]
  assign _T_471 = time$ + 32'h1; // @[csr.scala 241:26:@299.4]
  assign _T_472 = time$ + 32'h1; // @[csr.scala 241:26:@300.4]
  assign _T_473 = ~ time$; // @[csr.scala 242:13:@302.4]
  assign _T_475 = _T_473 == 32'h0; // @[csr.scala 242:13:@303.4]
  assign _T_477 = timeh + 32'h1; // @[csr.scala 243:27:@305.6]
  assign _T_478 = timeh + 32'h1; // @[csr.scala 243:27:@306.6]
  assign _GEN_8 = _T_475 ? _T_478 : timeh; // @[csr.scala 242:19:@304.4]
  assign _T_480 = cycle + 32'h1; // @[csr.scala 245:27:@309.4]
  assign _T_481 = cycle + 32'h1; // @[csr.scala 245:27:@310.4]
  assign _T_482 = ~ cycle; // @[csr.scala 246:14:@312.4]
  assign _T_484 = _T_482 == 32'h0; // @[csr.scala 246:14:@313.4]
  assign _T_486 = cycleh + 32'h1; // @[csr.scala 247:28:@315.6]
  assign _T_487 = cycleh + 32'h1; // @[csr.scala 247:28:@316.6]
  assign _GEN_9 = _T_484 ? _T_487 : cycleh; // @[csr.scala 246:20:@314.4]
  assign _T_489 = io_inst != 32'h13; // @[csr.scala 249:28:@319.4]
  assign _T_491 = io_expt == 1'h0; // @[csr.scala 249:53:@320.4]
  assign _T_492 = _T_491 | isEcall; // @[csr.scala 249:62:@321.4]
  assign _T_493 = _T_492 | isEbreak; // @[csr.scala 249:73:@322.4]
  assign _T_494 = _T_489 & _T_493; // @[csr.scala 249:49:@323.4]
  assign _T_496 = io_stall == 1'h0; // @[csr.scala 249:89:@324.4]
  assign isInstRet = _T_494 & _T_496; // @[csr.scala 249:86:@325.4]
  assign _T_498 = instret + 32'h1; // @[csr.scala 252:29:@327.6]
  assign _T_499 = instret + 32'h1; // @[csr.scala 252:29:@328.6]
  assign _GEN_10 = isInstRet ? _T_499 : instret; // @[csr.scala 251:19:@326.4]
  assign _T_500 = ~ instret; // @[csr.scala 254:29:@331.4]
  assign _T_502 = _T_500 == 32'h0; // @[csr.scala 254:29:@332.4]
  assign _T_503 = isInstRet & _T_502; // @[csr.scala 254:18:@333.4]
  assign _T_505 = instreth + 32'h1; // @[csr.scala 255:30:@335.6]
  assign _T_506 = instreth + 32'h1; // @[csr.scala 255:30:@336.6]
  assign _GEN_11 = _T_503 ? _T_506 : instreth; // @[csr.scala 254:35:@334.4]
  assign _T_514 = wasEret == 1'h0; // @[csr.scala 273:12:@348.8]
  assign _T_516 = io_pc - 32'h4; // @[csr.scala 274:54:@350.10]
  assign _T_517 = $unsigned(_T_516); // @[csr.scala 274:54:@351.10]
  assign _T_518 = _T_517[31:0]; // @[csr.scala 274:54:@352.10]
  assign _T_519 = br_taken_delayed ? _T_518 : io_pc; // @[csr.scala 274:29:@353.10]
  assign _T_520 = _T_519[31:2]; // @[csr.scala 274:69:@354.10]
  assign _GEN_178 = {{2'd0}, _T_520}; // @[csr.scala 274:74:@355.10]
  assign _T_521 = _GEN_178 << 2; // @[csr.scala 274:74:@355.10]
  assign _GEN_12 = _T_514 ? _T_521 : mepc; // @[csr.scala 274:7:@349.8]
  assign _T_527 = {isInt,1'h0,cause}; // @[Cat.scala 30:58:@360.8]
  assign _T_529 = iaddrInvalid | laddrInvalid; // @[csr.scala 282:25:@366.8]
  assign _T_530 = _T_529 | saddrInvalid; // @[csr.scala 282:41:@367.8]
  assign _GEN_13 = _T_530 ? io_addr : mtval; // @[csr.scala 282:58:@368.8]
  assign _T_532 = csr_addr == 12'h300; // @[csr.scala 289:21:@381.12]
  assign _T_533 = wdata[12:11]; // @[csr.scala 290:30:@383.14]
  assign _T_534 = wdata[7]; // @[csr.scala 291:30:@385.14]
  assign _T_535 = wdata[24:23]; // @[csr.scala 292:30:@387.14]
  assign _T_536 = wdata[3]; // @[csr.scala 293:30:@389.14]
  assign _T_537 = csr_addr == 12'h344; // @[csr.scala 295:26:@393.14]
  assign _T_538 = wdata[20]; // @[csr.scala 296:30:@395.16]
  assign _T_539 = wdata[19]; // @[csr.scala 297:30:@397.16]
  assign _T_540 = wdata[18]; // @[csr.scala 298:30:@399.16]
  assign _T_541 = wdata[17]; // @[csr.scala 299:30:@401.16]
  assign _T_542 = wdata[16]; // @[csr.scala 300:30:@403.16]
  assign _T_545 = csr_addr == 12'h304; // @[csr.scala 304:26:@411.16]
  assign _T_553 = csr_addr == 12'h305; // @[csr.scala 313:26:@429.18]
  assign _T_554 = csr_addr == 12'h340; // @[csr.scala 314:26:@434.20]
  assign _T_555 = csr_addr == 12'h341; // @[csr.scala 315:26:@439.22]
  assign _T_557 = wdata >> 2'h2; // @[csr.scala 315:56:@441.24]
  assign _GEN_179 = {{3'd0}, _T_557}; // @[csr.scala 315:63:@442.24]
  assign _T_559 = _GEN_179 << 2'h2; // @[csr.scala 315:63:@442.24]
  assign _T_560 = csr_addr == 12'h342; // @[csr.scala 316:26:@446.24]
  assign _T_562 = wdata & 32'h8000000f; // @[csr.scala 316:60:@448.26]
  assign _T_563 = csr_addr == 12'h343; // @[csr.scala 317:26:@452.26]
  assign _GEN_14 = _T_563 ? wdata : mtval; // @[csr.scala 317:41:@453.26]
  assign _GEN_15 = _T_560 ? _T_562 : mcause; // @[csr.scala 316:42:@447.24]
  assign _GEN_16 = _T_560 ? mtval : _GEN_14; // @[csr.scala 316:42:@447.24]
  assign _GEN_17 = _T_555 ? _T_559 : {{3'd0}, mepc}; // @[csr.scala 315:40:@440.22]
  assign _GEN_18 = _T_555 ? mcause : _GEN_15; // @[csr.scala 315:40:@440.22]
  assign _GEN_19 = _T_555 ? mtval : _GEN_16; // @[csr.scala 315:40:@440.22]
  assign _GEN_20 = _T_554 ? wdata : mscratch; // @[csr.scala 314:44:@435.20]
  assign _GEN_21 = _T_554 ? {{3'd0}, mepc} : _GEN_17; // @[csr.scala 314:44:@435.20]
  assign _GEN_22 = _T_554 ? mcause : _GEN_18; // @[csr.scala 314:44:@435.20]
  assign _GEN_23 = _T_554 ? mtval : _GEN_19; // @[csr.scala 314:44:@435.20]
  assign _GEN_24 = _T_553 ? wdata : mtvec; // @[csr.scala 313:41:@430.18]
  assign _GEN_25 = _T_553 ? mscratch : _GEN_20; // @[csr.scala 313:41:@430.18]
  assign _GEN_26 = _T_553 ? {{3'd0}, mepc} : _GEN_21; // @[csr.scala 313:41:@430.18]
  assign _GEN_27 = _T_553 ? mcause : _GEN_22; // @[csr.scala 313:41:@430.18]
  assign _GEN_28 = _T_553 ? mtval : _GEN_23; // @[csr.scala 313:41:@430.18]
  assign _GEN_29 = _T_545 ? _T_538 : _GEN_0; // @[csr.scala 304:39:@412.16]
  assign _GEN_30 = _T_545 ? _T_539 : _GEN_1; // @[csr.scala 304:39:@412.16]
  assign _GEN_31 = _T_545 ? _T_540 : _GEN_2; // @[csr.scala 304:39:@412.16]
  assign _GEN_32 = _T_545 ? _T_541 : _GEN_3; // @[csr.scala 304:39:@412.16]
  assign _GEN_33 = _T_545 ? _T_542 : _GEN_4; // @[csr.scala 304:39:@412.16]
  assign _GEN_34 = _T_545 ? _T_534 : mie_mtie; // @[csr.scala 304:39:@412.16]
  assign _GEN_35 = _T_545 ? _T_536 : mie_msie; // @[csr.scala 304:39:@412.16]
  assign _GEN_36 = _T_545 ? mtvec : _GEN_24; // @[csr.scala 304:39:@412.16]
  assign _GEN_37 = _T_545 ? mscratch : _GEN_25; // @[csr.scala 304:39:@412.16]
  assign _GEN_38 = _T_545 ? {{3'd0}, mepc} : _GEN_26; // @[csr.scala 304:39:@412.16]
  assign _GEN_39 = _T_545 ? mcause : _GEN_27; // @[csr.scala 304:39:@412.16]
  assign _GEN_40 = _T_545 ? mtval : _GEN_28; // @[csr.scala 304:39:@412.16]
  assign _GEN_46 = _T_537 ? _T_534 : mip_mtip; // @[csr.scala 295:39:@394.14]
  assign _GEN_47 = _T_537 ? _T_536 : mip_msip; // @[csr.scala 295:39:@394.14]
  assign _GEN_48 = _T_537 ? _GEN_0 : _GEN_29; // @[csr.scala 295:39:@394.14]
  assign _GEN_49 = _T_537 ? _GEN_1 : _GEN_30; // @[csr.scala 295:39:@394.14]
  assign _GEN_50 = _T_537 ? _GEN_2 : _GEN_31; // @[csr.scala 295:39:@394.14]
  assign _GEN_51 = _T_537 ? _GEN_3 : _GEN_32; // @[csr.scala 295:39:@394.14]
  assign _GEN_52 = _T_537 ? _GEN_4 : _GEN_33; // @[csr.scala 295:39:@394.14]
  assign _GEN_53 = _T_537 ? mie_mtie : _GEN_34; // @[csr.scala 295:39:@394.14]
  assign _GEN_54 = _T_537 ? mie_msie : _GEN_35; // @[csr.scala 295:39:@394.14]
  assign _GEN_55 = _T_537 ? mtvec : _GEN_36; // @[csr.scala 295:39:@394.14]
  assign _GEN_56 = _T_537 ? mscratch : _GEN_37; // @[csr.scala 295:39:@394.14]
  assign _GEN_57 = _T_537 ? {{3'd0}, mepc} : _GEN_38; // @[csr.scala 295:39:@394.14]
  assign _GEN_58 = _T_537 ? mcause : _GEN_39; // @[csr.scala 295:39:@394.14]
  assign _GEN_59 = _T_537 ? mtval : _GEN_40; // @[csr.scala 295:39:@394.14]
  assign _GEN_60 = _T_532 ? _T_533 : _GEN_7; // @[csr.scala 289:38:@382.12]
  assign _GEN_61 = _T_532 ? _T_534 : mstatus_mpie; // @[csr.scala 289:38:@382.12]
  assign _GEN_62 = _T_532 ? _T_535 : _GEN_6; // @[csr.scala 289:38:@382.12]
  assign _GEN_63 = _T_532 ? _T_536 : _GEN_5; // @[csr.scala 289:38:@382.12]
  assign _GEN_69 = _T_532 ? mip_mtip : _GEN_46; // @[csr.scala 289:38:@382.12]
  assign _GEN_70 = _T_532 ? mip_msip : _GEN_47; // @[csr.scala 289:38:@382.12]
  assign _GEN_71 = _T_532 ? _GEN_0 : _GEN_48; // @[csr.scala 289:38:@382.12]
  assign _GEN_72 = _T_532 ? _GEN_1 : _GEN_49; // @[csr.scala 289:38:@382.12]
  assign _GEN_73 = _T_532 ? _GEN_2 : _GEN_50; // @[csr.scala 289:38:@382.12]
  assign _GEN_74 = _T_532 ? _GEN_3 : _GEN_51; // @[csr.scala 289:38:@382.12]
  assign _GEN_75 = _T_532 ? _GEN_4 : _GEN_52; // @[csr.scala 289:38:@382.12]
  assign _GEN_76 = _T_532 ? mie_mtie : _GEN_53; // @[csr.scala 289:38:@382.12]
  assign _GEN_77 = _T_532 ? mie_msie : _GEN_54; // @[csr.scala 289:38:@382.12]
  assign _GEN_78 = _T_532 ? mtvec : _GEN_55; // @[csr.scala 289:38:@382.12]
  assign _GEN_79 = _T_532 ? mscratch : _GEN_56; // @[csr.scala 289:38:@382.12]
  assign _GEN_80 = _T_532 ? {{3'd0}, mepc} : _GEN_57; // @[csr.scala 289:38:@382.12]
  assign _GEN_81 = _T_532 ? mcause : _GEN_58; // @[csr.scala 289:38:@382.12]
  assign _GEN_82 = _T_532 ? mtval : _GEN_59; // @[csr.scala 289:38:@382.12]
  assign _GEN_83 = wen ? _GEN_60 : _GEN_7; // @[csr.scala 288:21:@380.10]
  assign _GEN_84 = wen ? _GEN_61 : mstatus_mpie; // @[csr.scala 288:21:@380.10]
  assign _GEN_85 = wen ? _GEN_62 : _GEN_6; // @[csr.scala 288:21:@380.10]
  assign _GEN_86 = wen ? _GEN_63 : _GEN_5; // @[csr.scala 288:21:@380.10]
  assign _GEN_92 = wen ? _GEN_69 : mip_mtip; // @[csr.scala 288:21:@380.10]
  assign _GEN_93 = wen ? _GEN_70 : mip_msip; // @[csr.scala 288:21:@380.10]
  assign _GEN_94 = wen ? _GEN_71 : _GEN_0; // @[csr.scala 288:21:@380.10]
  assign _GEN_95 = wen ? _GEN_72 : _GEN_1; // @[csr.scala 288:21:@380.10]
  assign _GEN_96 = wen ? _GEN_73 : _GEN_2; // @[csr.scala 288:21:@380.10]
  assign _GEN_97 = wen ? _GEN_74 : _GEN_3; // @[csr.scala 288:21:@380.10]
  assign _GEN_98 = wen ? _GEN_75 : _GEN_4; // @[csr.scala 288:21:@380.10]
  assign _GEN_99 = wen ? _GEN_76 : mie_mtie; // @[csr.scala 288:21:@380.10]
  assign _GEN_100 = wen ? _GEN_77 : mie_msie; // @[csr.scala 288:21:@380.10]
  assign _GEN_101 = wen ? _GEN_78 : mtvec; // @[csr.scala 288:21:@380.10]
  assign _GEN_102 = wen ? _GEN_79 : mscratch; // @[csr.scala 288:21:@380.10]
  assign _GEN_103 = wen ? _GEN_80 : {{3'd0}, mepc}; // @[csr.scala 288:21:@380.10]
  assign _GEN_104 = wen ? _GEN_81 : mcause; // @[csr.scala 288:21:@380.10]
  assign _GEN_105 = wen ? _GEN_82 : mtval; // @[csr.scala 288:21:@380.10]
  assign _GEN_106 = isEret ? mstatus_mpp : _GEN_85; // @[csr.scala 283:24:@373.8]
  assign _GEN_107 = isEret ? mstatus_mpie : _GEN_86; // @[csr.scala 283:24:@373.8]
  assign _GEN_108 = isEret ? 2'h3 : _GEN_83; // @[csr.scala 283:24:@373.8]
  assign _GEN_109 = isEret ? 1'h1 : _GEN_84; // @[csr.scala 283:24:@373.8]
  assign _GEN_115 = isEret ? mip_mtip : _GEN_92; // @[csr.scala 283:24:@373.8]
  assign _GEN_116 = isEret ? mip_msip : _GEN_93; // @[csr.scala 283:24:@373.8]
  assign _GEN_117 = isEret ? _GEN_0 : _GEN_94; // @[csr.scala 283:24:@373.8]
  assign _GEN_118 = isEret ? _GEN_1 : _GEN_95; // @[csr.scala 283:24:@373.8]
  assign _GEN_119 = isEret ? _GEN_2 : _GEN_96; // @[csr.scala 283:24:@373.8]
  assign _GEN_120 = isEret ? _GEN_3 : _GEN_97; // @[csr.scala 283:24:@373.8]
  assign _GEN_121 = isEret ? _GEN_4 : _GEN_98; // @[csr.scala 283:24:@373.8]
  assign _GEN_122 = isEret ? mie_mtie : _GEN_99; // @[csr.scala 283:24:@373.8]
  assign _GEN_123 = isEret ? mie_msie : _GEN_100; // @[csr.scala 283:24:@373.8]
  assign _GEN_124 = isEret ? mtvec : _GEN_101; // @[csr.scala 283:24:@373.8]
  assign _GEN_125 = isEret ? mscratch : _GEN_102; // @[csr.scala 283:24:@373.8]
  assign _GEN_126 = isEret ? {{3'd0}, mepc} : _GEN_103; // @[csr.scala 283:24:@373.8]
  assign _GEN_127 = isEret ? mcause : _GEN_104; // @[csr.scala 283:24:@373.8]
  assign _GEN_128 = isEret ? mtval : _GEN_105; // @[csr.scala 283:24:@373.8]
  assign _GEN_129 = io_expt ? {{3'd0}, _GEN_12} : _GEN_126; // @[csr.scala 269:19:@347.6]
  assign _GEN_130 = io_expt ? _T_527 : _GEN_127; // @[csr.scala 269:19:@347.6]
  assign _GEN_131 = io_expt ? 2'h3 : _GEN_106; // @[csr.scala 269:19:@347.6]
  assign _GEN_132 = io_expt ? 1'h0 : _GEN_107; // @[csr.scala 269:19:@347.6]
  assign _GEN_133 = io_expt ? mstatus_prv : _GEN_108; // @[csr.scala 269:19:@347.6]
  assign _GEN_134 = io_expt ? mstatus_mie : _GEN_109; // @[csr.scala 269:19:@347.6]
  assign _GEN_135 = io_expt ? _GEN_13 : _GEN_128; // @[csr.scala 269:19:@347.6]
  assign _GEN_141 = io_expt ? mip_mtip : _GEN_115; // @[csr.scala 269:19:@347.6]
  assign _GEN_142 = io_expt ? mip_msip : _GEN_116; // @[csr.scala 269:19:@347.6]
  assign _GEN_143 = io_expt ? _GEN_0 : _GEN_117; // @[csr.scala 269:19:@347.6]
  assign _GEN_144 = io_expt ? _GEN_1 : _GEN_118; // @[csr.scala 269:19:@347.6]
  assign _GEN_145 = io_expt ? _GEN_2 : _GEN_119; // @[csr.scala 269:19:@347.6]
  assign _GEN_146 = io_expt ? _GEN_3 : _GEN_120; // @[csr.scala 269:19:@347.6]
  assign _GEN_147 = io_expt ? _GEN_4 : _GEN_121; // @[csr.scala 269:19:@347.6]
  assign _GEN_148 = io_expt ? mie_mtie : _GEN_122; // @[csr.scala 269:19:@347.6]
  assign _GEN_149 = io_expt ? mie_msie : _GEN_123; // @[csr.scala 269:19:@347.6]
  assign _GEN_150 = io_expt ? mtvec : _GEN_124; // @[csr.scala 269:19:@347.6]
  assign _GEN_151 = io_expt ? mscratch : _GEN_125; // @[csr.scala 269:19:@347.6]
  assign _GEN_152 = _T_496 ? _GEN_129 : {{3'd0}, mepc}; // @[csr.scala 268:20:@346.4]
  assign _GEN_159 = _T_496 ? io_irq_m3_irq : mip_motor3ip; // @[csr.scala 268:20:@346.4]
  assign _GEN_160 = _T_496 ? io_irq_m2_irq : mip_motor2ip; // @[csr.scala 268:20:@346.4]
  assign _GEN_161 = _T_496 ? io_irq_m1_irq : mip_motor1ip; // @[csr.scala 268:20:@346.4]
  assign _GEN_162 = _T_496 ? io_irq_spi_irq : mip_spiip; // @[csr.scala 268:20:@346.4]
  assign _GEN_163 = _T_496 ? io_irq_uart_irq : mip_uartip; // @[csr.scala 268:20:@346.4]
  assign _GEN_164 = _T_496 ? _GEN_141 : mip_mtip; // @[csr.scala 268:20:@346.4]
  assign _GEN_165 = _T_496 ? _GEN_142 : mip_msip; // @[csr.scala 268:20:@346.4]
  assign _GEN_173 = _T_496 ? _GEN_150 : mtvec; // @[csr.scala 268:20:@346.4]
  assign io_out = _T_208 ? cycle : _T_278; // @[csr.scala 179:10:@138.4]
  assign io_expt = _T_468 | isInt; // @[csr.scala 235:18:@297.4]
  assign io_evec = _T_443 ? _T_446 : base; // @[csr.scala 232:18:@278.4]
  assign io_epc = mepc; // @[csr.scala 238:18:@298.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  time$ = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  timeh = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  cycle = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  cycleh = _RAND_3[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  instret = _RAND_4[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  instreth = _RAND_5[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  mstatus_prv = _RAND_6[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  mstatus_mpp = _RAND_7[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  mstatus_mpie = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  mstatus_mie = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  mie_motor3ie = _RAND_10[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  mie_motor2ie = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  mie_motor1ie = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  mie_spiie = _RAND_13[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  mie_uartie = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  mie_mtie = _RAND_15[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  mie_msie = _RAND_16[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  mip_motor1ip = _RAND_17[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  mip_motor2ip = _RAND_18[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {1{`RANDOM}};
  mip_motor3ip = _RAND_19[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_20 = {1{`RANDOM}};
  mip_spiip = _RAND_20[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_21 = {1{`RANDOM}};
  mip_uartip = _RAND_21[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_22 = {1{`RANDOM}};
  mip_mtip = _RAND_22[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_23 = {1{`RANDOM}};
  mip_msip = _RAND_23[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_24 = {1{`RANDOM}};
  mtvec = _RAND_24[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_25 = {1{`RANDOM}};
  mscratch = _RAND_25[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_26 = {1{`RANDOM}};
  mepc = _RAND_26[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_27 = {1{`RANDOM}};
  mcause = _RAND_27[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_28 = {1{`RANDOM}};
  mtval = _RAND_28[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_29 = {1{`RANDOM}};
  wasEret = _RAND_29[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_30 = {1{`RANDOM}};
  br_taken = _RAND_30[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_31 = {1{`RANDOM}};
  br_taken_delayed = _RAND_31[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      time$ <= 32'h0;
    end else begin
      time$ <= _T_472;
    end
    if (reset) begin
      timeh <= 32'h0;
    end else begin
      if (_T_475) begin
        timeh <= _T_478;
      end
    end
    if (reset) begin
      cycle <= 32'h0;
    end else begin
      cycle <= _T_481;
    end
    if (reset) begin
      cycleh <= 32'h0;
    end else begin
      if (_T_484) begin
        cycleh <= _T_487;
      end
    end
    if (reset) begin
      instret <= 32'h0;
    end else begin
      if (isInstRet) begin
        instret <= _T_499;
      end
    end
    if (reset) begin
      instreth <= 32'h0;
    end else begin
      if (_T_503) begin
        instreth <= _T_506;
      end
    end
    if (_T_496) begin
      if (io_expt) begin
        mstatus_prv <= 2'h3;
      end else begin
        if (isEret) begin
          mstatus_prv <= mstatus_mpp;
        end else begin
          if (wen) begin
            if (_T_532) begin
              mstatus_prv <= _T_535;
            end else begin
              if (reset) begin
                mstatus_prv <= 2'h3;
              end
            end
          end else begin
            if (reset) begin
              mstatus_prv <= 2'h3;
            end
          end
        end
      end
    end else begin
      if (reset) begin
        mstatus_prv <= 2'h3;
      end
    end
    if (_T_496) begin
      if (io_expt) begin
        mstatus_mpp <= mstatus_prv;
      end else begin
        if (isEret) begin
          mstatus_mpp <= 2'h3;
        end else begin
          if (wen) begin
            if (_T_532) begin
              mstatus_mpp <= _T_533;
            end else begin
              if (reset) begin
                mstatus_mpp <= 2'h3;
              end
            end
          end else begin
            if (reset) begin
              mstatus_mpp <= 2'h3;
            end
          end
        end
      end
    end else begin
      if (reset) begin
        mstatus_mpp <= 2'h3;
      end
    end
    if (_T_496) begin
      if (io_expt) begin
        mstatus_mpie <= mstatus_mie;
      end else begin
        if (isEret) begin
          mstatus_mpie <= 1'h1;
        end else begin
          if (wen) begin
            if (_T_532) begin
              mstatus_mpie <= _T_534;
            end
          end
        end
      end
    end
    if (_T_496) begin
      if (io_expt) begin
        mstatus_mie <= 1'h0;
      end else begin
        if (isEret) begin
          mstatus_mie <= mstatus_mpie;
        end else begin
          if (wen) begin
            if (_T_532) begin
              mstatus_mie <= _T_536;
            end else begin
              if (reset) begin
                mstatus_mie <= 1'h1;
              end
            end
          end else begin
            if (reset) begin
              mstatus_mie <= 1'h1;
            end
          end
        end
      end
    end else begin
      if (reset) begin
        mstatus_mie <= 1'h1;
      end
    end
    if (_T_496) begin
      if (io_expt) begin
        if (reset) begin
          mie_motor3ie <= 1'h0;
        end
      end else begin
        if (isEret) begin
          if (reset) begin
            mie_motor3ie <= 1'h0;
          end
        end else begin
          if (wen) begin
            if (_T_532) begin
              if (reset) begin
                mie_motor3ie <= 1'h0;
              end
            end else begin
              if (_T_537) begin
                if (reset) begin
                  mie_motor3ie <= 1'h0;
                end
              end else begin
                if (_T_545) begin
                  mie_motor3ie <= _T_538;
                end else begin
                  mie_motor3ie <= _GEN_0;
                end
              end
            end
          end else begin
            mie_motor3ie <= _GEN_0;
          end
        end
      end
    end else begin
      mie_motor3ie <= _GEN_0;
    end
    if (_T_496) begin
      if (io_expt) begin
        if (reset) begin
          mie_motor2ie <= 1'h0;
        end
      end else begin
        if (isEret) begin
          if (reset) begin
            mie_motor2ie <= 1'h0;
          end
        end else begin
          if (wen) begin
            if (_T_532) begin
              if (reset) begin
                mie_motor2ie <= 1'h0;
              end
            end else begin
              if (_T_537) begin
                if (reset) begin
                  mie_motor2ie <= 1'h0;
                end
              end else begin
                if (_T_545) begin
                  mie_motor2ie <= _T_539;
                end else begin
                  mie_motor2ie <= _GEN_1;
                end
              end
            end
          end else begin
            mie_motor2ie <= _GEN_1;
          end
        end
      end
    end else begin
      mie_motor2ie <= _GEN_1;
    end
    if (_T_496) begin
      if (io_expt) begin
        if (reset) begin
          mie_motor1ie <= 1'h0;
        end
      end else begin
        if (isEret) begin
          if (reset) begin
            mie_motor1ie <= 1'h0;
          end
        end else begin
          if (wen) begin
            if (_T_532) begin
              if (reset) begin
                mie_motor1ie <= 1'h0;
              end
            end else begin
              if (_T_537) begin
                if (reset) begin
                  mie_motor1ie <= 1'h0;
                end
              end else begin
                if (_T_545) begin
                  mie_motor1ie <= _T_540;
                end else begin
                  mie_motor1ie <= _GEN_2;
                end
              end
            end
          end else begin
            mie_motor1ie <= _GEN_2;
          end
        end
      end
    end else begin
      mie_motor1ie <= _GEN_2;
    end
    if (_T_496) begin
      if (io_expt) begin
        if (reset) begin
          mie_spiie <= 1'h0;
        end
      end else begin
        if (isEret) begin
          if (reset) begin
            mie_spiie <= 1'h0;
          end
        end else begin
          if (wen) begin
            if (_T_532) begin
              if (reset) begin
                mie_spiie <= 1'h0;
              end
            end else begin
              if (_T_537) begin
                if (reset) begin
                  mie_spiie <= 1'h0;
                end
              end else begin
                if (_T_545) begin
                  mie_spiie <= _T_541;
                end else begin
                  mie_spiie <= _GEN_3;
                end
              end
            end
          end else begin
            mie_spiie <= _GEN_3;
          end
        end
      end
    end else begin
      mie_spiie <= _GEN_3;
    end
    if (_T_496) begin
      if (io_expt) begin
        if (reset) begin
          mie_uartie <= 1'h1;
        end
      end else begin
        if (isEret) begin
          if (reset) begin
            mie_uartie <= 1'h1;
          end
        end else begin
          if (wen) begin
            if (_T_532) begin
              if (reset) begin
                mie_uartie <= 1'h1;
              end
            end else begin
              if (_T_537) begin
                if (reset) begin
                  mie_uartie <= 1'h1;
                end
              end else begin
                if (_T_545) begin
                  mie_uartie <= _T_542;
                end else begin
                  mie_uartie <= _GEN_4;
                end
              end
            end
          end else begin
            mie_uartie <= _GEN_4;
          end
        end
      end
    end else begin
      mie_uartie <= _GEN_4;
    end
    if (_T_496) begin
      if (!(io_expt)) begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_532)) begin
              if (!(_T_537)) begin
                if (_T_545) begin
                  mie_mtie <= _T_534;
                end
              end
            end
          end
        end
      end
    end
    if (_T_496) begin
      if (!(io_expt)) begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_532)) begin
              if (!(_T_537)) begin
                if (_T_545) begin
                  mie_msie <= _T_536;
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      mip_motor1ip <= 1'h0;
    end else begin
      if (_T_496) begin
        mip_motor1ip <= io_irq_m1_irq;
      end
    end
    if (reset) begin
      mip_motor2ip <= 1'h0;
    end else begin
      if (_T_496) begin
        mip_motor2ip <= io_irq_m2_irq;
      end
    end
    if (reset) begin
      mip_motor3ip <= 1'h0;
    end else begin
      if (_T_496) begin
        mip_motor3ip <= io_irq_m3_irq;
      end
    end
    if (reset) begin
      mip_spiip <= 1'h0;
    end else begin
      if (_T_496) begin
        mip_spiip <= io_irq_spi_irq;
      end
    end
    if (reset) begin
      mip_uartip <= 1'h0;
    end else begin
      if (_T_496) begin
        mip_uartip <= io_irq_uart_irq;
      end
    end
    if (reset) begin
      mip_mtip <= 1'h0;
    end else begin
      if (_T_496) begin
        if (!(io_expt)) begin
          if (!(isEret)) begin
            if (wen) begin
              if (!(_T_532)) begin
                if (_T_537) begin
                  mip_mtip <= _T_534;
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      mip_msip <= 1'h0;
    end else begin
      if (_T_496) begin
        if (!(io_expt)) begin
          if (!(isEret)) begin
            if (wen) begin
              if (!(_T_532)) begin
                if (_T_537) begin
                  mip_msip <= _T_536;
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      mtvec <= 32'h9;
    end else begin
      if (_T_496) begin
        if (!(io_expt)) begin
          if (!(isEret)) begin
            if (wen) begin
              if (!(_T_532)) begin
                if (!(_T_537)) begin
                  if (!(_T_545)) begin
                    if (_T_553) begin
                      if (_T_407) begin
                        mtvec <= io_in;
                      end else begin
                        if (_T_405) begin
                          mtvec <= _T_400;
                        end else begin
                          if (_T_403) begin
                            mtvec <= _T_402;
                          end else begin
                            mtvec <= 32'h0;
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if (_T_496) begin
      if (!(io_expt)) begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_532)) begin
              if (!(_T_537)) begin
                if (!(_T_545)) begin
                  if (!(_T_553)) begin
                    if (_T_554) begin
                      if (_T_407) begin
                        mscratch <= io_in;
                      end else begin
                        if (_T_405) begin
                          mscratch <= _T_400;
                        end else begin
                          if (_T_403) begin
                            mscratch <= _T_402;
                          end else begin
                            mscratch <= 32'h0;
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    mepc <= _GEN_152[31:0];
    if (_T_496) begin
      if (io_expt) begin
        mcause <= _T_527;
      end else begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_532)) begin
              if (!(_T_537)) begin
                if (!(_T_545)) begin
                  if (!(_T_553)) begin
                    if (!(_T_554)) begin
                      if (!(_T_555)) begin
                        if (_T_560) begin
                          mcause <= _T_562;
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if (_T_496) begin
      if (io_expt) begin
        if (_T_530) begin
          mtval <= io_addr;
        end
      end else begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_532)) begin
              if (!(_T_537)) begin
                if (!(_T_545)) begin
                  if (!(_T_553)) begin
                    if (!(_T_554)) begin
                      if (!(_T_555)) begin
                        if (!(_T_560)) begin
                          if (_T_563) begin
                            if (_T_407) begin
                              mtval <= io_in;
                            end else begin
                              if (_T_405) begin
                                mtval <= _T_400;
                              end else begin
                                if (_T_403) begin
                                  mtval <= _T_402;
                                end else begin
                                  mtval <= 32'h0;
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      wasEret <= 1'h0;
    end else begin
      wasEret <= isEret;
    end
    br_taken <= io_br_taken;
    br_taken_delayed <= br_taken;
  end
endmodule
module RegFile( // @[:@464.2]
  input         clock, // @[:@465.4]
  input  [4:0]  io_raddr_1, // @[:@467.4]
  input  [4:0]  io_raddr_2, // @[:@467.4]
  output [31:0] io_rdata_1, // @[:@467.4]
  output [31:0] io_rdata_2, // @[:@467.4]
  input         io_wen, // @[:@467.4]
  input  [4:0]  io_waddr, // @[:@467.4]
  input  [31:0] io_wdata // @[:@467.4]
);
  reg [31:0] regs [0:31]; // @[reg_file.scala 31:17:@469.4]
  reg [31:0] _RAND_0;
  wire [31:0] regs__T_23_data; // @[reg_file.scala 31:17:@469.4]
  wire [4:0] regs__T_23_addr; // @[reg_file.scala 31:17:@469.4]
  wire [31:0] regs__T_28_data; // @[reg_file.scala 31:17:@469.4]
  wire [4:0] regs__T_28_addr; // @[reg_file.scala 31:17:@469.4]
  wire [31:0] regs__T_34_data; // @[reg_file.scala 31:17:@469.4]
  wire [4:0] regs__T_34_addr; // @[reg_file.scala 31:17:@469.4]
  wire  regs__T_34_mask; // @[reg_file.scala 31:17:@469.4]
  wire  regs__T_34_en; // @[reg_file.scala 31:17:@469.4]
  wire  _T_22; // @[reg_file.scala 33:33:@470.4]
  wire  _T_27; // @[reg_file.scala 34:33:@474.4]
  wire  _T_32; // @[reg_file.scala 36:26:@478.4]
  assign regs__T_23_addr = io_raddr_1;
  assign regs__T_23_data = regs[regs__T_23_addr]; // @[reg_file.scala 31:17:@469.4]
  assign regs__T_28_addr = io_raddr_2;
  assign regs__T_28_data = regs[regs__T_28_addr]; // @[reg_file.scala 31:17:@469.4]
  assign regs__T_34_data = io_wdata;
  assign regs__T_34_addr = io_waddr;
  assign regs__T_34_mask = 1'h1;
  assign regs__T_34_en = io_wen & _T_32;
  assign _T_22 = io_raddr_1 != 5'h0; // @[reg_file.scala 33:33:@470.4]
  assign _T_27 = io_raddr_2 != 5'h0; // @[reg_file.scala 34:33:@474.4]
  assign _T_32 = io_waddr != 5'h0; // @[reg_file.scala 36:26:@478.4]
  assign io_rdata_1 = _T_22 ? regs__T_23_data : 32'h0; // @[reg_file.scala 33:14:@473.4]
  assign io_rdata_2 = _T_27 ? regs__T_28_data : 32'h0; // @[reg_file.scala 34:14:@477.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regs[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(regs__T_34_en & regs__T_34_mask) begin
      regs[regs__T_34_addr] <= regs__T_34_data; // @[reg_file.scala 31:17:@469.4]
    end
  end
endmodule
module ALU( // @[:@485.2]
  input  [31:0] io_in_a, // @[:@488.4]
  input  [31:0] io_in_b, // @[:@488.4]
  input  [3:0]  io_alu_op, // @[:@488.4]
  output [31:0] io_out, // @[:@488.4]
  output [31:0] io_sum // @[:@488.4]
);
  wire  _T_15; // @[alu.scala 45:39:@490.4]
  wire [32:0] _T_17; // @[alu.scala 45:44:@491.4]
  wire [32:0] _T_18; // @[alu.scala 45:44:@492.4]
  wire [31:0] _T_19; // @[alu.scala 45:44:@493.4]
  wire [31:0] _T_20; // @[alu.scala 45:29:@494.4]
  wire [32:0] _T_21; // @[alu.scala 45:24:@495.4]
  wire [31:0] sum; // @[alu.scala 45:24:@496.4]
  wire  _T_22; // @[alu.scala 46:28:@497.4]
  wire  _T_23; // @[alu.scala 46:48:@498.4]
  wire  _T_24; // @[alu.scala 46:37:@499.4]
  wire  _T_25; // @[alu.scala 46:61:@500.4]
  wire  _T_26; // @[alu.scala 47:33:@501.4]
  wire  _T_29; // @[alu.scala 47:23:@504.4]
  wire  cmp; // @[alu.scala 46:19:@505.4]
  wire [4:0] shamt; // @[alu.scala 48:23:@506.4]
  wire  _T_30; // @[alu.scala 49:29:@507.4]
  wire [15:0] _T_35; // @[Bitwise.scala 103:21:@510.4]
  wire [31:0] _T_36; // @[Bitwise.scala 103:31:@511.4]
  wire [15:0] _T_37; // @[Bitwise.scala 103:46:@512.4]
  wire [31:0] _GEN_0; // @[Bitwise.scala 103:65:@513.4]
  wire [31:0] _T_38; // @[Bitwise.scala 103:65:@513.4]
  wire [31:0] _T_40; // @[Bitwise.scala 103:75:@515.4]
  wire [31:0] _T_41; // @[Bitwise.scala 103:39:@516.4]
  wire [23:0] _T_45; // @[Bitwise.scala 103:21:@520.4]
  wire [31:0] _GEN_1; // @[Bitwise.scala 103:31:@521.4]
  wire [31:0] _T_46; // @[Bitwise.scala 103:31:@521.4]
  wire [23:0] _T_47; // @[Bitwise.scala 103:46:@522.4]
  wire [31:0] _GEN_2; // @[Bitwise.scala 103:65:@523.4]
  wire [31:0] _T_48; // @[Bitwise.scala 103:65:@523.4]
  wire [31:0] _T_50; // @[Bitwise.scala 103:75:@525.4]
  wire [31:0] _T_51; // @[Bitwise.scala 103:39:@526.4]
  wire [27:0] _T_55; // @[Bitwise.scala 103:21:@530.4]
  wire [31:0] _GEN_3; // @[Bitwise.scala 103:31:@531.4]
  wire [31:0] _T_56; // @[Bitwise.scala 103:31:@531.4]
  wire [27:0] _T_57; // @[Bitwise.scala 103:46:@532.4]
  wire [31:0] _GEN_4; // @[Bitwise.scala 103:65:@533.4]
  wire [31:0] _T_58; // @[Bitwise.scala 103:65:@533.4]
  wire [31:0] _T_60; // @[Bitwise.scala 103:75:@535.4]
  wire [31:0] _T_61; // @[Bitwise.scala 103:39:@536.4]
  wire [29:0] _T_65; // @[Bitwise.scala 103:21:@540.4]
  wire [31:0] _GEN_5; // @[Bitwise.scala 103:31:@541.4]
  wire [31:0] _T_66; // @[Bitwise.scala 103:31:@541.4]
  wire [29:0] _T_67; // @[Bitwise.scala 103:46:@542.4]
  wire [31:0] _GEN_6; // @[Bitwise.scala 103:65:@543.4]
  wire [31:0] _T_68; // @[Bitwise.scala 103:65:@543.4]
  wire [31:0] _T_70; // @[Bitwise.scala 103:75:@545.4]
  wire [31:0] _T_71; // @[Bitwise.scala 103:39:@546.4]
  wire [30:0] _T_75; // @[Bitwise.scala 103:21:@550.4]
  wire [31:0] _GEN_7; // @[Bitwise.scala 103:31:@551.4]
  wire [31:0] _T_76; // @[Bitwise.scala 103:31:@551.4]
  wire [30:0] _T_77; // @[Bitwise.scala 103:46:@552.4]
  wire [31:0] _GEN_8; // @[Bitwise.scala 103:65:@553.4]
  wire [31:0] _T_78; // @[Bitwise.scala 103:65:@553.4]
  wire [31:0] _T_80; // @[Bitwise.scala 103:75:@555.4]
  wire [31:0] _T_81; // @[Bitwise.scala 103:39:@556.4]
  wire [31:0] shin; // @[alu.scala 49:19:@557.4]
  wire  _T_83; // @[alu.scala 50:41:@559.4]
  wire  _T_84; // @[alu.scala 50:34:@560.4]
  wire [32:0] _T_85; // @[Cat.scala 30:58:@561.4]
  wire [32:0] _T_86; // @[alu.scala 50:57:@562.4]
  wire [32:0] _T_87; // @[alu.scala 50:64:@563.4]
  wire [31:0] shiftr; // @[alu.scala 50:73:@564.4]
  wire [15:0] _T_92; // @[Bitwise.scala 103:21:@567.4]
  wire [31:0] _T_93; // @[Bitwise.scala 103:31:@568.4]
  wire [15:0] _T_94; // @[Bitwise.scala 103:46:@569.4]
  wire [31:0] _GEN_9; // @[Bitwise.scala 103:65:@570.4]
  wire [31:0] _T_95; // @[Bitwise.scala 103:65:@570.4]
  wire [31:0] _T_97; // @[Bitwise.scala 103:75:@572.4]
  wire [31:0] _T_98; // @[Bitwise.scala 103:39:@573.4]
  wire [23:0] _T_102; // @[Bitwise.scala 103:21:@577.4]
  wire [31:0] _GEN_10; // @[Bitwise.scala 103:31:@578.4]
  wire [31:0] _T_103; // @[Bitwise.scala 103:31:@578.4]
  wire [23:0] _T_104; // @[Bitwise.scala 103:46:@579.4]
  wire [31:0] _GEN_11; // @[Bitwise.scala 103:65:@580.4]
  wire [31:0] _T_105; // @[Bitwise.scala 103:65:@580.4]
  wire [31:0] _T_107; // @[Bitwise.scala 103:75:@582.4]
  wire [31:0] _T_108; // @[Bitwise.scala 103:39:@583.4]
  wire [27:0] _T_112; // @[Bitwise.scala 103:21:@587.4]
  wire [31:0] _GEN_12; // @[Bitwise.scala 103:31:@588.4]
  wire [31:0] _T_113; // @[Bitwise.scala 103:31:@588.4]
  wire [27:0] _T_114; // @[Bitwise.scala 103:46:@589.4]
  wire [31:0] _GEN_13; // @[Bitwise.scala 103:65:@590.4]
  wire [31:0] _T_115; // @[Bitwise.scala 103:65:@590.4]
  wire [31:0] _T_117; // @[Bitwise.scala 103:75:@592.4]
  wire [31:0] _T_118; // @[Bitwise.scala 103:39:@593.4]
  wire [29:0] _T_122; // @[Bitwise.scala 103:21:@597.4]
  wire [31:0] _GEN_14; // @[Bitwise.scala 103:31:@598.4]
  wire [31:0] _T_123; // @[Bitwise.scala 103:31:@598.4]
  wire [29:0] _T_124; // @[Bitwise.scala 103:46:@599.4]
  wire [31:0] _GEN_15; // @[Bitwise.scala 103:65:@600.4]
  wire [31:0] _T_125; // @[Bitwise.scala 103:65:@600.4]
  wire [31:0] _T_127; // @[Bitwise.scala 103:75:@602.4]
  wire [31:0] _T_128; // @[Bitwise.scala 103:39:@603.4]
  wire [30:0] _T_132; // @[Bitwise.scala 103:21:@607.4]
  wire [31:0] _GEN_16; // @[Bitwise.scala 103:31:@608.4]
  wire [31:0] _T_133; // @[Bitwise.scala 103:31:@608.4]
  wire [30:0] _T_134; // @[Bitwise.scala 103:46:@609.4]
  wire [31:0] _GEN_17; // @[Bitwise.scala 103:65:@610.4]
  wire [31:0] _T_135; // @[Bitwise.scala 103:65:@610.4]
  wire [31:0] _T_137; // @[Bitwise.scala 103:75:@612.4]
  wire [31:0] shiftl; // @[Bitwise.scala 103:39:@613.4]
  wire  _T_151; // @[alu.scala 54:19:@614.4]
  wire  _T_152; // @[alu.scala 54:44:@615.4]
  wire  _T_153; // @[alu.scala 54:31:@616.4]
  wire  _T_154; // @[alu.scala 55:19:@617.4]
  wire  _T_155; // @[alu.scala 55:44:@618.4]
  wire  _T_156; // @[alu.scala 55:31:@619.4]
  wire  _T_157; // @[alu.scala 56:19:@620.4]
  wire  _T_158; // @[alu.scala 56:44:@621.4]
  wire  _T_159; // @[alu.scala 56:31:@622.4]
  wire  _T_160; // @[alu.scala 57:19:@623.4]
  wire  _T_161; // @[alu.scala 58:19:@624.4]
  wire [31:0] _T_162; // @[alu.scala 58:41:@625.4]
  wire  _T_163; // @[alu.scala 59:19:@626.4]
  wire [31:0] _T_164; // @[alu.scala 59:41:@627.4]
  wire  _T_165; // @[alu.scala 60:19:@628.4]
  wire [31:0] _T_166; // @[alu.scala 60:41:@629.4]
  wire  _T_167; // @[alu.scala 61:19:@630.4]
  wire [31:0] _T_168; // @[alu.scala 61:8:@631.4]
  wire [31:0] _T_169; // @[alu.scala 60:8:@632.4]
  wire [31:0] _T_170; // @[alu.scala 59:8:@633.4]
  wire [31:0] _T_171; // @[alu.scala 58:8:@634.4]
  wire [31:0] _T_172; // @[alu.scala 57:8:@635.4]
  wire [31:0] _T_173; // @[alu.scala 56:8:@636.4]
  wire [31:0] _T_174; // @[alu.scala 55:8:@637.4]
  assign _T_15 = io_alu_op[0]; // @[alu.scala 45:39:@490.4]
  assign _T_17 = 32'h0 - io_in_b; // @[alu.scala 45:44:@491.4]
  assign _T_18 = $unsigned(_T_17); // @[alu.scala 45:44:@492.4]
  assign _T_19 = _T_18[31:0]; // @[alu.scala 45:44:@493.4]
  assign _T_20 = _T_15 ? _T_19 : io_in_b; // @[alu.scala 45:29:@494.4]
  assign _T_21 = io_in_a + _T_20; // @[alu.scala 45:24:@495.4]
  assign sum = io_in_a + _T_20; // @[alu.scala 45:24:@496.4]
  assign _T_22 = io_in_a[31]; // @[alu.scala 46:28:@497.4]
  assign _T_23 = io_in_b[31]; // @[alu.scala 46:48:@498.4]
  assign _T_24 = _T_22 == _T_23; // @[alu.scala 46:37:@499.4]
  assign _T_25 = sum[31]; // @[alu.scala 46:61:@500.4]
  assign _T_26 = io_alu_op[1]; // @[alu.scala 47:33:@501.4]
  assign _T_29 = _T_26 ? _T_23 : _T_22; // @[alu.scala 47:23:@504.4]
  assign cmp = _T_24 ? _T_25 : _T_29; // @[alu.scala 46:19:@505.4]
  assign shamt = io_in_b[4:0]; // @[alu.scala 48:23:@506.4]
  assign _T_30 = io_alu_op[3]; // @[alu.scala 49:29:@507.4]
  assign _T_35 = io_in_a[31:16]; // @[Bitwise.scala 103:21:@510.4]
  assign _T_36 = {{16'd0}, _T_35}; // @[Bitwise.scala 103:31:@511.4]
  assign _T_37 = io_in_a[15:0]; // @[Bitwise.scala 103:46:@512.4]
  assign _GEN_0 = {{16'd0}, _T_37}; // @[Bitwise.scala 103:65:@513.4]
  assign _T_38 = _GEN_0 << 16; // @[Bitwise.scala 103:65:@513.4]
  assign _T_40 = _T_38 & 32'hffff0000; // @[Bitwise.scala 103:75:@515.4]
  assign _T_41 = _T_36 | _T_40; // @[Bitwise.scala 103:39:@516.4]
  assign _T_45 = _T_41[31:8]; // @[Bitwise.scala 103:21:@520.4]
  assign _GEN_1 = {{8'd0}, _T_45}; // @[Bitwise.scala 103:31:@521.4]
  assign _T_46 = _GEN_1 & 32'hff00ff; // @[Bitwise.scala 103:31:@521.4]
  assign _T_47 = _T_41[23:0]; // @[Bitwise.scala 103:46:@522.4]
  assign _GEN_2 = {{8'd0}, _T_47}; // @[Bitwise.scala 103:65:@523.4]
  assign _T_48 = _GEN_2 << 8; // @[Bitwise.scala 103:65:@523.4]
  assign _T_50 = _T_48 & 32'hff00ff00; // @[Bitwise.scala 103:75:@525.4]
  assign _T_51 = _T_46 | _T_50; // @[Bitwise.scala 103:39:@526.4]
  assign _T_55 = _T_51[31:4]; // @[Bitwise.scala 103:21:@530.4]
  assign _GEN_3 = {{4'd0}, _T_55}; // @[Bitwise.scala 103:31:@531.4]
  assign _T_56 = _GEN_3 & 32'hf0f0f0f; // @[Bitwise.scala 103:31:@531.4]
  assign _T_57 = _T_51[27:0]; // @[Bitwise.scala 103:46:@532.4]
  assign _GEN_4 = {{4'd0}, _T_57}; // @[Bitwise.scala 103:65:@533.4]
  assign _T_58 = _GEN_4 << 4; // @[Bitwise.scala 103:65:@533.4]
  assign _T_60 = _T_58 & 32'hf0f0f0f0; // @[Bitwise.scala 103:75:@535.4]
  assign _T_61 = _T_56 | _T_60; // @[Bitwise.scala 103:39:@536.4]
  assign _T_65 = _T_61[31:2]; // @[Bitwise.scala 103:21:@540.4]
  assign _GEN_5 = {{2'd0}, _T_65}; // @[Bitwise.scala 103:31:@541.4]
  assign _T_66 = _GEN_5 & 32'h33333333; // @[Bitwise.scala 103:31:@541.4]
  assign _T_67 = _T_61[29:0]; // @[Bitwise.scala 103:46:@542.4]
  assign _GEN_6 = {{2'd0}, _T_67}; // @[Bitwise.scala 103:65:@543.4]
  assign _T_68 = _GEN_6 << 2; // @[Bitwise.scala 103:65:@543.4]
  assign _T_70 = _T_68 & 32'hcccccccc; // @[Bitwise.scala 103:75:@545.4]
  assign _T_71 = _T_66 | _T_70; // @[Bitwise.scala 103:39:@546.4]
  assign _T_75 = _T_71[31:1]; // @[Bitwise.scala 103:21:@550.4]
  assign _GEN_7 = {{1'd0}, _T_75}; // @[Bitwise.scala 103:31:@551.4]
  assign _T_76 = _GEN_7 & 32'h55555555; // @[Bitwise.scala 103:31:@551.4]
  assign _T_77 = _T_71[30:0]; // @[Bitwise.scala 103:46:@552.4]
  assign _GEN_8 = {{1'd0}, _T_77}; // @[Bitwise.scala 103:65:@553.4]
  assign _T_78 = _GEN_8 << 1; // @[Bitwise.scala 103:65:@553.4]
  assign _T_80 = _T_78 & 32'haaaaaaaa; // @[Bitwise.scala 103:75:@555.4]
  assign _T_81 = _T_76 | _T_80; // @[Bitwise.scala 103:39:@556.4]
  assign shin = _T_30 ? io_in_a : _T_81; // @[alu.scala 49:19:@557.4]
  assign _T_83 = shin[31]; // @[alu.scala 50:41:@559.4]
  assign _T_84 = _T_15 & _T_83; // @[alu.scala 50:34:@560.4]
  assign _T_85 = {_T_84,shin}; // @[Cat.scala 30:58:@561.4]
  assign _T_86 = $signed(_T_85); // @[alu.scala 50:57:@562.4]
  assign _T_87 = $signed(_T_86) >>> shamt; // @[alu.scala 50:64:@563.4]
  assign shiftr = _T_87[31:0]; // @[alu.scala 50:73:@564.4]
  assign _T_92 = shiftr[31:16]; // @[Bitwise.scala 103:21:@567.4]
  assign _T_93 = {{16'd0}, _T_92}; // @[Bitwise.scala 103:31:@568.4]
  assign _T_94 = shiftr[15:0]; // @[Bitwise.scala 103:46:@569.4]
  assign _GEN_9 = {{16'd0}, _T_94}; // @[Bitwise.scala 103:65:@570.4]
  assign _T_95 = _GEN_9 << 16; // @[Bitwise.scala 103:65:@570.4]
  assign _T_97 = _T_95 & 32'hffff0000; // @[Bitwise.scala 103:75:@572.4]
  assign _T_98 = _T_93 | _T_97; // @[Bitwise.scala 103:39:@573.4]
  assign _T_102 = _T_98[31:8]; // @[Bitwise.scala 103:21:@577.4]
  assign _GEN_10 = {{8'd0}, _T_102}; // @[Bitwise.scala 103:31:@578.4]
  assign _T_103 = _GEN_10 & 32'hff00ff; // @[Bitwise.scala 103:31:@578.4]
  assign _T_104 = _T_98[23:0]; // @[Bitwise.scala 103:46:@579.4]
  assign _GEN_11 = {{8'd0}, _T_104}; // @[Bitwise.scala 103:65:@580.4]
  assign _T_105 = _GEN_11 << 8; // @[Bitwise.scala 103:65:@580.4]
  assign _T_107 = _T_105 & 32'hff00ff00; // @[Bitwise.scala 103:75:@582.4]
  assign _T_108 = _T_103 | _T_107; // @[Bitwise.scala 103:39:@583.4]
  assign _T_112 = _T_108[31:4]; // @[Bitwise.scala 103:21:@587.4]
  assign _GEN_12 = {{4'd0}, _T_112}; // @[Bitwise.scala 103:31:@588.4]
  assign _T_113 = _GEN_12 & 32'hf0f0f0f; // @[Bitwise.scala 103:31:@588.4]
  assign _T_114 = _T_108[27:0]; // @[Bitwise.scala 103:46:@589.4]
  assign _GEN_13 = {{4'd0}, _T_114}; // @[Bitwise.scala 103:65:@590.4]
  assign _T_115 = _GEN_13 << 4; // @[Bitwise.scala 103:65:@590.4]
  assign _T_117 = _T_115 & 32'hf0f0f0f0; // @[Bitwise.scala 103:75:@592.4]
  assign _T_118 = _T_113 | _T_117; // @[Bitwise.scala 103:39:@593.4]
  assign _T_122 = _T_118[31:2]; // @[Bitwise.scala 103:21:@597.4]
  assign _GEN_14 = {{2'd0}, _T_122}; // @[Bitwise.scala 103:31:@598.4]
  assign _T_123 = _GEN_14 & 32'h33333333; // @[Bitwise.scala 103:31:@598.4]
  assign _T_124 = _T_118[29:0]; // @[Bitwise.scala 103:46:@599.4]
  assign _GEN_15 = {{2'd0}, _T_124}; // @[Bitwise.scala 103:65:@600.4]
  assign _T_125 = _GEN_15 << 2; // @[Bitwise.scala 103:65:@600.4]
  assign _T_127 = _T_125 & 32'hcccccccc; // @[Bitwise.scala 103:75:@602.4]
  assign _T_128 = _T_123 | _T_127; // @[Bitwise.scala 103:39:@603.4]
  assign _T_132 = _T_128[31:1]; // @[Bitwise.scala 103:21:@607.4]
  assign _GEN_16 = {{1'd0}, _T_132}; // @[Bitwise.scala 103:31:@608.4]
  assign _T_133 = _GEN_16 & 32'h55555555; // @[Bitwise.scala 103:31:@608.4]
  assign _T_134 = _T_128[30:0]; // @[Bitwise.scala 103:46:@609.4]
  assign _GEN_17 = {{1'd0}, _T_134}; // @[Bitwise.scala 103:65:@610.4]
  assign _T_135 = _GEN_17 << 1; // @[Bitwise.scala 103:65:@610.4]
  assign _T_137 = _T_135 & 32'haaaaaaaa; // @[Bitwise.scala 103:75:@612.4]
  assign shiftl = _T_133 | _T_137; // @[Bitwise.scala 103:39:@613.4]
  assign _T_151 = io_alu_op == 4'h0; // @[alu.scala 54:19:@614.4]
  assign _T_152 = io_alu_op == 4'h1; // @[alu.scala 54:44:@615.4]
  assign _T_153 = _T_151 | _T_152; // @[alu.scala 54:31:@616.4]
  assign _T_154 = io_alu_op == 4'h5; // @[alu.scala 55:19:@617.4]
  assign _T_155 = io_alu_op == 4'h7; // @[alu.scala 55:44:@618.4]
  assign _T_156 = _T_154 | _T_155; // @[alu.scala 55:31:@619.4]
  assign _T_157 = io_alu_op == 4'h9; // @[alu.scala 56:19:@620.4]
  assign _T_158 = io_alu_op == 4'h8; // @[alu.scala 56:44:@621.4]
  assign _T_159 = _T_157 | _T_158; // @[alu.scala 56:31:@622.4]
  assign _T_160 = io_alu_op == 4'h6; // @[alu.scala 57:19:@623.4]
  assign _T_161 = io_alu_op == 4'h2; // @[alu.scala 58:19:@624.4]
  assign _T_162 = io_in_a & io_in_b; // @[alu.scala 58:41:@625.4]
  assign _T_163 = io_alu_op == 4'h3; // @[alu.scala 59:19:@626.4]
  assign _T_164 = io_in_a | io_in_b; // @[alu.scala 59:41:@627.4]
  assign _T_165 = io_alu_op == 4'h4; // @[alu.scala 60:19:@628.4]
  assign _T_166 = io_in_a ^ io_in_b; // @[alu.scala 60:41:@629.4]
  assign _T_167 = io_alu_op == 4'ha; // @[alu.scala 61:19:@630.4]
  assign _T_168 = _T_167 ? io_in_a : io_in_b; // @[alu.scala 61:8:@631.4]
  assign _T_169 = _T_165 ? _T_166 : _T_168; // @[alu.scala 60:8:@632.4]
  assign _T_170 = _T_163 ? _T_164 : _T_169; // @[alu.scala 59:8:@633.4]
  assign _T_171 = _T_161 ? _T_162 : _T_170; // @[alu.scala 58:8:@634.4]
  assign _T_172 = _T_160 ? shiftl : _T_171; // @[alu.scala 57:8:@635.4]
  assign _T_173 = _T_159 ? shiftr : _T_172; // @[alu.scala 56:8:@636.4]
  assign _T_174 = _T_156 ? {{31'd0}, cmp} : _T_173; // @[alu.scala 55:8:@637.4]
  assign io_out = _T_153 ? sum : _T_174; // @[alu.scala 63:10:@639.4]
  assign io_sum = io_in_a + _T_20; // @[alu.scala 64:10:@640.4]
endmodule
module Imm( // @[:@642.2]
  input  [31:0] io_inst, // @[:@645.4]
  input  [2:0]  io_imm_sel, // @[:@645.4]
  output [31:0] io_imm_out // @[:@645.4]
);
  wire  _T_11; // @[imm_gen.scala 25:33:@647.4]
  wire  _T_13; // @[imm_gen.scala 25:56:@648.4]
  wire  _T_14; // @[imm_gen.scala 25:61:@649.4]
  wire  sign_val; // @[imm_gen.scala 25:21:@650.4]
  wire  _T_15; // @[imm_gen.scala 26:33:@651.4]
  wire [10:0] _T_16; // @[imm_gen.scala 26:51:@652.4]
  wire [10:0] _T_17; // @[imm_gen.scala 26:59:@653.4]
  wire [10:0] imm30_20; // @[imm_gen.scala 26:21:@654.4]
  wire  _T_18; // @[imm_gen.scala 27:33:@655.4]
  wire  _T_19; // @[imm_gen.scala 27:57:@656.4]
  wire  _T_20; // @[imm_gen.scala 27:43:@657.4]
  wire [7:0] _T_21; // @[imm_gen.scala 27:85:@658.4]
  wire [7:0] _T_22; // @[imm_gen.scala 27:93:@659.4]
  wire [7:0] imm19_12; // @[imm_gen.scala 27:21:@660.4]
  wire  _T_25; // @[imm_gen.scala 28:43:@663.4]
  wire  _T_27; // @[imm_gen.scala 29:35:@664.4]
  wire  _T_28; // @[imm_gen.scala 29:53:@665.4]
  wire  _T_29; // @[imm_gen.scala 29:58:@666.4]
  wire  _T_30; // @[imm_gen.scala 30:37:@667.4]
  wire  _T_31; // @[imm_gen.scala 30:55:@668.4]
  wire  _T_32; // @[imm_gen.scala 30:59:@669.4]
  wire  _T_33; // @[imm_gen.scala 30:25:@670.4]
  wire  _T_34; // @[imm_gen.scala 29:23:@671.4]
  wire  imm11; // @[imm_gen.scala 28:21:@672.4]
  wire [5:0] _T_39; // @[imm_gen.scala 31:80:@676.4]
  wire [5:0] imm10_5; // @[imm_gen.scala 31:21:@677.4]
  wire  _T_42; // @[imm_gen.scala 33:35:@679.4]
  wire  _T_44; // @[imm_gen.scala 33:45:@681.4]
  wire [3:0] _T_45; // @[imm_gen.scala 33:77:@682.4]
  wire [3:0] _T_47; // @[imm_gen.scala 34:55:@684.4]
  wire [3:0] _T_48; // @[imm_gen.scala 34:71:@685.4]
  wire [3:0] _T_49; // @[imm_gen.scala 34:25:@686.4]
  wire [3:0] _T_50; // @[imm_gen.scala 33:23:@687.4]
  wire [3:0] imm4_1; // @[imm_gen.scala 32:21:@688.4]
  wire  _T_53; // @[imm_gen.scala 36:35:@691.4]
  wire  _T_56; // @[imm_gen.scala 37:54:@694.4]
  wire  _T_58; // @[imm_gen.scala 37:24:@695.4]
  wire  _T_59; // @[imm_gen.scala 36:23:@696.4]
  wire  imm0; // @[imm_gen.scala 35:21:@697.4]
  wire  _T_62; // @[Cat.scala 30:58:@700.4]
  wire [7:0] _T_63; // @[Cat.scala 30:58:@701.4]
  wire [10:0] _T_65; // @[Cat.scala 30:58:@703.4]
  wire  _T_66; // @[Cat.scala 30:58:@704.4]
  wire [31:0] _T_69; // @[Cat.scala 30:58:@707.4]
  wire [31:0] _T_70; // @[imm_gen.scala 39:81:@708.4]
  assign _T_11 = io_imm_sel == 3'h6; // @[imm_gen.scala 25:33:@647.4]
  assign _T_13 = io_inst[31]; // @[imm_gen.scala 25:56:@648.4]
  assign _T_14 = $signed(_T_13); // @[imm_gen.scala 25:61:@649.4]
  assign sign_val = _T_11 ? $signed(1'sh0) : $signed(_T_14); // @[imm_gen.scala 25:21:@650.4]
  assign _T_15 = io_imm_sel == 3'h3; // @[imm_gen.scala 26:33:@651.4]
  assign _T_16 = io_inst[30:20]; // @[imm_gen.scala 26:51:@652.4]
  assign _T_17 = $signed(_T_16); // @[imm_gen.scala 26:59:@653.4]
  assign imm30_20 = _T_15 ? $signed(_T_17) : $signed({11{sign_val}}); // @[imm_gen.scala 26:21:@654.4]
  assign _T_18 = io_imm_sel != 3'h3; // @[imm_gen.scala 27:33:@655.4]
  assign _T_19 = io_imm_sel != 3'h4; // @[imm_gen.scala 27:57:@656.4]
  assign _T_20 = _T_18 & _T_19; // @[imm_gen.scala 27:43:@657.4]
  assign _T_21 = io_inst[19:12]; // @[imm_gen.scala 27:85:@658.4]
  assign _T_22 = $signed(_T_21); // @[imm_gen.scala 27:93:@659.4]
  assign imm19_12 = _T_20 ? $signed({8{sign_val}}) : $signed(_T_22); // @[imm_gen.scala 27:21:@660.4]
  assign _T_25 = _T_15 | _T_11; // @[imm_gen.scala 28:43:@663.4]
  assign _T_27 = io_imm_sel == 3'h4; // @[imm_gen.scala 29:35:@664.4]
  assign _T_28 = io_inst[20]; // @[imm_gen.scala 29:53:@665.4]
  assign _T_29 = $signed(_T_28); // @[imm_gen.scala 29:58:@666.4]
  assign _T_30 = io_imm_sel == 3'h5; // @[imm_gen.scala 30:37:@667.4]
  assign _T_31 = io_inst[7]; // @[imm_gen.scala 30:55:@668.4]
  assign _T_32 = $signed(_T_31); // @[imm_gen.scala 30:59:@669.4]
  assign _T_33 = _T_30 ? $signed(_T_32) : $signed(sign_val); // @[imm_gen.scala 30:25:@670.4]
  assign _T_34 = _T_27 ? $signed(_T_29) : $signed(_T_33); // @[imm_gen.scala 29:23:@671.4]
  assign imm11 = _T_25 ? $signed(1'sh0) : $signed(_T_34); // @[imm_gen.scala 28:21:@672.4]
  assign _T_39 = io_inst[30:25]; // @[imm_gen.scala 31:80:@676.4]
  assign imm10_5 = _T_25 ? 6'h0 : _T_39; // @[imm_gen.scala 31:21:@677.4]
  assign _T_42 = io_imm_sel == 3'h2; // @[imm_gen.scala 33:35:@679.4]
  assign _T_44 = _T_42 | _T_30; // @[imm_gen.scala 33:45:@681.4]
  assign _T_45 = io_inst[11:8]; // @[imm_gen.scala 33:77:@682.4]
  assign _T_47 = io_inst[19:16]; // @[imm_gen.scala 34:55:@684.4]
  assign _T_48 = io_inst[24:21]; // @[imm_gen.scala 34:71:@685.4]
  assign _T_49 = _T_11 ? _T_47 : _T_48; // @[imm_gen.scala 34:25:@686.4]
  assign _T_50 = _T_44 ? _T_45 : _T_49; // @[imm_gen.scala 33:23:@687.4]
  assign imm4_1 = _T_15 ? 4'h0 : _T_50; // @[imm_gen.scala 32:21:@688.4]
  assign _T_53 = io_imm_sel == 3'h1; // @[imm_gen.scala 36:35:@691.4]
  assign _T_56 = io_inst[15]; // @[imm_gen.scala 37:54:@694.4]
  assign _T_58 = _T_11 ? _T_56 : 1'h0; // @[imm_gen.scala 37:24:@695.4]
  assign _T_59 = _T_53 ? _T_28 : _T_58; // @[imm_gen.scala 36:23:@696.4]
  assign imm0 = _T_42 ? _T_31 : _T_59; // @[imm_gen.scala 35:21:@697.4]
  assign _T_62 = $unsigned(imm11); // @[Cat.scala 30:58:@700.4]
  assign _T_63 = $unsigned(imm19_12); // @[Cat.scala 30:58:@701.4]
  assign _T_65 = $unsigned(imm30_20); // @[Cat.scala 30:58:@703.4]
  assign _T_66 = $unsigned(sign_val); // @[Cat.scala 30:58:@704.4]
  assign _T_69 = {_T_66,_T_65,_T_63,_T_62,imm10_5,imm4_1,imm0}; // @[Cat.scala 30:58:@707.4]
  assign _T_70 = $signed(_T_69); // @[imm_gen.scala 39:81:@708.4]
  assign io_imm_out = $unsigned(_T_70); // @[imm_gen.scala 39:14:@710.4]
endmodule
module Branch( // @[:@712.2]
  input  [31:0] io_in_a, // @[:@715.4]
  input  [31:0] io_in_b, // @[:@715.4]
  input  [2:0]  io_br_type, // @[:@715.4]
  output        io_br_taken // @[:@715.4]
);
  wire [32:0] _T_13; // @[branch.scala 24:33:@717.4]
  wire [32:0] _T_14; // @[branch.scala 24:33:@718.4]
  wire [31:0] difference; // @[branch.scala 24:33:@719.4]
  wire  not_equal; // @[branch.scala 25:36:@720.4]
  wire  equal; // @[branch.scala 26:25:@721.4]
  wire  _T_17; // @[branch.scala 27:32:@722.4]
  wire  _T_18; // @[branch.scala 27:52:@723.4]
  wire  is_same_sign; // @[branch.scala 27:41:@724.4]
  wire  _T_19; // @[branch.scala 28:53:@725.4]
  wire  less_than; // @[branch.scala 28:28:@727.4]
  wire  less_than_u; // @[branch.scala 29:28:@730.4]
  wire  greater_equal; // @[branch.scala 30:25:@731.4]
  wire  greater_equal_u; // @[branch.scala 31:25:@732.4]
  wire  _T_25; // @[branch.scala 35:18:@733.4]
  wire  _T_26; // @[branch.scala 35:30:@734.4]
  wire  _T_27; // @[branch.scala 36:18:@735.4]
  wire  _T_28; // @[branch.scala 36:30:@736.4]
  wire  _T_29; // @[branch.scala 35:40:@737.4]
  wire  _T_30; // @[branch.scala 37:18:@738.4]
  wire  _T_31; // @[branch.scala 37:30:@739.4]
  wire  _T_32; // @[branch.scala 36:44:@740.4]
  wire  _T_33; // @[branch.scala 38:18:@741.4]
  wire  _T_34; // @[branch.scala 38:30:@742.4]
  wire  _T_35; // @[branch.scala 37:44:@743.4]
  wire  _T_36; // @[branch.scala 39:18:@744.4]
  wire  _T_37; // @[branch.scala 39:30:@745.4]
  wire  _T_38; // @[branch.scala 38:48:@746.4]
  wire  _T_39; // @[branch.scala 40:18:@747.4]
  wire  _T_40; // @[branch.scala 40:30:@748.4]
  assign _T_13 = io_in_a - io_in_b; // @[branch.scala 24:33:@717.4]
  assign _T_14 = $unsigned(_T_13); // @[branch.scala 24:33:@718.4]
  assign difference = _T_14[31:0]; // @[branch.scala 24:33:@719.4]
  assign not_equal = difference != 32'h0; // @[branch.scala 25:36:@720.4]
  assign equal = not_equal == 1'h0; // @[branch.scala 26:25:@721.4]
  assign _T_17 = io_in_a[31]; // @[branch.scala 27:32:@722.4]
  assign _T_18 = io_in_b[31]; // @[branch.scala 27:52:@723.4]
  assign is_same_sign = _T_17 == _T_18; // @[branch.scala 27:41:@724.4]
  assign _T_19 = difference[31]; // @[branch.scala 28:53:@725.4]
  assign less_than = is_same_sign ? _T_19 : _T_17; // @[branch.scala 28:28:@727.4]
  assign less_than_u = is_same_sign ? _T_19 : _T_18; // @[branch.scala 29:28:@730.4]
  assign greater_equal = less_than == 1'h0; // @[branch.scala 30:25:@731.4]
  assign greater_equal_u = less_than_u == 1'h0; // @[branch.scala 31:25:@732.4]
  assign _T_25 = io_br_type == 3'h3; // @[branch.scala 35:18:@733.4]
  assign _T_26 = _T_25 & equal; // @[branch.scala 35:30:@734.4]
  assign _T_27 = io_br_type == 3'h6; // @[branch.scala 36:18:@735.4]
  assign _T_28 = _T_27 & not_equal; // @[branch.scala 36:30:@736.4]
  assign _T_29 = _T_26 | _T_28; // @[branch.scala 35:40:@737.4]
  assign _T_30 = io_br_type == 3'h2; // @[branch.scala 37:18:@738.4]
  assign _T_31 = _T_30 & less_than; // @[branch.scala 37:30:@739.4]
  assign _T_32 = _T_29 | _T_31; // @[branch.scala 36:44:@740.4]
  assign _T_33 = io_br_type == 3'h5; // @[branch.scala 38:18:@741.4]
  assign _T_34 = _T_33 & greater_equal; // @[branch.scala 38:30:@742.4]
  assign _T_35 = _T_32 | _T_34; // @[branch.scala 37:44:@743.4]
  assign _T_36 = io_br_type == 3'h1; // @[branch.scala 39:18:@744.4]
  assign _T_37 = _T_36 & less_than_u; // @[branch.scala 39:30:@745.4]
  assign _T_38 = _T_35 | _T_37; // @[branch.scala 38:48:@746.4]
  assign _T_39 = io_br_type == 3'h4; // @[branch.scala 40:18:@747.4]
  assign _T_40 = _T_39 & greater_equal_u; // @[branch.scala 40:30:@748.4]
  assign io_br_taken = _T_38 | _T_40; // @[branch.scala 34:15:@750.4]
endmodule
module LS_Unit( // @[:@752.2]
  input  [1:0]  io_lsu_st_type, // @[:@755.4]
  input  [31:0] io_lsu_wdata_in, // @[:@755.4]
  output [31:0] io_lsu_wdata_out, // @[:@755.4]
  input  [31:0] io_lsu_rdata_in, // @[:@755.4]
  output [31:0] io_lsu_rdata_out, // @[:@755.4]
  input  [2:0]  io_lsu_ld_type // @[:@755.4]
);
  wire [15:0] _T_18; // @[ls_unit.scala 34:31:@757.4]
  wire [7:0] _T_19; // @[ls_unit.scala 35:31:@758.4]
  wire  _T_20; // @[Mux.scala 46:19:@759.4]
  wire [7:0] _T_21; // @[Mux.scala 46:16:@760.4]
  wire  _T_22; // @[Mux.scala 46:19:@761.4]
  wire [15:0] _T_23; // @[Mux.scala 46:16:@762.4]
  wire  _T_24; // @[Mux.scala 46:19:@763.4]
  wire [32:0] _T_27; // @[ls_unit.scala 40:29:@766.4]
  wire [15:0] _T_28; // @[ls_unit.scala 41:28:@767.4]
  wire [15:0] _T_29; // @[ls_unit.scala 41:36:@768.4]
  wire [7:0] _T_30; // @[ls_unit.scala 42:28:@769.4]
  wire [7:0] _T_31; // @[ls_unit.scala 42:35:@770.4]
  wire [16:0] _T_33; // @[ls_unit.scala 43:36:@772.4]
  wire [8:0] _T_35; // @[ls_unit.scala 44:35:@774.4]
  wire  _T_36; // @[Mux.scala 46:19:@775.4]
  wire [8:0] _T_37; // @[Mux.scala 46:16:@776.4]
  wire  _T_38; // @[Mux.scala 46:19:@777.4]
  wire [16:0] _T_39; // @[Mux.scala 46:16:@778.4]
  wire  _T_40; // @[Mux.scala 46:19:@779.4]
  wire [16:0] _T_41; // @[Mux.scala 46:16:@780.4]
  wire  _T_42; // @[Mux.scala 46:19:@781.4]
  wire [16:0] _T_43; // @[Mux.scala 46:16:@782.4]
  wire  _T_44; // @[Mux.scala 46:19:@783.4]
  wire [32:0] _T_45; // @[Mux.scala 46:16:@784.4]
  wire [31:0] _GEN_0; // @[ls_unit.scala 39:21:@785.4]
  assign _T_18 = io_lsu_wdata_in[15:0]; // @[ls_unit.scala 34:31:@757.4]
  assign _T_19 = io_lsu_wdata_in[7:0]; // @[ls_unit.scala 35:31:@758.4]
  assign _T_20 = 2'h3 == io_lsu_st_type; // @[Mux.scala 46:19:@759.4]
  assign _T_21 = _T_20 ? _T_19 : 8'h0; // @[Mux.scala 46:16:@760.4]
  assign _T_22 = 2'h2 == io_lsu_st_type; // @[Mux.scala 46:19:@761.4]
  assign _T_23 = _T_22 ? _T_18 : {{8'd0}, _T_21}; // @[Mux.scala 46:16:@762.4]
  assign _T_24 = 2'h1 == io_lsu_st_type; // @[Mux.scala 46:19:@763.4]
  assign _T_27 = {1'b0,$signed(io_lsu_rdata_in)}; // @[ls_unit.scala 40:29:@766.4]
  assign _T_28 = io_lsu_rdata_in[15:0]; // @[ls_unit.scala 41:28:@767.4]
  assign _T_29 = $signed(_T_28); // @[ls_unit.scala 41:36:@768.4]
  assign _T_30 = io_lsu_rdata_in[7:0]; // @[ls_unit.scala 42:28:@769.4]
  assign _T_31 = $signed(_T_30); // @[ls_unit.scala 42:35:@770.4]
  assign _T_33 = {1'b0,$signed(_T_28)}; // @[ls_unit.scala 43:36:@772.4]
  assign _T_35 = {1'b0,$signed(_T_30)}; // @[ls_unit.scala 44:35:@774.4]
  assign _T_36 = 3'h5 == io_lsu_ld_type; // @[Mux.scala 46:19:@775.4]
  assign _T_37 = _T_36 ? $signed(_T_35) : $signed(9'sh0); // @[Mux.scala 46:16:@776.4]
  assign _T_38 = 3'h4 == io_lsu_ld_type; // @[Mux.scala 46:19:@777.4]
  assign _T_39 = _T_38 ? $signed(_T_33) : $signed({{8{_T_37[8]}},_T_37}); // @[Mux.scala 46:16:@778.4]
  assign _T_40 = 3'h3 == io_lsu_ld_type; // @[Mux.scala 46:19:@779.4]
  assign _T_41 = _T_40 ? $signed({{9{_T_31[7]}},_T_31}) : $signed(_T_39); // @[Mux.scala 46:16:@780.4]
  assign _T_42 = 3'h2 == io_lsu_ld_type; // @[Mux.scala 46:19:@781.4]
  assign _T_43 = _T_42 ? $signed({{1{_T_29[15]}},_T_29}) : $signed(_T_41); // @[Mux.scala 46:16:@782.4]
  assign _T_44 = 3'h1 == io_lsu_ld_type; // @[Mux.scala 46:19:@783.4]
  assign _T_45 = _T_44 ? $signed(_T_27) : $signed({{16{_T_43[16]}},_T_43}); // @[Mux.scala 46:16:@784.4]
  assign io_lsu_wdata_out = _T_24 ? io_lsu_wdata_in : {{16'd0}, _T_23}; // @[ls_unit.scala 32:20:@765.4]
  assign _GEN_0 = _T_45[31:0]; // @[ls_unit.scala 39:21:@785.4]
  assign io_lsu_rdata_out = $signed(_GEN_0); // @[ls_unit.scala 39:21:@785.4]
endmodule
module Datapath( // @[:@787.2]
  input         clock, // @[:@788.4]
  input         reset, // @[:@789.4]
  input         io_irq_uart_irq, // @[:@790.4]
  input         io_irq_spi_irq, // @[:@790.4]
  input         io_irq_m1_irq, // @[:@790.4]
  input         io_irq_m2_irq, // @[:@790.4]
  input         io_irq_m3_irq, // @[:@790.4]
  output [31:0] io_ibus_addr, // @[:@790.4]
  input  [31:0] io_ibus_inst, // @[:@790.4]
  input         io_ibus_valid, // @[:@790.4]
  output [31:0] io_dbus_addr, // @[:@790.4]
  output [31:0] io_dbus_wdata, // @[:@790.4]
  input  [31:0] io_dbus_rdata, // @[:@790.4]
  output        io_dbus_rd_en, // @[:@790.4]
  output        io_dbus_wr_en, // @[:@790.4]
  output [1:0]  io_dbus_st_type, // @[:@790.4]
  output [2:0]  io_dbus_ld_type, // @[:@790.4]
  input         io_dbus_valid, // @[:@790.4]
  output [31:0] io_ctrl_inst, // @[:@790.4]
  input  [1:0]  io_ctrl_pc_sel, // @[:@790.4]
  input         io_ctrl_inst_kill, // @[:@790.4]
  input         io_ctrl_a_sel, // @[:@790.4]
  input         io_ctrl_b_sel, // @[:@790.4]
  input  [2:0]  io_ctrl_imm_sel, // @[:@790.4]
  input  [4:0]  io_ctrl_alu_op, // @[:@790.4]
  input  [2:0]  io_ctrl_br_type, // @[:@790.4]
  input  [1:0]  io_ctrl_st_type, // @[:@790.4]
  input  [2:0]  io_ctrl_ld_type, // @[:@790.4]
  input  [1:0]  io_ctrl_wb_mux_sel, // @[:@790.4]
  input         io_ctrl_wb_en, // @[:@790.4]
  input  [2:0]  io_ctrl_csr_cmd, // @[:@790.4]
  input         io_ctrl_illegal, // @[:@790.4]
  input         io_ctrl_en_rs1, // @[:@790.4]
  input         io_ctrl_en_rs2 // @[:@790.4]
);
  wire  csr_clock; // @[pipeline.scala 34:26:@792.4]
  wire  csr_reset; // @[pipeline.scala 34:26:@792.4]
  wire  csr_io_stall; // @[pipeline.scala 34:26:@792.4]
  wire [2:0] csr_io_cmd; // @[pipeline.scala 34:26:@792.4]
  wire [31:0] csr_io_in; // @[pipeline.scala 34:26:@792.4]
  wire [31:0] csr_io_out; // @[pipeline.scala 34:26:@792.4]
  wire [31:0] csr_io_pc; // @[pipeline.scala 34:26:@792.4]
  wire [31:0] csr_io_addr; // @[pipeline.scala 34:26:@792.4]
  wire [31:0] csr_io_inst; // @[pipeline.scala 34:26:@792.4]
  wire  csr_io_illegal; // @[pipeline.scala 34:26:@792.4]
  wire [1:0] csr_io_st_type; // @[pipeline.scala 34:26:@792.4]
  wire [2:0] csr_io_ld_type; // @[pipeline.scala 34:26:@792.4]
  wire  csr_io_pc_check; // @[pipeline.scala 34:26:@792.4]
  wire  csr_io_expt; // @[pipeline.scala 34:26:@792.4]
  wire [31:0] csr_io_evec; // @[pipeline.scala 34:26:@792.4]
  wire [31:0] csr_io_epc; // @[pipeline.scala 34:26:@792.4]
  wire  csr_io_irq_uart_irq; // @[pipeline.scala 34:26:@792.4]
  wire  csr_io_irq_spi_irq; // @[pipeline.scala 34:26:@792.4]
  wire  csr_io_irq_m1_irq; // @[pipeline.scala 34:26:@792.4]
  wire  csr_io_irq_m2_irq; // @[pipeline.scala 34:26:@792.4]
  wire  csr_io_irq_m3_irq; // @[pipeline.scala 34:26:@792.4]
  wire  csr_io_br_taken; // @[pipeline.scala 34:26:@792.4]
  wire  reg_file_clock; // @[pipeline.scala 35:26:@795.4]
  wire [4:0] reg_file_io_raddr_1; // @[pipeline.scala 35:26:@795.4]
  wire [4:0] reg_file_io_raddr_2; // @[pipeline.scala 35:26:@795.4]
  wire [31:0] reg_file_io_rdata_1; // @[pipeline.scala 35:26:@795.4]
  wire [31:0] reg_file_io_rdata_2; // @[pipeline.scala 35:26:@795.4]
  wire  reg_file_io_wen; // @[pipeline.scala 35:26:@795.4]
  wire [4:0] reg_file_io_waddr; // @[pipeline.scala 35:26:@795.4]
  wire [31:0] reg_file_io_wdata; // @[pipeline.scala 35:26:@795.4]
  wire [31:0] alu_io_in_a; // @[pipeline.scala 36:26:@798.4]
  wire [31:0] alu_io_in_b; // @[pipeline.scala 36:26:@798.4]
  wire [3:0] alu_io_alu_op; // @[pipeline.scala 36:26:@798.4]
  wire [31:0] alu_io_out; // @[pipeline.scala 36:26:@798.4]
  wire [31:0] alu_io_sum; // @[pipeline.scala 36:26:@798.4]
  wire [31:0] gen_imm_io_inst; // @[pipeline.scala 37:26:@801.4]
  wire [2:0] gen_imm_io_imm_sel; // @[pipeline.scala 37:26:@801.4]
  wire [31:0] gen_imm_io_imm_out; // @[pipeline.scala 37:26:@801.4]
  wire [31:0] cond_br_io_in_a; // @[pipeline.scala 38:26:@804.4]
  wire [31:0] cond_br_io_in_b; // @[pipeline.scala 38:26:@804.4]
  wire [2:0] cond_br_io_br_type; // @[pipeline.scala 38:26:@804.4]
  wire  cond_br_io_br_taken; // @[pipeline.scala 38:26:@804.4]
  wire [1:0] lsu_io_lsu_st_type; // @[pipeline.scala 137:19:@923.4]
  wire [31:0] lsu_io_lsu_wdata_in; // @[pipeline.scala 137:19:@923.4]
  wire [31:0] lsu_io_lsu_wdata_out; // @[pipeline.scala 137:19:@923.4]
  wire [31:0] lsu_io_lsu_rdata_in; // @[pipeline.scala 137:19:@923.4]
  wire [31:0] lsu_io_lsu_rdata_out; // @[pipeline.scala 137:19:@923.4]
  wire [2:0] lsu_io_lsu_ld_type; // @[pipeline.scala 137:19:@923.4]
  reg [31:0] fet_exe_inst; // @[pipeline.scala 42:30:@807.4]
  reg [31:0] _RAND_0;
  reg [31:0] fet_exe_pc; // @[pipeline.scala 43:26:@808.4]
  reg [31:0] _RAND_1;
  reg [31:0] exe_wb_inst; // @[pipeline.scala 46:33:@809.4]
  reg [31:0] _RAND_2;
  reg [31:0] exe_wb_pc; // @[pipeline.scala 47:29:@810.4]
  reg [31:0] _RAND_3;
  reg [31:0] exe_wb_alu; // @[pipeline.scala 48:29:@811.4]
  reg [31:0] _RAND_4;
  reg [31:0] csr_in; // @[pipeline.scala 49:29:@812.4]
  reg [31:0] _RAND_5;
  reg [1:0] ctrl_st_type; // @[pipeline.scala 52:29:@813.4]
  reg [31:0] _RAND_6;
  reg [2:0] ctrl_ld_type; // @[pipeline.scala 53:29:@814.4]
  reg [31:0] _RAND_7;
  reg [1:0] ctrl_wb_mux_sel; // @[pipeline.scala 54:29:@815.4]
  reg [31:0] _RAND_8;
  reg  ctrl_wb_en; // @[pipeline.scala 55:29:@816.4]
  reg [31:0] _RAND_9;
  reg [2:0] ctrl_csr_cmd; // @[pipeline.scala 56:29:@817.4]
  reg [31:0] _RAND_10;
  reg  ctrl_illegal; // @[pipeline.scala 57:29:@818.4]
  reg [31:0] _RAND_11;
  reg  ctrl_pc_check; // @[pipeline.scala 58:29:@819.4]
  reg [31:0] _RAND_12;
  reg  notstarted; // @[pipeline.scala 61:27:@821.4]
  reg [31:0] _RAND_13;
  wire [32:0] _T_150; // @[pipeline.scala 64:57:@825.4]
  wire [32:0] _T_151; // @[pipeline.scala 64:57:@826.4]
  wire [31:0] _T_152; // @[pipeline.scala 64:57:@827.4]
  reg [31:0] pc; // @[pipeline.scala 64:27:@828.4]
  reg [31:0] _RAND_14;
  wire  _T_157; // @[pipeline.scala 66:33:@831.4]
  wire  _T_202; // @[pipeline.scala 113:39:@888.4]
  wire  _T_203; // @[pipeline.scala 113:59:@889.4]
  wire  _T_204; // @[pipeline.scala 113:43:@890.4]
  wire [4:0] rs1_addr; // @[pipeline.scala 91:37:@865.4]
  wire  _T_188; // @[pipeline.scala 103:47:@872.4]
  wire  _T_189; // @[pipeline.scala 103:35:@873.4]
  wire [4:0] wrbk_rd_addr; // @[pipeline.scala 102:35:@871.4]
  wire  _T_190; // @[pipeline.scala 103:64:@874.4]
  wire  rs1hazard; // @[pipeline.scala 103:51:@875.4]
  wire  _T_205; // @[pipeline.scala 113:90:@891.4]
  wire [4:0] rs2_addr; // @[pipeline.scala 92:37:@866.4]
  wire  _T_192; // @[pipeline.scala 104:47:@876.4]
  wire  _T_193; // @[pipeline.scala 104:35:@877.4]
  wire  _T_194; // @[pipeline.scala 104:64:@878.4]
  wire  rs2hazard; // @[pipeline.scala 104:51:@879.4]
  wire  _T_206; // @[pipeline.scala 113:123:@892.4]
  wire  _T_207; // @[pipeline.scala 113:104:@893.4]
  wire  hazard_stall; // @[pipeline.scala 113:70:@894.4]
  wire  _T_212; // @[pipeline.scala 117:57:@897.4]
  wire  is_load_store; // @[pipeline.scala 117:41:@898.4]
  wire  _T_215; // @[pipeline.scala 119:42:@901.4]
  wire  _T_217; // @[pipeline.scala 119:63:@902.4]
  wire  _T_218; // @[pipeline.scala 119:60:@903.4]
  wire  dmem_stall; // @[pipeline.scala 119:25:@904.4]
  wire  stall; // @[pipeline.scala 120:38:@906.4]
  wire  _T_158; // @[pipeline.scala 66:30:@832.4]
  wire  _T_159; // @[pipeline.scala 67:39:@833.4]
  wire  _T_160; // @[pipeline.scala 68:39:@834.4]
  wire  _T_161; // @[pipeline.scala 68:50:@835.4]
  wire [31:0] _T_163; // @[pipeline.scala 68:85:@836.4]
  wire [32:0] _GEN_28; // @[pipeline.scala 68:92:@837.4]
  wire [32:0] _T_165; // @[pipeline.scala 68:92:@837.4]
  wire  _T_166; // @[pipeline.scala 69:39:@838.4]
  wire [32:0] _T_168; // @[pipeline.scala 69:56:@839.4]
  wire [31:0] _T_169; // @[pipeline.scala 69:56:@840.4]
  wire [31:0] _T_170; // @[pipeline.scala 69:23:@841.4]
  wire [32:0] _T_171; // @[pipeline.scala 68:23:@842.4]
  wire [32:0] _T_172; // @[pipeline.scala 67:23:@843.4]
  wire [32:0] _T_173; // @[pipeline.scala 66:57:@844.4]
  wire [32:0] _T_174; // @[pipeline.scala 66:23:@845.4]
  wire  _T_175; // @[pipeline.scala 72:35:@847.4]
  wire  _T_176; // @[pipeline.scala 72:56:@848.4]
  wire  _T_177; // @[pipeline.scala 72:79:@849.4]
  wire  _T_180; // @[pipeline.scala 72:94:@851.4]
  wire [31:0] inst; // @[pipeline.scala 72:23:@852.4]
  wire  _T_183; // @[pipeline.scala 80:9:@855.4]
  wire  _T_184; // @[pipeline.scala 81:45:@857.6]
  wire  _T_185; // @[pipeline.scala 81:68:@858.6]
  wire [31:0] _T_186; // @[pipeline.scala 81:25:@859.6]
  wire [31:0] _GEN_1; // @[pipeline.scala 80:17:@856.4]
  wire  _T_195; // @[pipeline.scala 107:44:@880.4]
  wire  _T_196; // @[pipeline.scala 107:55:@881.4]
  wire [31:0] rs1; // @[pipeline.scala 107:27:@882.4]
  wire  _T_198; // @[pipeline.scala 108:55:@884.4]
  wire [31:0] rs2; // @[pipeline.scala 108:27:@885.4]
  wire  _T_225; // @[pipeline.scala 123:71:@909.4]
  wire  _T_236; // @[pipeline.scala 157:31:@937.4]
  wire  _T_237; // @[pipeline.scala 157:21:@938.4]
  wire  _T_247; // @[pipeline.scala 164:24:@949.6]
  wire  _T_248; // @[pipeline.scala 164:21:@950.6]
  wire  _T_249; // @[pipeline.scala 170:46:@955.8]
  wire [31:0] _T_250; // @[pipeline.scala 170:29:@956.8]
  wire [1:0] _GEN_2; // @[pipeline.scala 178:28:@968.8]
  wire [2:0] _GEN_3; // @[pipeline.scala 178:28:@968.8]
  wire  _GEN_4; // @[pipeline.scala 178:28:@968.8]
  wire [2:0] _GEN_5; // @[pipeline.scala 178:28:@968.8]
  wire [31:0] _GEN_6; // @[pipeline.scala 164:38:@951.6]
  wire [31:0] _GEN_7; // @[pipeline.scala 164:38:@951.6]
  wire [31:0] _GEN_8; // @[pipeline.scala 164:38:@951.6]
  wire [31:0] _GEN_9; // @[pipeline.scala 164:38:@951.6]
  wire [1:0] _GEN_10; // @[pipeline.scala 164:38:@951.6]
  wire [2:0] _GEN_11; // @[pipeline.scala 164:38:@951.6]
  wire [1:0] _GEN_12; // @[pipeline.scala 164:38:@951.6]
  wire  _GEN_13; // @[pipeline.scala 164:38:@951.6]
  wire [2:0] _GEN_14; // @[pipeline.scala 164:38:@951.6]
  wire  _GEN_15; // @[pipeline.scala 164:38:@951.6]
  wire  _GEN_16; // @[pipeline.scala 164:38:@951.6]
  wire [31:0] _GEN_24; // @[pipeline.scala 157:47:@939.4]
  wire [32:0] _T_253; // @[pipeline.scala 208:62:@990.4]
  wire [32:0] _T_255; // @[pipeline.scala 210:54:@991.4]
  wire [31:0] _T_256; // @[pipeline.scala 210:54:@992.4]
  wire [32:0] _T_257; // @[pipeline.scala 210:61:@993.4]
  wire [32:0] _T_258; // @[pipeline.scala 211:54:@994.4]
  wire  _T_259; // @[Mux.scala 46:19:@995.4]
  wire [32:0] _T_260; // @[Mux.scala 46:16:@996.4]
  wire  _T_261; // @[Mux.scala 46:19:@997.4]
  wire [32:0] _T_262; // @[Mux.scala 46:16:@998.4]
  wire  _T_263; // @[Mux.scala 46:19:@999.4]
  wire [32:0] _T_264; // @[Mux.scala 46:16:@1000.4]
  wire [32:0] reg_file_wdata; // @[pipeline.scala 211:62:@1001.4]
  wire [31:0] npc; // @[:@829.4 :@830.4 pipeline.scala 66:17:@846.4]
  CSR csr ( // @[pipeline.scala 34:26:@792.4]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_stall(csr_io_stall),
    .io_cmd(csr_io_cmd),
    .io_in(csr_io_in),
    .io_out(csr_io_out),
    .io_pc(csr_io_pc),
    .io_addr(csr_io_addr),
    .io_inst(csr_io_inst),
    .io_illegal(csr_io_illegal),
    .io_st_type(csr_io_st_type),
    .io_ld_type(csr_io_ld_type),
    .io_pc_check(csr_io_pc_check),
    .io_expt(csr_io_expt),
    .io_evec(csr_io_evec),
    .io_epc(csr_io_epc),
    .io_irq_uart_irq(csr_io_irq_uart_irq),
    .io_irq_spi_irq(csr_io_irq_spi_irq),
    .io_irq_m1_irq(csr_io_irq_m1_irq),
    .io_irq_m2_irq(csr_io_irq_m2_irq),
    .io_irq_m3_irq(csr_io_irq_m3_irq),
    .io_br_taken(csr_io_br_taken)
  );
  RegFile reg_file ( // @[pipeline.scala 35:26:@795.4]
    .clock(reg_file_clock),
    .io_raddr_1(reg_file_io_raddr_1),
    .io_raddr_2(reg_file_io_raddr_2),
    .io_rdata_1(reg_file_io_rdata_1),
    .io_rdata_2(reg_file_io_rdata_2),
    .io_wen(reg_file_io_wen),
    .io_waddr(reg_file_io_waddr),
    .io_wdata(reg_file_io_wdata)
  );
  ALU alu ( // @[pipeline.scala 36:26:@798.4]
    .io_in_a(alu_io_in_a),
    .io_in_b(alu_io_in_b),
    .io_alu_op(alu_io_alu_op),
    .io_out(alu_io_out),
    .io_sum(alu_io_sum)
  );
  Imm gen_imm ( // @[pipeline.scala 37:26:@801.4]
    .io_inst(gen_imm_io_inst),
    .io_imm_sel(gen_imm_io_imm_sel),
    .io_imm_out(gen_imm_io_imm_out)
  );
  Branch cond_br ( // @[pipeline.scala 38:26:@804.4]
    .io_in_a(cond_br_io_in_a),
    .io_in_b(cond_br_io_in_b),
    .io_br_type(cond_br_io_br_type),
    .io_br_taken(cond_br_io_br_taken)
  );
  LS_Unit lsu ( // @[pipeline.scala 137:19:@923.4]
    .io_lsu_st_type(lsu_io_lsu_st_type),
    .io_lsu_wdata_in(lsu_io_lsu_wdata_in),
    .io_lsu_wdata_out(lsu_io_lsu_wdata_out),
    .io_lsu_rdata_in(lsu_io_lsu_rdata_in),
    .io_lsu_rdata_out(lsu_io_lsu_rdata_out),
    .io_lsu_ld_type(lsu_io_lsu_ld_type)
  );
  assign _T_150 = 32'h7000 - 32'h4; // @[pipeline.scala 64:57:@825.4]
  assign _T_151 = $unsigned(_T_150); // @[pipeline.scala 64:57:@826.4]
  assign _T_152 = _T_151[31:0]; // @[pipeline.scala 64:57:@827.4]
  assign _T_157 = io_ibus_valid == 1'h0; // @[pipeline.scala 66:33:@831.4]
  assign _T_202 = ctrl_ld_type != 3'h0; // @[pipeline.scala 113:39:@888.4]
  assign _T_203 = ctrl_csr_cmd != 3'h0; // @[pipeline.scala 113:59:@889.4]
  assign _T_204 = _T_202 | _T_203; // @[pipeline.scala 113:43:@890.4]
  assign rs1_addr = fet_exe_inst[19:15]; // @[pipeline.scala 91:37:@865.4]
  assign _T_188 = rs1_addr != 5'h0; // @[pipeline.scala 103:47:@872.4]
  assign _T_189 = ctrl_wb_en & _T_188; // @[pipeline.scala 103:35:@873.4]
  assign wrbk_rd_addr = exe_wb_inst[11:7]; // @[pipeline.scala 102:35:@871.4]
  assign _T_190 = rs1_addr == wrbk_rd_addr; // @[pipeline.scala 103:64:@874.4]
  assign rs1hazard = _T_189 & _T_190; // @[pipeline.scala 103:51:@875.4]
  assign _T_205 = io_ctrl_en_rs1 & rs1hazard; // @[pipeline.scala 113:90:@891.4]
  assign rs2_addr = fet_exe_inst[24:20]; // @[pipeline.scala 92:37:@866.4]
  assign _T_192 = rs2_addr != 5'h0; // @[pipeline.scala 104:47:@876.4]
  assign _T_193 = ctrl_wb_en & _T_192; // @[pipeline.scala 104:35:@877.4]
  assign _T_194 = rs2_addr == wrbk_rd_addr; // @[pipeline.scala 104:64:@878.4]
  assign rs2hazard = _T_193 & _T_194; // @[pipeline.scala 104:51:@879.4]
  assign _T_206 = io_ctrl_en_rs2 & rs2hazard; // @[pipeline.scala 113:123:@892.4]
  assign _T_207 = _T_205 | _T_206; // @[pipeline.scala 113:104:@893.4]
  assign hazard_stall = _T_204 & _T_207; // @[pipeline.scala 113:70:@894.4]
  assign _T_212 = ctrl_st_type != 2'h0; // @[pipeline.scala 117:57:@897.4]
  assign is_load_store = _T_202 | _T_212; // @[pipeline.scala 117:41:@898.4]
  assign _T_215 = io_dbus_valid & is_load_store; // @[pipeline.scala 119:42:@901.4]
  assign _T_217 = is_load_store == 1'h0; // @[pipeline.scala 119:63:@902.4]
  assign _T_218 = _T_215 | _T_217; // @[pipeline.scala 119:60:@903.4]
  assign dmem_stall = _T_218 == 1'h0; // @[pipeline.scala 119:25:@904.4]
  assign stall = hazard_stall | dmem_stall; // @[pipeline.scala 120:38:@906.4]
  assign _T_158 = stall | _T_157; // @[pipeline.scala 66:30:@832.4]
  assign _T_159 = io_ctrl_pc_sel == 2'h3; // @[pipeline.scala 67:39:@833.4]
  assign _T_160 = io_ctrl_pc_sel == 2'h1; // @[pipeline.scala 68:39:@834.4]
  assign _T_161 = _T_160 | cond_br_io_br_taken; // @[pipeline.scala 68:50:@835.4]
  assign _T_163 = alu_io_sum >> 1'h1; // @[pipeline.scala 68:85:@836.4]
  assign _GEN_28 = {{1'd0}, _T_163}; // @[pipeline.scala 68:92:@837.4]
  assign _T_165 = _GEN_28 << 1'h1; // @[pipeline.scala 68:92:@837.4]
  assign _T_166 = io_ctrl_pc_sel == 2'h2; // @[pipeline.scala 69:39:@838.4]
  assign _T_168 = pc + 32'h4; // @[pipeline.scala 69:56:@839.4]
  assign _T_169 = pc + 32'h4; // @[pipeline.scala 69:56:@840.4]
  assign _T_170 = _T_166 ? pc : _T_169; // @[pipeline.scala 69:23:@841.4]
  assign _T_171 = _T_161 ? _T_165 : {{1'd0}, _T_170}; // @[pipeline.scala 68:23:@842.4]
  assign _T_172 = _T_159 ? {{1'd0}, csr_io_epc} : _T_171; // @[pipeline.scala 67:23:@843.4]
  assign _T_173 = csr_io_expt ? {{1'd0}, csr_io_evec} : _T_172; // @[pipeline.scala 66:57:@844.4]
  assign _T_174 = _T_158 ? {{1'd0}, pc} : _T_173; // @[pipeline.scala 66:23:@845.4]
  assign _T_175 = notstarted | io_ctrl_inst_kill; // @[pipeline.scala 72:35:@847.4]
  assign _T_176 = _T_175 | cond_br_io_br_taken; // @[pipeline.scala 72:56:@848.4]
  assign _T_177 = _T_176 | csr_io_expt; // @[pipeline.scala 72:79:@849.4]
  assign _T_180 = _T_177 | _T_157; // @[pipeline.scala 72:94:@851.4]
  assign inst = _T_180 ? 32'h13 : io_ibus_inst; // @[pipeline.scala 72:23:@852.4]
  assign _T_183 = stall == 1'h0; // @[pipeline.scala 80:9:@855.4]
  assign _T_184 = io_ctrl_inst_kill | cond_br_io_br_taken; // @[pipeline.scala 81:45:@857.6]
  assign _T_185 = _T_184 | csr_io_expt; // @[pipeline.scala 81:68:@858.6]
  assign _T_186 = _T_185 ? fet_exe_pc : pc; // @[pipeline.scala 81:25:@859.6]
  assign _GEN_1 = _T_183 ? inst : fet_exe_inst; // @[pipeline.scala 80:17:@856.4]
  assign _T_195 = ctrl_wb_mux_sel == 2'h0; // @[pipeline.scala 107:44:@880.4]
  assign _T_196 = _T_195 & rs1hazard; // @[pipeline.scala 107:55:@881.4]
  assign rs1 = _T_196 ? exe_wb_alu : reg_file_io_rdata_1; // @[pipeline.scala 107:27:@882.4]
  assign _T_198 = _T_195 & rs2hazard; // @[pipeline.scala 108:55:@884.4]
  assign rs2 = _T_198 ? exe_wb_alu : reg_file_io_rdata_2; // @[pipeline.scala 108:27:@885.4]
  assign _T_225 = io_ctrl_st_type != 2'h0; // @[pipeline.scala 123:71:@909.4]
  assign _T_236 = _T_183 & csr_io_expt; // @[pipeline.scala 157:31:@937.4]
  assign _T_237 = reset | _T_236; // @[pipeline.scala 157:21:@938.4]
  assign _T_247 = csr_io_expt == 1'h0; // @[pipeline.scala 164:24:@949.6]
  assign _T_248 = _T_183 & _T_247; // @[pipeline.scala 164:21:@950.6]
  assign _T_249 = io_ctrl_imm_sel == 3'h6; // @[pipeline.scala 170:46:@955.8]
  assign _T_250 = _T_249 ? gen_imm_io_imm_out : rs1; // @[pipeline.scala 170:29:@956.8]
  assign _GEN_2 = hazard_stall ? 2'h0 : ctrl_st_type; // @[pipeline.scala 178:28:@968.8]
  assign _GEN_3 = hazard_stall ? 3'h0 : ctrl_ld_type; // @[pipeline.scala 178:28:@968.8]
  assign _GEN_4 = hazard_stall ? 1'h0 : ctrl_wb_en; // @[pipeline.scala 178:28:@968.8]
  assign _GEN_5 = hazard_stall ? 3'h0 : ctrl_csr_cmd; // @[pipeline.scala 178:28:@968.8]
  assign _GEN_6 = _T_248 ? fet_exe_pc : exe_wb_pc; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_7 = _T_248 ? fet_exe_inst : exe_wb_inst; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_8 = _T_248 ? alu_io_out : exe_wb_alu; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_9 = _T_248 ? _T_250 : csr_in; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_10 = _T_248 ? io_ctrl_st_type : _GEN_2; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_11 = _T_248 ? io_ctrl_ld_type : _GEN_3; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_12 = _T_248 ? io_ctrl_wb_mux_sel : ctrl_wb_mux_sel; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_13 = _T_248 ? io_ctrl_wb_en : _GEN_4; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_14 = _T_248 ? io_ctrl_csr_cmd : _GEN_5; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_15 = _T_248 ? io_ctrl_illegal : ctrl_illegal; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_16 = _T_248 ? _T_160 : ctrl_pc_check; // @[pipeline.scala 164:38:@951.6]
  assign _GEN_24 = _T_237 ? exe_wb_inst : _GEN_7; // @[pipeline.scala 157:47:@939.4]
  assign _T_253 = {1'b0,$signed(exe_wb_alu)}; // @[pipeline.scala 208:62:@990.4]
  assign _T_255 = exe_wb_pc + 32'h4; // @[pipeline.scala 210:54:@991.4]
  assign _T_256 = exe_wb_pc + 32'h4; // @[pipeline.scala 210:54:@992.4]
  assign _T_257 = {1'b0,$signed(_T_256)}; // @[pipeline.scala 210:61:@993.4]
  assign _T_258 = {1'b0,$signed(csr_io_out)}; // @[pipeline.scala 211:54:@994.4]
  assign _T_259 = 2'h3 == ctrl_wb_mux_sel; // @[Mux.scala 46:19:@995.4]
  assign _T_260 = _T_259 ? $signed(_T_258) : $signed(_T_253); // @[Mux.scala 46:16:@996.4]
  assign _T_261 = 2'h2 == ctrl_wb_mux_sel; // @[Mux.scala 46:19:@997.4]
  assign _T_262 = _T_261 ? $signed(_T_257) : $signed(_T_260); // @[Mux.scala 46:16:@998.4]
  assign _T_263 = 2'h1 == ctrl_wb_mux_sel; // @[Mux.scala 46:19:@999.4]
  assign _T_264 = _T_263 ? $signed({{1{lsu_io_lsu_rdata_out[31]}},lsu_io_lsu_rdata_out}) : $signed(_T_262); // @[Mux.scala 46:16:@1000.4]
  assign reg_file_wdata = $unsigned(_T_264); // @[pipeline.scala 211:62:@1001.4]
  assign npc = _T_174[31:0]; // @[:@829.4 :@830.4 pipeline.scala 66:17:@846.4]
  assign io_ibus_addr = _T_174[31:0]; // @[pipeline.scala 75:18:@854.4]
  assign io_dbus_addr = alu_io_sum; // @[pipeline.scala 152:23:@934.4]
  assign io_dbus_wdata = lsu_io_lsu_wdata_out; // @[pipeline.scala 142:23:@928.4]
  assign io_dbus_rd_en = io_ctrl_ld_type != 3'h0; // @[pipeline.scala 145:23:@930.4]
  assign io_dbus_wr_en = hazard_stall ? 1'h0 : _T_225; // @[pipeline.scala 123:22:@911.4]
  assign io_dbus_st_type = io_ctrl_st_type; // @[pipeline.scala 124:22:@912.4]
  assign io_dbus_ld_type = io_ctrl_ld_type; // @[pipeline.scala 146:23:@931.4]
  assign io_ctrl_inst = fet_exe_inst; // @[pipeline.scala 87:22:@863.4]
  assign csr_clock = clock; // @[:@793.4]
  assign csr_reset = reset; // @[:@794.4]
  assign csr_io_stall = hazard_stall | dmem_stall; // @[pipeline.scala 190:20:@974.4]
  assign csr_io_cmd = ctrl_csr_cmd; // @[pipeline.scala 192:20:@976.4]
  assign csr_io_in = csr_in; // @[pipeline.scala 191:20:@975.4]
  assign csr_io_pc = exe_wb_pc; // @[pipeline.scala 194:20:@978.4]
  assign csr_io_addr = exe_wb_alu; // @[pipeline.scala 195:20:@979.4]
  assign csr_io_inst = exe_wb_inst; // @[pipeline.scala 193:20:@977.4]
  assign csr_io_illegal = ctrl_illegal; // @[pipeline.scala 196:20:@980.4]
  assign csr_io_st_type = ctrl_st_type; // @[pipeline.scala 199:20:@983.4]
  assign csr_io_ld_type = ctrl_ld_type; // @[pipeline.scala 198:20:@982.4]
  assign csr_io_pc_check = ctrl_pc_check; // @[pipeline.scala 197:20:@981.4]
  assign csr_io_irq_uart_irq = io_irq_uart_irq; // @[pipeline.scala 203:20:@989.4]
  assign csr_io_irq_spi_irq = io_irq_spi_irq; // @[pipeline.scala 203:20:@988.4]
  assign csr_io_irq_m1_irq = io_irq_m1_irq; // @[pipeline.scala 203:20:@987.4]
  assign csr_io_irq_m2_irq = io_irq_m2_irq; // @[pipeline.scala 203:20:@986.4]
  assign csr_io_irq_m3_irq = io_irq_m3_irq; // @[pipeline.scala 203:20:@985.4]
  assign csr_io_br_taken = cond_br_io_br_taken; // @[pipeline.scala 200:20:@984.4]
  assign reg_file_clock = clock; // @[:@796.4]
  assign reg_file_io_raddr_1 = fet_exe_inst[19:15]; // @[pipeline.scala 93:23:@867.4]
  assign reg_file_io_raddr_2 = fet_exe_inst[24:20]; // @[pipeline.scala 94:23:@868.4]
  assign reg_file_io_wen = ctrl_wb_en & _T_247; // @[pipeline.scala 213:22:@1004.4]
  assign reg_file_io_waddr = exe_wb_inst[11:7]; // @[pipeline.scala 214:22:@1005.4]
  assign reg_file_io_wdata = reg_file_wdata[31:0]; // @[pipeline.scala 215:22:@1006.4]
  assign alu_io_in_a = io_ctrl_a_sel ? rs1 : fet_exe_pc; // @[pipeline.scala 127:22:@915.4]
  assign alu_io_in_b = io_ctrl_b_sel ? rs2 : gen_imm_io_imm_out; // @[pipeline.scala 128:22:@918.4]
  assign alu_io_alu_op = io_ctrl_alu_op[3:0]; // @[pipeline.scala 129:22:@919.4]
  assign gen_imm_io_inst = fet_exe_inst; // @[pipeline.scala 97:22:@869.4]
  assign gen_imm_io_imm_sel = io_ctrl_imm_sel; // @[pipeline.scala 98:26:@870.4]
  assign cond_br_io_in_a = _T_196 ? exe_wb_alu : reg_file_io_rdata_1; // @[pipeline.scala 132:23:@920.4]
  assign cond_br_io_in_b = _T_198 ? exe_wb_alu : reg_file_io_rdata_2; // @[pipeline.scala 133:23:@921.4]
  assign cond_br_io_br_type = io_ctrl_br_type; // @[pipeline.scala 134:22:@922.4]
  assign lsu_io_lsu_st_type = io_ctrl_st_type; // @[pipeline.scala 140:23:@926.4]
  assign lsu_io_lsu_wdata_in = _T_198 ? exe_wb_alu : reg_file_io_rdata_2; // @[pipeline.scala 141:23:@927.4]
  assign lsu_io_lsu_rdata_in = io_dbus_rdata; // @[pipeline.scala 148:23:@933.4]
  assign lsu_io_lsu_ld_type = ctrl_ld_type; // @[pipeline.scala 147:23:@932.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fet_exe_inst = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  fet_exe_pc = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  exe_wb_inst = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  exe_wb_pc = _RAND_3[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  exe_wb_alu = _RAND_4[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  csr_in = _RAND_5[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  ctrl_st_type = _RAND_6[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  ctrl_ld_type = _RAND_7[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  ctrl_wb_mux_sel = _RAND_8[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  ctrl_wb_en = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  ctrl_csr_cmd = _RAND_10[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  ctrl_illegal = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  ctrl_pc_check = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  notstarted = _RAND_13[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  pc = _RAND_14[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      fet_exe_inst <= 32'h13;
    end else begin
      if (_T_183) begin
        if (_T_180) begin
          fet_exe_inst <= 32'h13;
        end else begin
          fet_exe_inst <= io_ibus_inst;
        end
      end
    end
    if (_T_183) begin
      if (!(_T_185)) begin
        fet_exe_pc <= pc;
      end
    end
    if (reset) begin
      exe_wb_inst <= 32'h13;
    end else begin
      if (!(_T_237)) begin
        if (_T_248) begin
          exe_wb_inst <= fet_exe_inst;
        end
      end
    end
    if (!(_T_237)) begin
      if (_T_248) begin
        exe_wb_pc <= fet_exe_pc;
      end
    end
    if (!(_T_237)) begin
      if (_T_248) begin
        exe_wb_alu <= alu_io_out;
      end
    end
    if (!(_T_237)) begin
      if (_T_248) begin
        if (_T_249) begin
          csr_in <= gen_imm_io_imm_out;
        end else begin
          if (_T_196) begin
            csr_in <= exe_wb_alu;
          end else begin
            csr_in <= reg_file_io_rdata_1;
          end
        end
      end
    end
    if (_T_237) begin
      ctrl_st_type <= 2'h0;
    end else begin
      if (_T_248) begin
        ctrl_st_type <= io_ctrl_st_type;
      end else begin
        if (hazard_stall) begin
          ctrl_st_type <= 2'h0;
        end
      end
    end
    if (_T_237) begin
      ctrl_ld_type <= 3'h0;
    end else begin
      if (_T_248) begin
        ctrl_ld_type <= io_ctrl_ld_type;
      end else begin
        if (hazard_stall) begin
          ctrl_ld_type <= 3'h0;
        end
      end
    end
    if (!(_T_237)) begin
      if (_T_248) begin
        ctrl_wb_mux_sel <= io_ctrl_wb_mux_sel;
      end
    end
    if (_T_237) begin
      ctrl_wb_en <= 1'h0;
    end else begin
      if (_T_248) begin
        ctrl_wb_en <= io_ctrl_wb_en;
      end else begin
        if (hazard_stall) begin
          ctrl_wb_en <= 1'h0;
        end
      end
    end
    if (_T_237) begin
      ctrl_csr_cmd <= 3'h0;
    end else begin
      if (_T_248) begin
        ctrl_csr_cmd <= io_ctrl_csr_cmd;
      end else begin
        if (hazard_stall) begin
          ctrl_csr_cmd <= 3'h0;
        end
      end
    end
    if (_T_237) begin
      ctrl_illegal <= 1'h0;
    end else begin
      if (_T_248) begin
        ctrl_illegal <= io_ctrl_illegal;
      end
    end
    if (_T_237) begin
      ctrl_pc_check <= 1'h0;
    end else begin
      if (_T_248) begin
        ctrl_pc_check <= _T_160;
      end
    end
    notstarted <= reset;
    if (reset) begin
      pc <= _T_152;
    end else begin
      pc <= npc;
    end
  end
endmodule
module Control( // @[:@1008.2]
  input  [31:0] io_inst, // @[:@1011.4]
  output [1:0]  io_pc_sel, // @[:@1011.4]
  output        io_inst_kill, // @[:@1011.4]
  output        io_a_sel, // @[:@1011.4]
  output        io_b_sel, // @[:@1011.4]
  output [2:0]  io_imm_sel, // @[:@1011.4]
  output [4:0]  io_alu_op, // @[:@1011.4]
  output [2:0]  io_br_type, // @[:@1011.4]
  output [1:0]  io_st_type, // @[:@1011.4]
  output [2:0]  io_ld_type, // @[:@1011.4]
  output [1:0]  io_wb_mux_sel, // @[:@1011.4]
  output        io_wb_en, // @[:@1011.4]
  output [2:0]  io_csr_cmd, // @[:@1011.4]
  output        io_illegal, // @[:@1011.4]
  output        io_en_rs1, // @[:@1011.4]
  output        io_en_rs2 // @[:@1011.4]
);
  wire [31:0] _T_39; // @[Lookup.scala 9:38:@1013.4]
  wire  _T_40; // @[Lookup.scala 9:38:@1014.4]
  wire  _T_44; // @[Lookup.scala 9:38:@1016.4]
  wire  _T_48; // @[Lookup.scala 9:38:@1018.4]
  wire [31:0] _T_51; // @[Lookup.scala 9:38:@1019.4]
  wire  _T_52; // @[Lookup.scala 9:38:@1020.4]
  wire  _T_56; // @[Lookup.scala 9:38:@1022.4]
  wire  _T_60; // @[Lookup.scala 9:38:@1024.4]
  wire  _T_64; // @[Lookup.scala 9:38:@1026.4]
  wire  _T_68; // @[Lookup.scala 9:38:@1028.4]
  wire  _T_72; // @[Lookup.scala 9:38:@1030.4]
  wire  _T_76; // @[Lookup.scala 9:38:@1032.4]
  wire  _T_80; // @[Lookup.scala 9:38:@1034.4]
  wire  _T_84; // @[Lookup.scala 9:38:@1036.4]
  wire  _T_88; // @[Lookup.scala 9:38:@1038.4]
  wire  _T_92; // @[Lookup.scala 9:38:@1040.4]
  wire  _T_96; // @[Lookup.scala 9:38:@1042.4]
  wire  _T_100; // @[Lookup.scala 9:38:@1044.4]
  wire  _T_104; // @[Lookup.scala 9:38:@1046.4]
  wire  _T_108; // @[Lookup.scala 9:38:@1048.4]
  wire  _T_112; // @[Lookup.scala 9:38:@1050.4]
  wire  _T_116; // @[Lookup.scala 9:38:@1052.4]
  wire  _T_120; // @[Lookup.scala 9:38:@1054.4]
  wire  _T_124; // @[Lookup.scala 9:38:@1056.4]
  wire  _T_128; // @[Lookup.scala 9:38:@1058.4]
  wire  _T_132; // @[Lookup.scala 9:38:@1060.4]
  wire [31:0] _T_135; // @[Lookup.scala 9:38:@1061.4]
  wire  _T_136; // @[Lookup.scala 9:38:@1062.4]
  wire  _T_140; // @[Lookup.scala 9:38:@1064.4]
  wire  _T_144; // @[Lookup.scala 9:38:@1066.4]
  wire  _T_148; // @[Lookup.scala 9:38:@1068.4]
  wire  _T_152; // @[Lookup.scala 9:38:@1070.4]
  wire  _T_156; // @[Lookup.scala 9:38:@1072.4]
  wire  _T_160; // @[Lookup.scala 9:38:@1074.4]
  wire  _T_164; // @[Lookup.scala 9:38:@1076.4]
  wire  _T_168; // @[Lookup.scala 9:38:@1078.4]
  wire  _T_172; // @[Lookup.scala 9:38:@1080.4]
  wire  _T_176; // @[Lookup.scala 9:38:@1082.4]
  wire  _T_180; // @[Lookup.scala 9:38:@1084.4]
  wire  _T_184; // @[Lookup.scala 9:38:@1086.4]
  wire [31:0] _T_187; // @[Lookup.scala 9:38:@1087.4]
  wire  _T_188; // @[Lookup.scala 9:38:@1088.4]
  wire  _T_192; // @[Lookup.scala 9:38:@1090.4]
  wire  _T_196; // @[Lookup.scala 9:38:@1092.4]
  wire  _T_200; // @[Lookup.scala 9:38:@1094.4]
  wire  _T_204; // @[Lookup.scala 9:38:@1096.4]
  wire  _T_208; // @[Lookup.scala 9:38:@1098.4]
  wire  _T_212; // @[Lookup.scala 9:38:@1100.4]
  wire  _T_216; // @[Lookup.scala 9:38:@1102.4]
  wire  _T_220; // @[Lookup.scala 9:38:@1104.4]
  wire  _T_224; // @[Lookup.scala 9:38:@1106.4]
  wire  _T_228; // @[Lookup.scala 9:38:@1108.4]
  wire  _T_232; // @[Lookup.scala 9:38:@1110.4]
  wire [1:0] _T_234; // @[Lookup.scala 11:37:@1112.4]
  wire [1:0] _T_235; // @[Lookup.scala 11:37:@1113.4]
  wire [1:0] _T_236; // @[Lookup.scala 11:37:@1114.4]
  wire [1:0] _T_237; // @[Lookup.scala 11:37:@1115.4]
  wire [1:0] _T_238; // @[Lookup.scala 11:37:@1116.4]
  wire [1:0] _T_239; // @[Lookup.scala 11:37:@1117.4]
  wire [1:0] _T_240; // @[Lookup.scala 11:37:@1118.4]
  wire [1:0] _T_241; // @[Lookup.scala 11:37:@1119.4]
  wire [1:0] _T_242; // @[Lookup.scala 11:37:@1120.4]
  wire [1:0] _T_243; // @[Lookup.scala 11:37:@1121.4]
  wire [1:0] _T_244; // @[Lookup.scala 11:37:@1122.4]
  wire [1:0] _T_245; // @[Lookup.scala 11:37:@1123.4]
  wire [1:0] _T_246; // @[Lookup.scala 11:37:@1124.4]
  wire [1:0] _T_247; // @[Lookup.scala 11:37:@1125.4]
  wire [1:0] _T_248; // @[Lookup.scala 11:37:@1126.4]
  wire [1:0] _T_249; // @[Lookup.scala 11:37:@1127.4]
  wire [1:0] _T_250; // @[Lookup.scala 11:37:@1128.4]
  wire [1:0] _T_251; // @[Lookup.scala 11:37:@1129.4]
  wire [1:0] _T_252; // @[Lookup.scala 11:37:@1130.4]
  wire [1:0] _T_253; // @[Lookup.scala 11:37:@1131.4]
  wire [1:0] _T_254; // @[Lookup.scala 11:37:@1132.4]
  wire [1:0] _T_255; // @[Lookup.scala 11:37:@1133.4]
  wire [1:0] _T_256; // @[Lookup.scala 11:37:@1134.4]
  wire [1:0] _T_257; // @[Lookup.scala 11:37:@1135.4]
  wire [1:0] _T_258; // @[Lookup.scala 11:37:@1136.4]
  wire [1:0] _T_259; // @[Lookup.scala 11:37:@1137.4]
  wire [1:0] _T_260; // @[Lookup.scala 11:37:@1138.4]
  wire [1:0] _T_261; // @[Lookup.scala 11:37:@1139.4]
  wire [1:0] _T_262; // @[Lookup.scala 11:37:@1140.4]
  wire [1:0] _T_263; // @[Lookup.scala 11:37:@1141.4]
  wire [1:0] _T_264; // @[Lookup.scala 11:37:@1142.4]
  wire [1:0] _T_265; // @[Lookup.scala 11:37:@1143.4]
  wire [1:0] _T_266; // @[Lookup.scala 11:37:@1144.4]
  wire [1:0] _T_267; // @[Lookup.scala 11:37:@1145.4]
  wire [1:0] _T_268; // @[Lookup.scala 11:37:@1146.4]
  wire [1:0] _T_269; // @[Lookup.scala 11:37:@1147.4]
  wire [1:0] _T_270; // @[Lookup.scala 11:37:@1148.4]
  wire [1:0] _T_271; // @[Lookup.scala 11:37:@1149.4]
  wire [1:0] _T_272; // @[Lookup.scala 11:37:@1150.4]
  wire [1:0] _T_273; // @[Lookup.scala 11:37:@1151.4]
  wire [1:0] _T_274; // @[Lookup.scala 11:37:@1152.4]
  wire [1:0] _T_275; // @[Lookup.scala 11:37:@1153.4]
  wire [1:0] _T_276; // @[Lookup.scala 11:37:@1154.4]
  wire [1:0] _T_277; // @[Lookup.scala 11:37:@1155.4]
  wire [1:0] _T_278; // @[Lookup.scala 11:37:@1156.4]
  wire [1:0] _T_279; // @[Lookup.scala 11:37:@1157.4]
  wire [1:0] _T_280; // @[Lookup.scala 11:37:@1158.4]
  wire  _T_289; // @[Lookup.scala 11:37:@1168.4]
  wire  _T_290; // @[Lookup.scala 11:37:@1169.4]
  wire  _T_291; // @[Lookup.scala 11:37:@1170.4]
  wire  _T_292; // @[Lookup.scala 11:37:@1171.4]
  wire  _T_293; // @[Lookup.scala 11:37:@1172.4]
  wire  _T_294; // @[Lookup.scala 11:37:@1173.4]
  wire  _T_295; // @[Lookup.scala 11:37:@1174.4]
  wire  _T_296; // @[Lookup.scala 11:37:@1175.4]
  wire  _T_297; // @[Lookup.scala 11:37:@1176.4]
  wire  _T_298; // @[Lookup.scala 11:37:@1177.4]
  wire  _T_299; // @[Lookup.scala 11:37:@1178.4]
  wire  _T_300; // @[Lookup.scala 11:37:@1179.4]
  wire  _T_301; // @[Lookup.scala 11:37:@1180.4]
  wire  _T_302; // @[Lookup.scala 11:37:@1181.4]
  wire  _T_303; // @[Lookup.scala 11:37:@1182.4]
  wire  _T_304; // @[Lookup.scala 11:37:@1183.4]
  wire  _T_305; // @[Lookup.scala 11:37:@1184.4]
  wire  _T_306; // @[Lookup.scala 11:37:@1185.4]
  wire  _T_307; // @[Lookup.scala 11:37:@1186.4]
  wire  _T_308; // @[Lookup.scala 11:37:@1187.4]
  wire  _T_309; // @[Lookup.scala 11:37:@1188.4]
  wire  _T_310; // @[Lookup.scala 11:37:@1189.4]
  wire  _T_311; // @[Lookup.scala 11:37:@1190.4]
  wire  _T_312; // @[Lookup.scala 11:37:@1191.4]
  wire  _T_313; // @[Lookup.scala 11:37:@1192.4]
  wire  _T_314; // @[Lookup.scala 11:37:@1193.4]
  wire  _T_315; // @[Lookup.scala 11:37:@1194.4]
  wire  _T_316; // @[Lookup.scala 11:37:@1195.4]
  wire  _T_317; // @[Lookup.scala 11:37:@1196.4]
  wire  _T_318; // @[Lookup.scala 11:37:@1197.4]
  wire  _T_319; // @[Lookup.scala 11:37:@1198.4]
  wire  _T_320; // @[Lookup.scala 11:37:@1199.4]
  wire  _T_321; // @[Lookup.scala 11:37:@1200.4]
  wire  _T_322; // @[Lookup.scala 11:37:@1201.4]
  wire  _T_323; // @[Lookup.scala 11:37:@1202.4]
  wire  _T_324; // @[Lookup.scala 11:37:@1203.4]
  wire  _T_325; // @[Lookup.scala 11:37:@1204.4]
  wire  _T_326; // @[Lookup.scala 11:37:@1205.4]
  wire  _T_327; // @[Lookup.scala 11:37:@1206.4]
  wire  _T_328; // @[Lookup.scala 11:37:@1207.4]
  wire  _T_342; // @[Lookup.scala 11:37:@1222.4]
  wire  _T_343; // @[Lookup.scala 11:37:@1223.4]
  wire  _T_344; // @[Lookup.scala 11:37:@1224.4]
  wire  _T_345; // @[Lookup.scala 11:37:@1225.4]
  wire  _T_346; // @[Lookup.scala 11:37:@1226.4]
  wire  _T_347; // @[Lookup.scala 11:37:@1227.4]
  wire  _T_348; // @[Lookup.scala 11:37:@1228.4]
  wire  _T_349; // @[Lookup.scala 11:37:@1229.4]
  wire  _T_350; // @[Lookup.scala 11:37:@1230.4]
  wire  _T_351; // @[Lookup.scala 11:37:@1231.4]
  wire  _T_352; // @[Lookup.scala 11:37:@1232.4]
  wire  _T_353; // @[Lookup.scala 11:37:@1233.4]
  wire  _T_354; // @[Lookup.scala 11:37:@1234.4]
  wire  _T_355; // @[Lookup.scala 11:37:@1235.4]
  wire  _T_356; // @[Lookup.scala 11:37:@1236.4]
  wire  _T_357; // @[Lookup.scala 11:37:@1237.4]
  wire  _T_358; // @[Lookup.scala 11:37:@1238.4]
  wire  _T_359; // @[Lookup.scala 11:37:@1239.4]
  wire  _T_360; // @[Lookup.scala 11:37:@1240.4]
  wire  _T_361; // @[Lookup.scala 11:37:@1241.4]
  wire  _T_362; // @[Lookup.scala 11:37:@1242.4]
  wire  _T_363; // @[Lookup.scala 11:37:@1243.4]
  wire  _T_364; // @[Lookup.scala 11:37:@1244.4]
  wire  _T_365; // @[Lookup.scala 11:37:@1245.4]
  wire  _T_366; // @[Lookup.scala 11:37:@1246.4]
  wire  _T_367; // @[Lookup.scala 11:37:@1247.4]
  wire  _T_368; // @[Lookup.scala 11:37:@1248.4]
  wire  _T_369; // @[Lookup.scala 11:37:@1249.4]
  wire  _T_370; // @[Lookup.scala 11:37:@1250.4]
  wire  _T_371; // @[Lookup.scala 11:37:@1251.4]
  wire  _T_372; // @[Lookup.scala 11:37:@1252.4]
  wire  _T_373; // @[Lookup.scala 11:37:@1253.4]
  wire  _T_374; // @[Lookup.scala 11:37:@1254.4]
  wire  _T_375; // @[Lookup.scala 11:37:@1255.4]
  wire  _T_376; // @[Lookup.scala 11:37:@1256.4]
  wire [2:0] _T_381; // @[Lookup.scala 11:37:@1262.4]
  wire [2:0] _T_382; // @[Lookup.scala 11:37:@1263.4]
  wire [2:0] _T_383; // @[Lookup.scala 11:37:@1264.4]
  wire [2:0] _T_384; // @[Lookup.scala 11:37:@1265.4]
  wire [2:0] _T_385; // @[Lookup.scala 11:37:@1266.4]
  wire [2:0] _T_386; // @[Lookup.scala 11:37:@1267.4]
  wire [2:0] _T_387; // @[Lookup.scala 11:37:@1268.4]
  wire [2:0] _T_388; // @[Lookup.scala 11:37:@1269.4]
  wire [2:0] _T_389; // @[Lookup.scala 11:37:@1270.4]
  wire [2:0] _T_390; // @[Lookup.scala 11:37:@1271.4]
  wire [2:0] _T_391; // @[Lookup.scala 11:37:@1272.4]
  wire [2:0] _T_392; // @[Lookup.scala 11:37:@1273.4]
  wire [2:0] _T_393; // @[Lookup.scala 11:37:@1274.4]
  wire [2:0] _T_394; // @[Lookup.scala 11:37:@1275.4]
  wire [2:0] _T_395; // @[Lookup.scala 11:37:@1276.4]
  wire [2:0] _T_396; // @[Lookup.scala 11:37:@1277.4]
  wire [2:0] _T_397; // @[Lookup.scala 11:37:@1278.4]
  wire [2:0] _T_398; // @[Lookup.scala 11:37:@1279.4]
  wire [2:0] _T_399; // @[Lookup.scala 11:37:@1280.4]
  wire [2:0] _T_400; // @[Lookup.scala 11:37:@1281.4]
  wire [2:0] _T_401; // @[Lookup.scala 11:37:@1282.4]
  wire [2:0] _T_402; // @[Lookup.scala 11:37:@1283.4]
  wire [2:0] _T_403; // @[Lookup.scala 11:37:@1284.4]
  wire [2:0] _T_404; // @[Lookup.scala 11:37:@1285.4]
  wire [2:0] _T_405; // @[Lookup.scala 11:37:@1286.4]
  wire [2:0] _T_406; // @[Lookup.scala 11:37:@1287.4]
  wire [2:0] _T_407; // @[Lookup.scala 11:37:@1288.4]
  wire [2:0] _T_408; // @[Lookup.scala 11:37:@1289.4]
  wire [2:0] _T_409; // @[Lookup.scala 11:37:@1290.4]
  wire [2:0] _T_410; // @[Lookup.scala 11:37:@1291.4]
  wire [2:0] _T_411; // @[Lookup.scala 11:37:@1292.4]
  wire [2:0] _T_412; // @[Lookup.scala 11:37:@1293.4]
  wire [2:0] _T_413; // @[Lookup.scala 11:37:@1294.4]
  wire [2:0] _T_414; // @[Lookup.scala 11:37:@1295.4]
  wire [2:0] _T_415; // @[Lookup.scala 11:37:@1296.4]
  wire [2:0] _T_416; // @[Lookup.scala 11:37:@1297.4]
  wire [2:0] _T_417; // @[Lookup.scala 11:37:@1298.4]
  wire [2:0] _T_418; // @[Lookup.scala 11:37:@1299.4]
  wire [2:0] _T_419; // @[Lookup.scala 11:37:@1300.4]
  wire [2:0] _T_420; // @[Lookup.scala 11:37:@1301.4]
  wire [2:0] _T_421; // @[Lookup.scala 11:37:@1302.4]
  wire [2:0] _T_422; // @[Lookup.scala 11:37:@1303.4]
  wire [2:0] _T_423; // @[Lookup.scala 11:37:@1304.4]
  wire [2:0] _T_424; // @[Lookup.scala 11:37:@1305.4]
  wire [3:0] _T_432; // @[Lookup.scala 11:37:@1314.4]
  wire [3:0] _T_433; // @[Lookup.scala 11:37:@1315.4]
  wire [3:0] _T_434; // @[Lookup.scala 11:37:@1316.4]
  wire [3:0] _T_435; // @[Lookup.scala 11:37:@1317.4]
  wire [3:0] _T_436; // @[Lookup.scala 11:37:@1318.4]
  wire [3:0] _T_437; // @[Lookup.scala 11:37:@1319.4]
  wire [3:0] _T_438; // @[Lookup.scala 11:37:@1320.4]
  wire [3:0] _T_439; // @[Lookup.scala 11:37:@1321.4]
  wire [3:0] _T_440; // @[Lookup.scala 11:37:@1322.4]
  wire [3:0] _T_441; // @[Lookup.scala 11:37:@1323.4]
  wire [3:0] _T_442; // @[Lookup.scala 11:37:@1324.4]
  wire [3:0] _T_443; // @[Lookup.scala 11:37:@1325.4]
  wire [3:0] _T_444; // @[Lookup.scala 11:37:@1326.4]
  wire [3:0] _T_445; // @[Lookup.scala 11:37:@1327.4]
  wire [3:0] _T_446; // @[Lookup.scala 11:37:@1328.4]
  wire [3:0] _T_447; // @[Lookup.scala 11:37:@1329.4]
  wire [3:0] _T_448; // @[Lookup.scala 11:37:@1330.4]
  wire [3:0] _T_449; // @[Lookup.scala 11:37:@1331.4]
  wire [3:0] _T_450; // @[Lookup.scala 11:37:@1332.4]
  wire [3:0] _T_451; // @[Lookup.scala 11:37:@1333.4]
  wire [3:0] _T_452; // @[Lookup.scala 11:37:@1334.4]
  wire [3:0] _T_453; // @[Lookup.scala 11:37:@1335.4]
  wire [3:0] _T_454; // @[Lookup.scala 11:37:@1336.4]
  wire [3:0] _T_455; // @[Lookup.scala 11:37:@1337.4]
  wire [3:0] _T_456; // @[Lookup.scala 11:37:@1338.4]
  wire [3:0] _T_457; // @[Lookup.scala 11:37:@1339.4]
  wire [3:0] _T_458; // @[Lookup.scala 11:37:@1340.4]
  wire [3:0] _T_459; // @[Lookup.scala 11:37:@1341.4]
  wire [3:0] _T_460; // @[Lookup.scala 11:37:@1342.4]
  wire [3:0] _T_461; // @[Lookup.scala 11:37:@1343.4]
  wire [3:0] _T_462; // @[Lookup.scala 11:37:@1344.4]
  wire [3:0] _T_463; // @[Lookup.scala 11:37:@1345.4]
  wire [3:0] _T_464; // @[Lookup.scala 11:37:@1346.4]
  wire [3:0] _T_465; // @[Lookup.scala 11:37:@1347.4]
  wire [3:0] _T_466; // @[Lookup.scala 11:37:@1348.4]
  wire [3:0] _T_467; // @[Lookup.scala 11:37:@1349.4]
  wire [3:0] _T_468; // @[Lookup.scala 11:37:@1350.4]
  wire [3:0] _T_469; // @[Lookup.scala 11:37:@1351.4]
  wire [3:0] _T_470; // @[Lookup.scala 11:37:@1352.4]
  wire [3:0] _T_471; // @[Lookup.scala 11:37:@1353.4]
  wire [3:0] _T_472; // @[Lookup.scala 11:37:@1354.4]
  wire [3:0] ctrlSignals_4; // @[Lookup.scala 11:37:@1355.4]
  wire [2:0] _T_512; // @[Lookup.scala 11:37:@1395.4]
  wire [2:0] _T_513; // @[Lookup.scala 11:37:@1396.4]
  wire [2:0] _T_514; // @[Lookup.scala 11:37:@1397.4]
  wire [2:0] _T_515; // @[Lookup.scala 11:37:@1398.4]
  wire [2:0] _T_516; // @[Lookup.scala 11:37:@1399.4]
  wire [2:0] _T_517; // @[Lookup.scala 11:37:@1400.4]
  wire [2:0] _T_518; // @[Lookup.scala 11:37:@1401.4]
  wire [2:0] _T_519; // @[Lookup.scala 11:37:@1402.4]
  wire [2:0] _T_520; // @[Lookup.scala 11:37:@1403.4]
  wire  _T_523; // @[Lookup.scala 11:37:@1407.4]
  wire  _T_524; // @[Lookup.scala 11:37:@1408.4]
  wire  _T_525; // @[Lookup.scala 11:37:@1409.4]
  wire  _T_526; // @[Lookup.scala 11:37:@1410.4]
  wire  _T_527; // @[Lookup.scala 11:37:@1411.4]
  wire  _T_528; // @[Lookup.scala 11:37:@1412.4]
  wire  _T_529; // @[Lookup.scala 11:37:@1413.4]
  wire  _T_530; // @[Lookup.scala 11:37:@1414.4]
  wire  _T_531; // @[Lookup.scala 11:37:@1415.4]
  wire  _T_532; // @[Lookup.scala 11:37:@1416.4]
  wire  _T_533; // @[Lookup.scala 11:37:@1417.4]
  wire  _T_534; // @[Lookup.scala 11:37:@1418.4]
  wire  _T_535; // @[Lookup.scala 11:37:@1419.4]
  wire  _T_536; // @[Lookup.scala 11:37:@1420.4]
  wire  _T_537; // @[Lookup.scala 11:37:@1421.4]
  wire  _T_538; // @[Lookup.scala 11:37:@1422.4]
  wire  _T_539; // @[Lookup.scala 11:37:@1423.4]
  wire  _T_540; // @[Lookup.scala 11:37:@1424.4]
  wire  _T_541; // @[Lookup.scala 11:37:@1425.4]
  wire  _T_542; // @[Lookup.scala 11:37:@1426.4]
  wire  _T_543; // @[Lookup.scala 11:37:@1427.4]
  wire  _T_544; // @[Lookup.scala 11:37:@1428.4]
  wire  _T_545; // @[Lookup.scala 11:37:@1429.4]
  wire  _T_546; // @[Lookup.scala 11:37:@1430.4]
  wire  _T_547; // @[Lookup.scala 11:37:@1431.4]
  wire  _T_548; // @[Lookup.scala 11:37:@1432.4]
  wire  _T_549; // @[Lookup.scala 11:37:@1433.4]
  wire  _T_550; // @[Lookup.scala 11:37:@1434.4]
  wire  _T_551; // @[Lookup.scala 11:37:@1435.4]
  wire  _T_552; // @[Lookup.scala 11:37:@1436.4]
  wire  _T_553; // @[Lookup.scala 11:37:@1437.4]
  wire  _T_554; // @[Lookup.scala 11:37:@1438.4]
  wire  _T_555; // @[Lookup.scala 11:37:@1439.4]
  wire  _T_556; // @[Lookup.scala 11:37:@1440.4]
  wire  _T_557; // @[Lookup.scala 11:37:@1441.4]
  wire  _T_558; // @[Lookup.scala 11:37:@1442.4]
  wire  _T_559; // @[Lookup.scala 11:37:@1443.4]
  wire  _T_560; // @[Lookup.scala 11:37:@1444.4]
  wire  _T_561; // @[Lookup.scala 11:37:@1445.4]
  wire  _T_562; // @[Lookup.scala 11:37:@1446.4]
  wire  _T_563; // @[Lookup.scala 11:37:@1447.4]
  wire  _T_564; // @[Lookup.scala 11:37:@1448.4]
  wire  _T_565; // @[Lookup.scala 11:37:@1449.4]
  wire  _T_566; // @[Lookup.scala 11:37:@1450.4]
  wire  _T_567; // @[Lookup.scala 11:37:@1451.4]
  wire  _T_568; // @[Lookup.scala 11:37:@1452.4]
  wire [1:0] _T_600; // @[Lookup.scala 11:37:@1485.4]
  wire [1:0] _T_601; // @[Lookup.scala 11:37:@1486.4]
  wire [1:0] _T_602; // @[Lookup.scala 11:37:@1487.4]
  wire [1:0] _T_603; // @[Lookup.scala 11:37:@1488.4]
  wire [1:0] _T_604; // @[Lookup.scala 11:37:@1489.4]
  wire [1:0] _T_605; // @[Lookup.scala 11:37:@1490.4]
  wire [1:0] _T_606; // @[Lookup.scala 11:37:@1491.4]
  wire [1:0] _T_607; // @[Lookup.scala 11:37:@1492.4]
  wire [1:0] _T_608; // @[Lookup.scala 11:37:@1493.4]
  wire [1:0] _T_609; // @[Lookup.scala 11:37:@1494.4]
  wire [1:0] _T_610; // @[Lookup.scala 11:37:@1495.4]
  wire [1:0] _T_611; // @[Lookup.scala 11:37:@1496.4]
  wire [1:0] _T_612; // @[Lookup.scala 11:37:@1497.4]
  wire [1:0] _T_613; // @[Lookup.scala 11:37:@1498.4]
  wire [1:0] _T_614; // @[Lookup.scala 11:37:@1499.4]
  wire [1:0] _T_615; // @[Lookup.scala 11:37:@1500.4]
  wire [1:0] _T_616; // @[Lookup.scala 11:37:@1501.4]
  wire [2:0] _T_651; // @[Lookup.scala 11:37:@1537.4]
  wire [2:0] _T_652; // @[Lookup.scala 11:37:@1538.4]
  wire [2:0] _T_653; // @[Lookup.scala 11:37:@1539.4]
  wire [2:0] _T_654; // @[Lookup.scala 11:37:@1540.4]
  wire [2:0] _T_655; // @[Lookup.scala 11:37:@1541.4]
  wire [2:0] _T_656; // @[Lookup.scala 11:37:@1542.4]
  wire [2:0] _T_657; // @[Lookup.scala 11:37:@1543.4]
  wire [2:0] _T_658; // @[Lookup.scala 11:37:@1544.4]
  wire [2:0] _T_659; // @[Lookup.scala 11:37:@1545.4]
  wire [2:0] _T_660; // @[Lookup.scala 11:37:@1546.4]
  wire [2:0] _T_661; // @[Lookup.scala 11:37:@1547.4]
  wire [2:0] _T_662; // @[Lookup.scala 11:37:@1548.4]
  wire [2:0] _T_663; // @[Lookup.scala 11:37:@1549.4]
  wire [2:0] _T_664; // @[Lookup.scala 11:37:@1550.4]
  wire [1:0] _T_667; // @[Lookup.scala 11:37:@1554.4]
  wire [1:0] _T_668; // @[Lookup.scala 11:37:@1555.4]
  wire [1:0] _T_669; // @[Lookup.scala 11:37:@1556.4]
  wire [1:0] _T_670; // @[Lookup.scala 11:37:@1557.4]
  wire [1:0] _T_671; // @[Lookup.scala 11:37:@1558.4]
  wire [1:0] _T_672; // @[Lookup.scala 11:37:@1559.4]
  wire [1:0] _T_673; // @[Lookup.scala 11:37:@1560.4]
  wire [1:0] _T_674; // @[Lookup.scala 11:37:@1561.4]
  wire [1:0] _T_675; // @[Lookup.scala 11:37:@1562.4]
  wire [1:0] _T_676; // @[Lookup.scala 11:37:@1563.4]
  wire [1:0] _T_677; // @[Lookup.scala 11:37:@1564.4]
  wire [1:0] _T_678; // @[Lookup.scala 11:37:@1565.4]
  wire [1:0] _T_679; // @[Lookup.scala 11:37:@1566.4]
  wire [1:0] _T_680; // @[Lookup.scala 11:37:@1567.4]
  wire [1:0] _T_681; // @[Lookup.scala 11:37:@1568.4]
  wire [1:0] _T_682; // @[Lookup.scala 11:37:@1569.4]
  wire [1:0] _T_683; // @[Lookup.scala 11:37:@1570.4]
  wire [1:0] _T_684; // @[Lookup.scala 11:37:@1571.4]
  wire [1:0] _T_685; // @[Lookup.scala 11:37:@1572.4]
  wire [1:0] _T_686; // @[Lookup.scala 11:37:@1573.4]
  wire [1:0] _T_687; // @[Lookup.scala 11:37:@1574.4]
  wire [1:0] _T_688; // @[Lookup.scala 11:37:@1575.4]
  wire [1:0] _T_689; // @[Lookup.scala 11:37:@1576.4]
  wire [1:0] _T_690; // @[Lookup.scala 11:37:@1577.4]
  wire [1:0] _T_691; // @[Lookup.scala 11:37:@1578.4]
  wire [1:0] _T_692; // @[Lookup.scala 11:37:@1579.4]
  wire [1:0] _T_693; // @[Lookup.scala 11:37:@1580.4]
  wire [1:0] _T_694; // @[Lookup.scala 11:37:@1581.4]
  wire [1:0] _T_695; // @[Lookup.scala 11:37:@1582.4]
  wire [1:0] _T_696; // @[Lookup.scala 11:37:@1583.4]
  wire [1:0] _T_697; // @[Lookup.scala 11:37:@1584.4]
  wire [1:0] _T_698; // @[Lookup.scala 11:37:@1585.4]
  wire [1:0] _T_699; // @[Lookup.scala 11:37:@1586.4]
  wire [1:0] _T_700; // @[Lookup.scala 11:37:@1587.4]
  wire [1:0] _T_701; // @[Lookup.scala 11:37:@1588.4]
  wire [1:0] _T_702; // @[Lookup.scala 11:37:@1589.4]
  wire [1:0] _T_703; // @[Lookup.scala 11:37:@1590.4]
  wire [1:0] _T_704; // @[Lookup.scala 11:37:@1591.4]
  wire [1:0] _T_705; // @[Lookup.scala 11:37:@1592.4]
  wire [1:0] _T_706; // @[Lookup.scala 11:37:@1593.4]
  wire [1:0] _T_707; // @[Lookup.scala 11:37:@1594.4]
  wire [1:0] _T_708; // @[Lookup.scala 11:37:@1595.4]
  wire [1:0] _T_709; // @[Lookup.scala 11:37:@1596.4]
  wire [1:0] _T_710; // @[Lookup.scala 11:37:@1597.4]
  wire [1:0] _T_711; // @[Lookup.scala 11:37:@1598.4]
  wire [1:0] _T_712; // @[Lookup.scala 11:37:@1599.4]
  wire  _T_718; // @[Lookup.scala 11:37:@1606.4]
  wire  _T_719; // @[Lookup.scala 11:37:@1607.4]
  wire  _T_720; // @[Lookup.scala 11:37:@1608.4]
  wire  _T_721; // @[Lookup.scala 11:37:@1609.4]
  wire  _T_722; // @[Lookup.scala 11:37:@1610.4]
  wire  _T_723; // @[Lookup.scala 11:37:@1611.4]
  wire  _T_724; // @[Lookup.scala 11:37:@1612.4]
  wire  _T_725; // @[Lookup.scala 11:37:@1613.4]
  wire  _T_726; // @[Lookup.scala 11:37:@1614.4]
  wire  _T_727; // @[Lookup.scala 11:37:@1615.4]
  wire  _T_728; // @[Lookup.scala 11:37:@1616.4]
  wire  _T_729; // @[Lookup.scala 11:37:@1617.4]
  wire  _T_730; // @[Lookup.scala 11:37:@1618.4]
  wire  _T_731; // @[Lookup.scala 11:37:@1619.4]
  wire  _T_732; // @[Lookup.scala 11:37:@1620.4]
  wire  _T_733; // @[Lookup.scala 11:37:@1621.4]
  wire  _T_734; // @[Lookup.scala 11:37:@1622.4]
  wire  _T_735; // @[Lookup.scala 11:37:@1623.4]
  wire  _T_736; // @[Lookup.scala 11:37:@1624.4]
  wire  _T_737; // @[Lookup.scala 11:37:@1625.4]
  wire  _T_738; // @[Lookup.scala 11:37:@1626.4]
  wire  _T_739; // @[Lookup.scala 11:37:@1627.4]
  wire  _T_740; // @[Lookup.scala 11:37:@1628.4]
  wire  _T_741; // @[Lookup.scala 11:37:@1629.4]
  wire  _T_742; // @[Lookup.scala 11:37:@1630.4]
  wire  _T_743; // @[Lookup.scala 11:37:@1631.4]
  wire  _T_744; // @[Lookup.scala 11:37:@1632.4]
  wire  _T_745; // @[Lookup.scala 11:37:@1633.4]
  wire  _T_746; // @[Lookup.scala 11:37:@1634.4]
  wire  _T_747; // @[Lookup.scala 11:37:@1635.4]
  wire  _T_748; // @[Lookup.scala 11:37:@1636.4]
  wire  _T_749; // @[Lookup.scala 11:37:@1637.4]
  wire  _T_750; // @[Lookup.scala 11:37:@1638.4]
  wire  _T_751; // @[Lookup.scala 11:37:@1639.4]
  wire  _T_752; // @[Lookup.scala 11:37:@1640.4]
  wire  _T_753; // @[Lookup.scala 11:37:@1641.4]
  wire  _T_754; // @[Lookup.scala 11:37:@1642.4]
  wire  _T_755; // @[Lookup.scala 11:37:@1643.4]
  wire  _T_756; // @[Lookup.scala 11:37:@1644.4]
  wire  _T_757; // @[Lookup.scala 11:37:@1645.4]
  wire  _T_758; // @[Lookup.scala 11:37:@1646.4]
  wire  _T_759; // @[Lookup.scala 11:37:@1647.4]
  wire  _T_760; // @[Lookup.scala 11:37:@1648.4]
  wire [2:0] _T_762; // @[Lookup.scala 11:37:@1651.4]
  wire [2:0] _T_763; // @[Lookup.scala 11:37:@1652.4]
  wire [2:0] _T_764; // @[Lookup.scala 11:37:@1653.4]
  wire [2:0] _T_765; // @[Lookup.scala 11:37:@1654.4]
  wire [2:0] _T_766; // @[Lookup.scala 11:37:@1655.4]
  wire [2:0] _T_767; // @[Lookup.scala 11:37:@1656.4]
  wire [2:0] _T_768; // @[Lookup.scala 11:37:@1657.4]
  wire [2:0] _T_769; // @[Lookup.scala 11:37:@1658.4]
  wire [2:0] _T_770; // @[Lookup.scala 11:37:@1659.4]
  wire [2:0] _T_771; // @[Lookup.scala 11:37:@1660.4]
  wire [2:0] _T_772; // @[Lookup.scala 11:37:@1661.4]
  wire [2:0] _T_773; // @[Lookup.scala 11:37:@1662.4]
  wire [2:0] _T_774; // @[Lookup.scala 11:37:@1663.4]
  wire [2:0] _T_775; // @[Lookup.scala 11:37:@1664.4]
  wire [2:0] _T_776; // @[Lookup.scala 11:37:@1665.4]
  wire [2:0] _T_777; // @[Lookup.scala 11:37:@1666.4]
  wire [2:0] _T_778; // @[Lookup.scala 11:37:@1667.4]
  wire [2:0] _T_779; // @[Lookup.scala 11:37:@1668.4]
  wire [2:0] _T_780; // @[Lookup.scala 11:37:@1669.4]
  wire [2:0] _T_781; // @[Lookup.scala 11:37:@1670.4]
  wire [2:0] _T_782; // @[Lookup.scala 11:37:@1671.4]
  wire [2:0] _T_783; // @[Lookup.scala 11:37:@1672.4]
  wire [2:0] _T_784; // @[Lookup.scala 11:37:@1673.4]
  wire [2:0] _T_785; // @[Lookup.scala 11:37:@1674.4]
  wire [2:0] _T_786; // @[Lookup.scala 11:37:@1675.4]
  wire [2:0] _T_787; // @[Lookup.scala 11:37:@1676.4]
  wire [2:0] _T_788; // @[Lookup.scala 11:37:@1677.4]
  wire [2:0] _T_789; // @[Lookup.scala 11:37:@1678.4]
  wire [2:0] _T_790; // @[Lookup.scala 11:37:@1679.4]
  wire [2:0] _T_791; // @[Lookup.scala 11:37:@1680.4]
  wire [2:0] _T_792; // @[Lookup.scala 11:37:@1681.4]
  wire [2:0] _T_793; // @[Lookup.scala 11:37:@1682.4]
  wire [2:0] _T_794; // @[Lookup.scala 11:37:@1683.4]
  wire [2:0] _T_795; // @[Lookup.scala 11:37:@1684.4]
  wire [2:0] _T_796; // @[Lookup.scala 11:37:@1685.4]
  wire [2:0] _T_797; // @[Lookup.scala 11:37:@1686.4]
  wire [2:0] _T_798; // @[Lookup.scala 11:37:@1687.4]
  wire [2:0] _T_799; // @[Lookup.scala 11:37:@1688.4]
  wire [2:0] _T_800; // @[Lookup.scala 11:37:@1689.4]
  wire [2:0] _T_801; // @[Lookup.scala 11:37:@1690.4]
  wire [2:0] _T_802; // @[Lookup.scala 11:37:@1691.4]
  wire [2:0] _T_803; // @[Lookup.scala 11:37:@1692.4]
  wire [2:0] _T_804; // @[Lookup.scala 11:37:@1693.4]
  wire [2:0] _T_805; // @[Lookup.scala 11:37:@1694.4]
  wire [2:0] _T_806; // @[Lookup.scala 11:37:@1695.4]
  wire [2:0] _T_807; // @[Lookup.scala 11:37:@1696.4]
  wire [2:0] _T_808; // @[Lookup.scala 11:37:@1697.4]
  wire  _T_809; // @[Lookup.scala 11:37:@1699.4]
  wire  _T_810; // @[Lookup.scala 11:37:@1700.4]
  wire  _T_811; // @[Lookup.scala 11:37:@1701.4]
  wire  _T_812; // @[Lookup.scala 11:37:@1702.4]
  wire  _T_813; // @[Lookup.scala 11:37:@1703.4]
  wire  _T_814; // @[Lookup.scala 11:37:@1704.4]
  wire  _T_815; // @[Lookup.scala 11:37:@1705.4]
  wire  _T_816; // @[Lookup.scala 11:37:@1706.4]
  wire  _T_817; // @[Lookup.scala 11:37:@1707.4]
  wire  _T_818; // @[Lookup.scala 11:37:@1708.4]
  wire  _T_819; // @[Lookup.scala 11:37:@1709.4]
  wire  _T_820; // @[Lookup.scala 11:37:@1710.4]
  wire  _T_821; // @[Lookup.scala 11:37:@1711.4]
  wire  _T_822; // @[Lookup.scala 11:37:@1712.4]
  wire  _T_823; // @[Lookup.scala 11:37:@1713.4]
  wire  _T_824; // @[Lookup.scala 11:37:@1714.4]
  wire  _T_825; // @[Lookup.scala 11:37:@1715.4]
  wire  _T_826; // @[Lookup.scala 11:37:@1716.4]
  wire  _T_827; // @[Lookup.scala 11:37:@1717.4]
  wire  _T_828; // @[Lookup.scala 11:37:@1718.4]
  wire  _T_829; // @[Lookup.scala 11:37:@1719.4]
  wire  _T_830; // @[Lookup.scala 11:37:@1720.4]
  wire  _T_831; // @[Lookup.scala 11:37:@1721.4]
  wire  _T_832; // @[Lookup.scala 11:37:@1722.4]
  wire  _T_833; // @[Lookup.scala 11:37:@1723.4]
  wire  _T_834; // @[Lookup.scala 11:37:@1724.4]
  wire  _T_835; // @[Lookup.scala 11:37:@1725.4]
  wire  _T_836; // @[Lookup.scala 11:37:@1726.4]
  wire  _T_837; // @[Lookup.scala 11:37:@1727.4]
  wire  _T_838; // @[Lookup.scala 11:37:@1728.4]
  wire  _T_839; // @[Lookup.scala 11:37:@1729.4]
  wire  _T_840; // @[Lookup.scala 11:37:@1730.4]
  wire  _T_841; // @[Lookup.scala 11:37:@1731.4]
  wire  _T_842; // @[Lookup.scala 11:37:@1732.4]
  wire  _T_843; // @[Lookup.scala 11:37:@1733.4]
  wire  _T_844; // @[Lookup.scala 11:37:@1734.4]
  wire  _T_845; // @[Lookup.scala 11:37:@1735.4]
  wire  _T_846; // @[Lookup.scala 11:37:@1736.4]
  wire  _T_847; // @[Lookup.scala 11:37:@1737.4]
  wire  _T_848; // @[Lookup.scala 11:37:@1738.4]
  wire  _T_849; // @[Lookup.scala 11:37:@1739.4]
  wire  _T_850; // @[Lookup.scala 11:37:@1740.4]
  wire  _T_851; // @[Lookup.scala 11:37:@1741.4]
  wire  _T_852; // @[Lookup.scala 11:37:@1742.4]
  wire  _T_853; // @[Lookup.scala 11:37:@1743.4]
  wire  _T_854; // @[Lookup.scala 11:37:@1744.4]
  wire  _T_855; // @[Lookup.scala 11:37:@1745.4]
  wire  _T_856; // @[Lookup.scala 11:37:@1746.4]
  wire  _T_896; // @[Lookup.scala 11:37:@1787.4]
  wire  _T_897; // @[Lookup.scala 11:37:@1788.4]
  wire  _T_898; // @[Lookup.scala 11:37:@1789.4]
  wire  _T_899; // @[Lookup.scala 11:37:@1790.4]
  wire  _T_900; // @[Lookup.scala 11:37:@1791.4]
  wire  _T_901; // @[Lookup.scala 11:37:@1792.4]
  wire  _T_902; // @[Lookup.scala 11:37:@1793.4]
  wire  _T_903; // @[Lookup.scala 11:37:@1794.4]
  wire  _T_904; // @[Lookup.scala 11:37:@1795.4]
  wire  _T_936; // @[Lookup.scala 11:37:@1828.4]
  wire  _T_937; // @[Lookup.scala 11:37:@1829.4]
  wire  _T_938; // @[Lookup.scala 11:37:@1830.4]
  wire  _T_939; // @[Lookup.scala 11:37:@1831.4]
  wire  _T_940; // @[Lookup.scala 11:37:@1832.4]
  wire  _T_941; // @[Lookup.scala 11:37:@1833.4]
  wire  _T_942; // @[Lookup.scala 11:37:@1834.4]
  wire  _T_943; // @[Lookup.scala 11:37:@1835.4]
  wire  _T_944; // @[Lookup.scala 11:37:@1836.4]
  wire  _T_945; // @[Lookup.scala 11:37:@1837.4]
  wire  _T_946; // @[Lookup.scala 11:37:@1838.4]
  wire  _T_947; // @[Lookup.scala 11:37:@1839.4]
  wire  _T_948; // @[Lookup.scala 11:37:@1840.4]
  wire  _T_949; // @[Lookup.scala 11:37:@1841.4]
  wire  _T_950; // @[Lookup.scala 11:37:@1842.4]
  wire  _T_951; // @[Lookup.scala 11:37:@1843.4]
  wire  _T_952; // @[Lookup.scala 11:37:@1844.4]
  assign _T_39 = io_inst & 32'h7f; // @[Lookup.scala 9:38:@1013.4]
  assign _T_40 = 32'h37 == _T_39; // @[Lookup.scala 9:38:@1014.4]
  assign _T_44 = 32'h17 == _T_39; // @[Lookup.scala 9:38:@1016.4]
  assign _T_48 = 32'h6f == _T_39; // @[Lookup.scala 9:38:@1018.4]
  assign _T_51 = io_inst & 32'h707f; // @[Lookup.scala 9:38:@1019.4]
  assign _T_52 = 32'h67 == _T_51; // @[Lookup.scala 9:38:@1020.4]
  assign _T_56 = 32'h63 == _T_51; // @[Lookup.scala 9:38:@1022.4]
  assign _T_60 = 32'h1063 == _T_51; // @[Lookup.scala 9:38:@1024.4]
  assign _T_64 = 32'h4063 == _T_51; // @[Lookup.scala 9:38:@1026.4]
  assign _T_68 = 32'h5063 == _T_51; // @[Lookup.scala 9:38:@1028.4]
  assign _T_72 = 32'h6063 == _T_51; // @[Lookup.scala 9:38:@1030.4]
  assign _T_76 = 32'h7063 == _T_51; // @[Lookup.scala 9:38:@1032.4]
  assign _T_80 = 32'h3 == _T_51; // @[Lookup.scala 9:38:@1034.4]
  assign _T_84 = 32'h1003 == _T_51; // @[Lookup.scala 9:38:@1036.4]
  assign _T_88 = 32'h2003 == _T_51; // @[Lookup.scala 9:38:@1038.4]
  assign _T_92 = 32'h4003 == _T_51; // @[Lookup.scala 9:38:@1040.4]
  assign _T_96 = 32'h5003 == _T_51; // @[Lookup.scala 9:38:@1042.4]
  assign _T_100 = 32'h23 == _T_51; // @[Lookup.scala 9:38:@1044.4]
  assign _T_104 = 32'h1023 == _T_51; // @[Lookup.scala 9:38:@1046.4]
  assign _T_108 = 32'h2023 == _T_51; // @[Lookup.scala 9:38:@1048.4]
  assign _T_112 = 32'h13 == _T_51; // @[Lookup.scala 9:38:@1050.4]
  assign _T_116 = 32'h2013 == _T_51; // @[Lookup.scala 9:38:@1052.4]
  assign _T_120 = 32'h3013 == _T_51; // @[Lookup.scala 9:38:@1054.4]
  assign _T_124 = 32'h4013 == _T_51; // @[Lookup.scala 9:38:@1056.4]
  assign _T_128 = 32'h6013 == _T_51; // @[Lookup.scala 9:38:@1058.4]
  assign _T_132 = 32'h7013 == _T_51; // @[Lookup.scala 9:38:@1060.4]
  assign _T_135 = io_inst & 32'hfe00707f; // @[Lookup.scala 9:38:@1061.4]
  assign _T_136 = 32'h1013 == _T_135; // @[Lookup.scala 9:38:@1062.4]
  assign _T_140 = 32'h5013 == _T_135; // @[Lookup.scala 9:38:@1064.4]
  assign _T_144 = 32'h40005013 == _T_135; // @[Lookup.scala 9:38:@1066.4]
  assign _T_148 = 32'h33 == _T_135; // @[Lookup.scala 9:38:@1068.4]
  assign _T_152 = 32'h40000033 == _T_135; // @[Lookup.scala 9:38:@1070.4]
  assign _T_156 = 32'h1033 == _T_135; // @[Lookup.scala 9:38:@1072.4]
  assign _T_160 = 32'h2033 == _T_135; // @[Lookup.scala 9:38:@1074.4]
  assign _T_164 = 32'h3033 == _T_135; // @[Lookup.scala 9:38:@1076.4]
  assign _T_168 = 32'h4033 == _T_135; // @[Lookup.scala 9:38:@1078.4]
  assign _T_172 = 32'h5033 == _T_135; // @[Lookup.scala 9:38:@1080.4]
  assign _T_176 = 32'h40005033 == _T_135; // @[Lookup.scala 9:38:@1082.4]
  assign _T_180 = 32'h6033 == _T_135; // @[Lookup.scala 9:38:@1084.4]
  assign _T_184 = 32'h7033 == _T_135; // @[Lookup.scala 9:38:@1086.4]
  assign _T_187 = io_inst & 32'hf00fffff; // @[Lookup.scala 9:38:@1087.4]
  assign _T_188 = 32'hf == _T_187; // @[Lookup.scala 9:38:@1088.4]
  assign _T_192 = 32'h100f == io_inst; // @[Lookup.scala 9:38:@1090.4]
  assign _T_196 = 32'h1073 == _T_51; // @[Lookup.scala 9:38:@1092.4]
  assign _T_200 = 32'h2073 == _T_51; // @[Lookup.scala 9:38:@1094.4]
  assign _T_204 = 32'h3073 == _T_51; // @[Lookup.scala 9:38:@1096.4]
  assign _T_208 = 32'h5073 == _T_51; // @[Lookup.scala 9:38:@1098.4]
  assign _T_212 = 32'h6073 == _T_51; // @[Lookup.scala 9:38:@1100.4]
  assign _T_216 = 32'h7073 == _T_51; // @[Lookup.scala 9:38:@1102.4]
  assign _T_220 = 32'h73 == io_inst; // @[Lookup.scala 9:38:@1104.4]
  assign _T_224 = 32'h100073 == io_inst; // @[Lookup.scala 9:38:@1106.4]
  assign _T_228 = 32'h30200073 == io_inst; // @[Lookup.scala 9:38:@1108.4]
  assign _T_232 = 32'h10500073 == io_inst; // @[Lookup.scala 9:38:@1110.4]
  assign _T_234 = _T_228 ? 2'h3 : 2'h0; // @[Lookup.scala 11:37:@1112.4]
  assign _T_235 = _T_224 ? 2'h0 : _T_234; // @[Lookup.scala 11:37:@1113.4]
  assign _T_236 = _T_220 ? 2'h0 : _T_235; // @[Lookup.scala 11:37:@1114.4]
  assign _T_237 = _T_216 ? 2'h0 : _T_236; // @[Lookup.scala 11:37:@1115.4]
  assign _T_238 = _T_212 ? 2'h0 : _T_237; // @[Lookup.scala 11:37:@1116.4]
  assign _T_239 = _T_208 ? 2'h0 : _T_238; // @[Lookup.scala 11:37:@1117.4]
  assign _T_240 = _T_204 ? 2'h0 : _T_239; // @[Lookup.scala 11:37:@1118.4]
  assign _T_241 = _T_200 ? 2'h0 : _T_240; // @[Lookup.scala 11:37:@1119.4]
  assign _T_242 = _T_196 ? 2'h0 : _T_241; // @[Lookup.scala 11:37:@1120.4]
  assign _T_243 = _T_192 ? 2'h2 : _T_242; // @[Lookup.scala 11:37:@1121.4]
  assign _T_244 = _T_188 ? 2'h0 : _T_243; // @[Lookup.scala 11:37:@1122.4]
  assign _T_245 = _T_184 ? 2'h0 : _T_244; // @[Lookup.scala 11:37:@1123.4]
  assign _T_246 = _T_180 ? 2'h0 : _T_245; // @[Lookup.scala 11:37:@1124.4]
  assign _T_247 = _T_176 ? 2'h0 : _T_246; // @[Lookup.scala 11:37:@1125.4]
  assign _T_248 = _T_172 ? 2'h0 : _T_247; // @[Lookup.scala 11:37:@1126.4]
  assign _T_249 = _T_168 ? 2'h0 : _T_248; // @[Lookup.scala 11:37:@1127.4]
  assign _T_250 = _T_164 ? 2'h0 : _T_249; // @[Lookup.scala 11:37:@1128.4]
  assign _T_251 = _T_160 ? 2'h0 : _T_250; // @[Lookup.scala 11:37:@1129.4]
  assign _T_252 = _T_156 ? 2'h0 : _T_251; // @[Lookup.scala 11:37:@1130.4]
  assign _T_253 = _T_152 ? 2'h0 : _T_252; // @[Lookup.scala 11:37:@1131.4]
  assign _T_254 = _T_148 ? 2'h0 : _T_253; // @[Lookup.scala 11:37:@1132.4]
  assign _T_255 = _T_144 ? 2'h0 : _T_254; // @[Lookup.scala 11:37:@1133.4]
  assign _T_256 = _T_140 ? 2'h0 : _T_255; // @[Lookup.scala 11:37:@1134.4]
  assign _T_257 = _T_136 ? 2'h0 : _T_256; // @[Lookup.scala 11:37:@1135.4]
  assign _T_258 = _T_132 ? 2'h0 : _T_257; // @[Lookup.scala 11:37:@1136.4]
  assign _T_259 = _T_128 ? 2'h0 : _T_258; // @[Lookup.scala 11:37:@1137.4]
  assign _T_260 = _T_124 ? 2'h0 : _T_259; // @[Lookup.scala 11:37:@1138.4]
  assign _T_261 = _T_120 ? 2'h0 : _T_260; // @[Lookup.scala 11:37:@1139.4]
  assign _T_262 = _T_116 ? 2'h0 : _T_261; // @[Lookup.scala 11:37:@1140.4]
  assign _T_263 = _T_112 ? 2'h0 : _T_262; // @[Lookup.scala 11:37:@1141.4]
  assign _T_264 = _T_108 ? 2'h0 : _T_263; // @[Lookup.scala 11:37:@1142.4]
  assign _T_265 = _T_104 ? 2'h0 : _T_264; // @[Lookup.scala 11:37:@1143.4]
  assign _T_266 = _T_100 ? 2'h0 : _T_265; // @[Lookup.scala 11:37:@1144.4]
  assign _T_267 = _T_96 ? 2'h0 : _T_266; // @[Lookup.scala 11:37:@1145.4]
  assign _T_268 = _T_92 ? 2'h0 : _T_267; // @[Lookup.scala 11:37:@1146.4]
  assign _T_269 = _T_88 ? 2'h0 : _T_268; // @[Lookup.scala 11:37:@1147.4]
  assign _T_270 = _T_84 ? 2'h0 : _T_269; // @[Lookup.scala 11:37:@1148.4]
  assign _T_271 = _T_80 ? 2'h0 : _T_270; // @[Lookup.scala 11:37:@1149.4]
  assign _T_272 = _T_76 ? 2'h0 : _T_271; // @[Lookup.scala 11:37:@1150.4]
  assign _T_273 = _T_72 ? 2'h0 : _T_272; // @[Lookup.scala 11:37:@1151.4]
  assign _T_274 = _T_68 ? 2'h0 : _T_273; // @[Lookup.scala 11:37:@1152.4]
  assign _T_275 = _T_64 ? 2'h0 : _T_274; // @[Lookup.scala 11:37:@1153.4]
  assign _T_276 = _T_60 ? 2'h0 : _T_275; // @[Lookup.scala 11:37:@1154.4]
  assign _T_277 = _T_56 ? 2'h0 : _T_276; // @[Lookup.scala 11:37:@1155.4]
  assign _T_278 = _T_52 ? 2'h1 : _T_277; // @[Lookup.scala 11:37:@1156.4]
  assign _T_279 = _T_48 ? 2'h1 : _T_278; // @[Lookup.scala 11:37:@1157.4]
  assign _T_280 = _T_44 ? 2'h0 : _T_279; // @[Lookup.scala 11:37:@1158.4]
  assign _T_289 = _T_200 ? 1'h1 : _T_204; // @[Lookup.scala 11:37:@1168.4]
  assign _T_290 = _T_196 ? 1'h1 : _T_289; // @[Lookup.scala 11:37:@1169.4]
  assign _T_291 = _T_192 ? 1'h0 : _T_290; // @[Lookup.scala 11:37:@1170.4]
  assign _T_292 = _T_188 ? 1'h0 : _T_291; // @[Lookup.scala 11:37:@1171.4]
  assign _T_293 = _T_184 ? 1'h1 : _T_292; // @[Lookup.scala 11:37:@1172.4]
  assign _T_294 = _T_180 ? 1'h1 : _T_293; // @[Lookup.scala 11:37:@1173.4]
  assign _T_295 = _T_176 ? 1'h1 : _T_294; // @[Lookup.scala 11:37:@1174.4]
  assign _T_296 = _T_172 ? 1'h1 : _T_295; // @[Lookup.scala 11:37:@1175.4]
  assign _T_297 = _T_168 ? 1'h1 : _T_296; // @[Lookup.scala 11:37:@1176.4]
  assign _T_298 = _T_164 ? 1'h1 : _T_297; // @[Lookup.scala 11:37:@1177.4]
  assign _T_299 = _T_160 ? 1'h1 : _T_298; // @[Lookup.scala 11:37:@1178.4]
  assign _T_300 = _T_156 ? 1'h1 : _T_299; // @[Lookup.scala 11:37:@1179.4]
  assign _T_301 = _T_152 ? 1'h1 : _T_300; // @[Lookup.scala 11:37:@1180.4]
  assign _T_302 = _T_148 ? 1'h1 : _T_301; // @[Lookup.scala 11:37:@1181.4]
  assign _T_303 = _T_144 ? 1'h1 : _T_302; // @[Lookup.scala 11:37:@1182.4]
  assign _T_304 = _T_140 ? 1'h1 : _T_303; // @[Lookup.scala 11:37:@1183.4]
  assign _T_305 = _T_136 ? 1'h1 : _T_304; // @[Lookup.scala 11:37:@1184.4]
  assign _T_306 = _T_132 ? 1'h1 : _T_305; // @[Lookup.scala 11:37:@1185.4]
  assign _T_307 = _T_128 ? 1'h1 : _T_306; // @[Lookup.scala 11:37:@1186.4]
  assign _T_308 = _T_124 ? 1'h1 : _T_307; // @[Lookup.scala 11:37:@1187.4]
  assign _T_309 = _T_120 ? 1'h1 : _T_308; // @[Lookup.scala 11:37:@1188.4]
  assign _T_310 = _T_116 ? 1'h1 : _T_309; // @[Lookup.scala 11:37:@1189.4]
  assign _T_311 = _T_112 ? 1'h1 : _T_310; // @[Lookup.scala 11:37:@1190.4]
  assign _T_312 = _T_108 ? 1'h1 : _T_311; // @[Lookup.scala 11:37:@1191.4]
  assign _T_313 = _T_104 ? 1'h1 : _T_312; // @[Lookup.scala 11:37:@1192.4]
  assign _T_314 = _T_100 ? 1'h1 : _T_313; // @[Lookup.scala 11:37:@1193.4]
  assign _T_315 = _T_96 ? 1'h1 : _T_314; // @[Lookup.scala 11:37:@1194.4]
  assign _T_316 = _T_92 ? 1'h1 : _T_315; // @[Lookup.scala 11:37:@1195.4]
  assign _T_317 = _T_88 ? 1'h1 : _T_316; // @[Lookup.scala 11:37:@1196.4]
  assign _T_318 = _T_84 ? 1'h1 : _T_317; // @[Lookup.scala 11:37:@1197.4]
  assign _T_319 = _T_80 ? 1'h1 : _T_318; // @[Lookup.scala 11:37:@1198.4]
  assign _T_320 = _T_76 ? 1'h0 : _T_319; // @[Lookup.scala 11:37:@1199.4]
  assign _T_321 = _T_72 ? 1'h0 : _T_320; // @[Lookup.scala 11:37:@1200.4]
  assign _T_322 = _T_68 ? 1'h0 : _T_321; // @[Lookup.scala 11:37:@1201.4]
  assign _T_323 = _T_64 ? 1'h0 : _T_322; // @[Lookup.scala 11:37:@1202.4]
  assign _T_324 = _T_60 ? 1'h0 : _T_323; // @[Lookup.scala 11:37:@1203.4]
  assign _T_325 = _T_56 ? 1'h0 : _T_324; // @[Lookup.scala 11:37:@1204.4]
  assign _T_326 = _T_52 ? 1'h1 : _T_325; // @[Lookup.scala 11:37:@1205.4]
  assign _T_327 = _T_48 ? 1'h0 : _T_326; // @[Lookup.scala 11:37:@1206.4]
  assign _T_328 = _T_44 ? 1'h0 : _T_327; // @[Lookup.scala 11:37:@1207.4]
  assign _T_342 = _T_180 ? 1'h1 : _T_184; // @[Lookup.scala 11:37:@1222.4]
  assign _T_343 = _T_176 ? 1'h1 : _T_342; // @[Lookup.scala 11:37:@1223.4]
  assign _T_344 = _T_172 ? 1'h1 : _T_343; // @[Lookup.scala 11:37:@1224.4]
  assign _T_345 = _T_168 ? 1'h1 : _T_344; // @[Lookup.scala 11:37:@1225.4]
  assign _T_346 = _T_164 ? 1'h1 : _T_345; // @[Lookup.scala 11:37:@1226.4]
  assign _T_347 = _T_160 ? 1'h1 : _T_346; // @[Lookup.scala 11:37:@1227.4]
  assign _T_348 = _T_156 ? 1'h1 : _T_347; // @[Lookup.scala 11:37:@1228.4]
  assign _T_349 = _T_152 ? 1'h1 : _T_348; // @[Lookup.scala 11:37:@1229.4]
  assign _T_350 = _T_148 ? 1'h1 : _T_349; // @[Lookup.scala 11:37:@1230.4]
  assign _T_351 = _T_144 ? 1'h0 : _T_350; // @[Lookup.scala 11:37:@1231.4]
  assign _T_352 = _T_140 ? 1'h0 : _T_351; // @[Lookup.scala 11:37:@1232.4]
  assign _T_353 = _T_136 ? 1'h0 : _T_352; // @[Lookup.scala 11:37:@1233.4]
  assign _T_354 = _T_132 ? 1'h0 : _T_353; // @[Lookup.scala 11:37:@1234.4]
  assign _T_355 = _T_128 ? 1'h0 : _T_354; // @[Lookup.scala 11:37:@1235.4]
  assign _T_356 = _T_124 ? 1'h0 : _T_355; // @[Lookup.scala 11:37:@1236.4]
  assign _T_357 = _T_120 ? 1'h0 : _T_356; // @[Lookup.scala 11:37:@1237.4]
  assign _T_358 = _T_116 ? 1'h0 : _T_357; // @[Lookup.scala 11:37:@1238.4]
  assign _T_359 = _T_112 ? 1'h0 : _T_358; // @[Lookup.scala 11:37:@1239.4]
  assign _T_360 = _T_108 ? 1'h0 : _T_359; // @[Lookup.scala 11:37:@1240.4]
  assign _T_361 = _T_104 ? 1'h0 : _T_360; // @[Lookup.scala 11:37:@1241.4]
  assign _T_362 = _T_100 ? 1'h0 : _T_361; // @[Lookup.scala 11:37:@1242.4]
  assign _T_363 = _T_96 ? 1'h0 : _T_362; // @[Lookup.scala 11:37:@1243.4]
  assign _T_364 = _T_92 ? 1'h0 : _T_363; // @[Lookup.scala 11:37:@1244.4]
  assign _T_365 = _T_88 ? 1'h0 : _T_364; // @[Lookup.scala 11:37:@1245.4]
  assign _T_366 = _T_84 ? 1'h0 : _T_365; // @[Lookup.scala 11:37:@1246.4]
  assign _T_367 = _T_80 ? 1'h0 : _T_366; // @[Lookup.scala 11:37:@1247.4]
  assign _T_368 = _T_76 ? 1'h0 : _T_367; // @[Lookup.scala 11:37:@1248.4]
  assign _T_369 = _T_72 ? 1'h0 : _T_368; // @[Lookup.scala 11:37:@1249.4]
  assign _T_370 = _T_68 ? 1'h0 : _T_369; // @[Lookup.scala 11:37:@1250.4]
  assign _T_371 = _T_64 ? 1'h0 : _T_370; // @[Lookup.scala 11:37:@1251.4]
  assign _T_372 = _T_60 ? 1'h0 : _T_371; // @[Lookup.scala 11:37:@1252.4]
  assign _T_373 = _T_56 ? 1'h0 : _T_372; // @[Lookup.scala 11:37:@1253.4]
  assign _T_374 = _T_52 ? 1'h0 : _T_373; // @[Lookup.scala 11:37:@1254.4]
  assign _T_375 = _T_48 ? 1'h0 : _T_374; // @[Lookup.scala 11:37:@1255.4]
  assign _T_376 = _T_44 ? 1'h0 : _T_375; // @[Lookup.scala 11:37:@1256.4]
  assign _T_381 = _T_216 ? 3'h6 : 3'h0; // @[Lookup.scala 11:37:@1262.4]
  assign _T_382 = _T_212 ? 3'h6 : _T_381; // @[Lookup.scala 11:37:@1263.4]
  assign _T_383 = _T_208 ? 3'h6 : _T_382; // @[Lookup.scala 11:37:@1264.4]
  assign _T_384 = _T_204 ? 3'h0 : _T_383; // @[Lookup.scala 11:37:@1265.4]
  assign _T_385 = _T_200 ? 3'h0 : _T_384; // @[Lookup.scala 11:37:@1266.4]
  assign _T_386 = _T_196 ? 3'h0 : _T_385; // @[Lookup.scala 11:37:@1267.4]
  assign _T_387 = _T_192 ? 3'h0 : _T_386; // @[Lookup.scala 11:37:@1268.4]
  assign _T_388 = _T_188 ? 3'h0 : _T_387; // @[Lookup.scala 11:37:@1269.4]
  assign _T_389 = _T_184 ? 3'h0 : _T_388; // @[Lookup.scala 11:37:@1270.4]
  assign _T_390 = _T_180 ? 3'h0 : _T_389; // @[Lookup.scala 11:37:@1271.4]
  assign _T_391 = _T_176 ? 3'h0 : _T_390; // @[Lookup.scala 11:37:@1272.4]
  assign _T_392 = _T_172 ? 3'h0 : _T_391; // @[Lookup.scala 11:37:@1273.4]
  assign _T_393 = _T_168 ? 3'h0 : _T_392; // @[Lookup.scala 11:37:@1274.4]
  assign _T_394 = _T_164 ? 3'h0 : _T_393; // @[Lookup.scala 11:37:@1275.4]
  assign _T_395 = _T_160 ? 3'h0 : _T_394; // @[Lookup.scala 11:37:@1276.4]
  assign _T_396 = _T_156 ? 3'h0 : _T_395; // @[Lookup.scala 11:37:@1277.4]
  assign _T_397 = _T_152 ? 3'h0 : _T_396; // @[Lookup.scala 11:37:@1278.4]
  assign _T_398 = _T_148 ? 3'h0 : _T_397; // @[Lookup.scala 11:37:@1279.4]
  assign _T_399 = _T_144 ? 3'h1 : _T_398; // @[Lookup.scala 11:37:@1280.4]
  assign _T_400 = _T_140 ? 3'h1 : _T_399; // @[Lookup.scala 11:37:@1281.4]
  assign _T_401 = _T_136 ? 3'h1 : _T_400; // @[Lookup.scala 11:37:@1282.4]
  assign _T_402 = _T_132 ? 3'h1 : _T_401; // @[Lookup.scala 11:37:@1283.4]
  assign _T_403 = _T_128 ? 3'h1 : _T_402; // @[Lookup.scala 11:37:@1284.4]
  assign _T_404 = _T_124 ? 3'h1 : _T_403; // @[Lookup.scala 11:37:@1285.4]
  assign _T_405 = _T_120 ? 3'h1 : _T_404; // @[Lookup.scala 11:37:@1286.4]
  assign _T_406 = _T_116 ? 3'h1 : _T_405; // @[Lookup.scala 11:37:@1287.4]
  assign _T_407 = _T_112 ? 3'h1 : _T_406; // @[Lookup.scala 11:37:@1288.4]
  assign _T_408 = _T_108 ? 3'h2 : _T_407; // @[Lookup.scala 11:37:@1289.4]
  assign _T_409 = _T_104 ? 3'h2 : _T_408; // @[Lookup.scala 11:37:@1290.4]
  assign _T_410 = _T_100 ? 3'h2 : _T_409; // @[Lookup.scala 11:37:@1291.4]
  assign _T_411 = _T_96 ? 3'h1 : _T_410; // @[Lookup.scala 11:37:@1292.4]
  assign _T_412 = _T_92 ? 3'h1 : _T_411; // @[Lookup.scala 11:37:@1293.4]
  assign _T_413 = _T_88 ? 3'h1 : _T_412; // @[Lookup.scala 11:37:@1294.4]
  assign _T_414 = _T_84 ? 3'h1 : _T_413; // @[Lookup.scala 11:37:@1295.4]
  assign _T_415 = _T_80 ? 3'h1 : _T_414; // @[Lookup.scala 11:37:@1296.4]
  assign _T_416 = _T_76 ? 3'h5 : _T_415; // @[Lookup.scala 11:37:@1297.4]
  assign _T_417 = _T_72 ? 3'h5 : _T_416; // @[Lookup.scala 11:37:@1298.4]
  assign _T_418 = _T_68 ? 3'h5 : _T_417; // @[Lookup.scala 11:37:@1299.4]
  assign _T_419 = _T_64 ? 3'h5 : _T_418; // @[Lookup.scala 11:37:@1300.4]
  assign _T_420 = _T_60 ? 3'h5 : _T_419; // @[Lookup.scala 11:37:@1301.4]
  assign _T_421 = _T_56 ? 3'h5 : _T_420; // @[Lookup.scala 11:37:@1302.4]
  assign _T_422 = _T_52 ? 3'h1 : _T_421; // @[Lookup.scala 11:37:@1303.4]
  assign _T_423 = _T_48 ? 3'h4 : _T_422; // @[Lookup.scala 11:37:@1304.4]
  assign _T_424 = _T_44 ? 3'h3 : _T_423; // @[Lookup.scala 11:37:@1305.4]
  assign _T_432 = _T_204 ? 4'ha : 4'hf; // @[Lookup.scala 11:37:@1314.4]
  assign _T_433 = _T_200 ? 4'ha : _T_432; // @[Lookup.scala 11:37:@1315.4]
  assign _T_434 = _T_196 ? 4'ha : _T_433; // @[Lookup.scala 11:37:@1316.4]
  assign _T_435 = _T_192 ? 4'hf : _T_434; // @[Lookup.scala 11:37:@1317.4]
  assign _T_436 = _T_188 ? 4'hf : _T_435; // @[Lookup.scala 11:37:@1318.4]
  assign _T_437 = _T_184 ? 4'h2 : _T_436; // @[Lookup.scala 11:37:@1319.4]
  assign _T_438 = _T_180 ? 4'h3 : _T_437; // @[Lookup.scala 11:37:@1320.4]
  assign _T_439 = _T_176 ? 4'h9 : _T_438; // @[Lookup.scala 11:37:@1321.4]
  assign _T_440 = _T_172 ? 4'h8 : _T_439; // @[Lookup.scala 11:37:@1322.4]
  assign _T_441 = _T_168 ? 4'h4 : _T_440; // @[Lookup.scala 11:37:@1323.4]
  assign _T_442 = _T_164 ? 4'h7 : _T_441; // @[Lookup.scala 11:37:@1324.4]
  assign _T_443 = _T_160 ? 4'h5 : _T_442; // @[Lookup.scala 11:37:@1325.4]
  assign _T_444 = _T_156 ? 4'h6 : _T_443; // @[Lookup.scala 11:37:@1326.4]
  assign _T_445 = _T_152 ? 4'h1 : _T_444; // @[Lookup.scala 11:37:@1327.4]
  assign _T_446 = _T_148 ? 4'h0 : _T_445; // @[Lookup.scala 11:37:@1328.4]
  assign _T_447 = _T_144 ? 4'h9 : _T_446; // @[Lookup.scala 11:37:@1329.4]
  assign _T_448 = _T_140 ? 4'h8 : _T_447; // @[Lookup.scala 11:37:@1330.4]
  assign _T_449 = _T_136 ? 4'h6 : _T_448; // @[Lookup.scala 11:37:@1331.4]
  assign _T_450 = _T_132 ? 4'h2 : _T_449; // @[Lookup.scala 11:37:@1332.4]
  assign _T_451 = _T_128 ? 4'h3 : _T_450; // @[Lookup.scala 11:37:@1333.4]
  assign _T_452 = _T_124 ? 4'h4 : _T_451; // @[Lookup.scala 11:37:@1334.4]
  assign _T_453 = _T_120 ? 4'h7 : _T_452; // @[Lookup.scala 11:37:@1335.4]
  assign _T_454 = _T_116 ? 4'h5 : _T_453; // @[Lookup.scala 11:37:@1336.4]
  assign _T_455 = _T_112 ? 4'h0 : _T_454; // @[Lookup.scala 11:37:@1337.4]
  assign _T_456 = _T_108 ? 4'h0 : _T_455; // @[Lookup.scala 11:37:@1338.4]
  assign _T_457 = _T_104 ? 4'h0 : _T_456; // @[Lookup.scala 11:37:@1339.4]
  assign _T_458 = _T_100 ? 4'h0 : _T_457; // @[Lookup.scala 11:37:@1340.4]
  assign _T_459 = _T_96 ? 4'h0 : _T_458; // @[Lookup.scala 11:37:@1341.4]
  assign _T_460 = _T_92 ? 4'h0 : _T_459; // @[Lookup.scala 11:37:@1342.4]
  assign _T_461 = _T_88 ? 4'h0 : _T_460; // @[Lookup.scala 11:37:@1343.4]
  assign _T_462 = _T_84 ? 4'h0 : _T_461; // @[Lookup.scala 11:37:@1344.4]
  assign _T_463 = _T_80 ? 4'h0 : _T_462; // @[Lookup.scala 11:37:@1345.4]
  assign _T_464 = _T_76 ? 4'h0 : _T_463; // @[Lookup.scala 11:37:@1346.4]
  assign _T_465 = _T_72 ? 4'h0 : _T_464; // @[Lookup.scala 11:37:@1347.4]
  assign _T_466 = _T_68 ? 4'h0 : _T_465; // @[Lookup.scala 11:37:@1348.4]
  assign _T_467 = _T_64 ? 4'h0 : _T_466; // @[Lookup.scala 11:37:@1349.4]
  assign _T_468 = _T_60 ? 4'h0 : _T_467; // @[Lookup.scala 11:37:@1350.4]
  assign _T_469 = _T_56 ? 4'h0 : _T_468; // @[Lookup.scala 11:37:@1351.4]
  assign _T_470 = _T_52 ? 4'h0 : _T_469; // @[Lookup.scala 11:37:@1352.4]
  assign _T_471 = _T_48 ? 4'h0 : _T_470; // @[Lookup.scala 11:37:@1353.4]
  assign _T_472 = _T_44 ? 4'h0 : _T_471; // @[Lookup.scala 11:37:@1354.4]
  assign ctrlSignals_4 = _T_40 ? 4'hb : _T_472; // @[Lookup.scala 11:37:@1355.4]
  assign _T_512 = _T_76 ? 3'h4 : 3'h0; // @[Lookup.scala 11:37:@1395.4]
  assign _T_513 = _T_72 ? 3'h1 : _T_512; // @[Lookup.scala 11:37:@1396.4]
  assign _T_514 = _T_68 ? 3'h5 : _T_513; // @[Lookup.scala 11:37:@1397.4]
  assign _T_515 = _T_64 ? 3'h2 : _T_514; // @[Lookup.scala 11:37:@1398.4]
  assign _T_516 = _T_60 ? 3'h6 : _T_515; // @[Lookup.scala 11:37:@1399.4]
  assign _T_517 = _T_56 ? 3'h3 : _T_516; // @[Lookup.scala 11:37:@1400.4]
  assign _T_518 = _T_52 ? 3'h0 : _T_517; // @[Lookup.scala 11:37:@1401.4]
  assign _T_519 = _T_48 ? 3'h0 : _T_518; // @[Lookup.scala 11:37:@1402.4]
  assign _T_520 = _T_44 ? 3'h0 : _T_519; // @[Lookup.scala 11:37:@1403.4]
  assign _T_523 = _T_224 ? 1'h0 : _T_228; // @[Lookup.scala 11:37:@1407.4]
  assign _T_524 = _T_220 ? 1'h0 : _T_523; // @[Lookup.scala 11:37:@1408.4]
  assign _T_525 = _T_216 ? 1'h0 : _T_524; // @[Lookup.scala 11:37:@1409.4]
  assign _T_526 = _T_212 ? 1'h0 : _T_525; // @[Lookup.scala 11:37:@1410.4]
  assign _T_527 = _T_208 ? 1'h0 : _T_526; // @[Lookup.scala 11:37:@1411.4]
  assign _T_528 = _T_204 ? 1'h0 : _T_527; // @[Lookup.scala 11:37:@1412.4]
  assign _T_529 = _T_200 ? 1'h0 : _T_528; // @[Lookup.scala 11:37:@1413.4]
  assign _T_530 = _T_196 ? 1'h0 : _T_529; // @[Lookup.scala 11:37:@1414.4]
  assign _T_531 = _T_192 ? 1'h1 : _T_530; // @[Lookup.scala 11:37:@1415.4]
  assign _T_532 = _T_188 ? 1'h0 : _T_531; // @[Lookup.scala 11:37:@1416.4]
  assign _T_533 = _T_184 ? 1'h0 : _T_532; // @[Lookup.scala 11:37:@1417.4]
  assign _T_534 = _T_180 ? 1'h0 : _T_533; // @[Lookup.scala 11:37:@1418.4]
  assign _T_535 = _T_176 ? 1'h0 : _T_534; // @[Lookup.scala 11:37:@1419.4]
  assign _T_536 = _T_172 ? 1'h0 : _T_535; // @[Lookup.scala 11:37:@1420.4]
  assign _T_537 = _T_168 ? 1'h0 : _T_536; // @[Lookup.scala 11:37:@1421.4]
  assign _T_538 = _T_164 ? 1'h0 : _T_537; // @[Lookup.scala 11:37:@1422.4]
  assign _T_539 = _T_160 ? 1'h0 : _T_538; // @[Lookup.scala 11:37:@1423.4]
  assign _T_540 = _T_156 ? 1'h0 : _T_539; // @[Lookup.scala 11:37:@1424.4]
  assign _T_541 = _T_152 ? 1'h0 : _T_540; // @[Lookup.scala 11:37:@1425.4]
  assign _T_542 = _T_148 ? 1'h0 : _T_541; // @[Lookup.scala 11:37:@1426.4]
  assign _T_543 = _T_144 ? 1'h0 : _T_542; // @[Lookup.scala 11:37:@1427.4]
  assign _T_544 = _T_140 ? 1'h0 : _T_543; // @[Lookup.scala 11:37:@1428.4]
  assign _T_545 = _T_136 ? 1'h0 : _T_544; // @[Lookup.scala 11:37:@1429.4]
  assign _T_546 = _T_132 ? 1'h0 : _T_545; // @[Lookup.scala 11:37:@1430.4]
  assign _T_547 = _T_128 ? 1'h0 : _T_546; // @[Lookup.scala 11:37:@1431.4]
  assign _T_548 = _T_124 ? 1'h0 : _T_547; // @[Lookup.scala 11:37:@1432.4]
  assign _T_549 = _T_120 ? 1'h0 : _T_548; // @[Lookup.scala 11:37:@1433.4]
  assign _T_550 = _T_116 ? 1'h0 : _T_549; // @[Lookup.scala 11:37:@1434.4]
  assign _T_551 = _T_112 ? 1'h0 : _T_550; // @[Lookup.scala 11:37:@1435.4]
  assign _T_552 = _T_108 ? 1'h0 : _T_551; // @[Lookup.scala 11:37:@1436.4]
  assign _T_553 = _T_104 ? 1'h0 : _T_552; // @[Lookup.scala 11:37:@1437.4]
  assign _T_554 = _T_100 ? 1'h0 : _T_553; // @[Lookup.scala 11:37:@1438.4]
  assign _T_555 = _T_96 ? 1'h0 : _T_554; // @[Lookup.scala 11:37:@1439.4]
  assign _T_556 = _T_92 ? 1'h0 : _T_555; // @[Lookup.scala 11:37:@1440.4]
  assign _T_557 = _T_88 ? 1'h0 : _T_556; // @[Lookup.scala 11:37:@1441.4]
  assign _T_558 = _T_84 ? 1'h0 : _T_557; // @[Lookup.scala 11:37:@1442.4]
  assign _T_559 = _T_80 ? 1'h0 : _T_558; // @[Lookup.scala 11:37:@1443.4]
  assign _T_560 = _T_76 ? 1'h0 : _T_559; // @[Lookup.scala 11:37:@1444.4]
  assign _T_561 = _T_72 ? 1'h0 : _T_560; // @[Lookup.scala 11:37:@1445.4]
  assign _T_562 = _T_68 ? 1'h0 : _T_561; // @[Lookup.scala 11:37:@1446.4]
  assign _T_563 = _T_64 ? 1'h0 : _T_562; // @[Lookup.scala 11:37:@1447.4]
  assign _T_564 = _T_60 ? 1'h0 : _T_563; // @[Lookup.scala 11:37:@1448.4]
  assign _T_565 = _T_56 ? 1'h0 : _T_564; // @[Lookup.scala 11:37:@1449.4]
  assign _T_566 = _T_52 ? 1'h1 : _T_565; // @[Lookup.scala 11:37:@1450.4]
  assign _T_567 = _T_48 ? 1'h1 : _T_566; // @[Lookup.scala 11:37:@1451.4]
  assign _T_568 = _T_44 ? 1'h0 : _T_567; // @[Lookup.scala 11:37:@1452.4]
  assign _T_600 = _T_108 ? 2'h1 : 2'h0; // @[Lookup.scala 11:37:@1485.4]
  assign _T_601 = _T_104 ? 2'h2 : _T_600; // @[Lookup.scala 11:37:@1486.4]
  assign _T_602 = _T_100 ? 2'h3 : _T_601; // @[Lookup.scala 11:37:@1487.4]
  assign _T_603 = _T_96 ? 2'h0 : _T_602; // @[Lookup.scala 11:37:@1488.4]
  assign _T_604 = _T_92 ? 2'h0 : _T_603; // @[Lookup.scala 11:37:@1489.4]
  assign _T_605 = _T_88 ? 2'h0 : _T_604; // @[Lookup.scala 11:37:@1490.4]
  assign _T_606 = _T_84 ? 2'h0 : _T_605; // @[Lookup.scala 11:37:@1491.4]
  assign _T_607 = _T_80 ? 2'h0 : _T_606; // @[Lookup.scala 11:37:@1492.4]
  assign _T_608 = _T_76 ? 2'h0 : _T_607; // @[Lookup.scala 11:37:@1493.4]
  assign _T_609 = _T_72 ? 2'h0 : _T_608; // @[Lookup.scala 11:37:@1494.4]
  assign _T_610 = _T_68 ? 2'h0 : _T_609; // @[Lookup.scala 11:37:@1495.4]
  assign _T_611 = _T_64 ? 2'h0 : _T_610; // @[Lookup.scala 11:37:@1496.4]
  assign _T_612 = _T_60 ? 2'h0 : _T_611; // @[Lookup.scala 11:37:@1497.4]
  assign _T_613 = _T_56 ? 2'h0 : _T_612; // @[Lookup.scala 11:37:@1498.4]
  assign _T_614 = _T_52 ? 2'h0 : _T_613; // @[Lookup.scala 11:37:@1499.4]
  assign _T_615 = _T_48 ? 2'h0 : _T_614; // @[Lookup.scala 11:37:@1500.4]
  assign _T_616 = _T_44 ? 2'h0 : _T_615; // @[Lookup.scala 11:37:@1501.4]
  assign _T_651 = _T_96 ? 3'h4 : 3'h0; // @[Lookup.scala 11:37:@1537.4]
  assign _T_652 = _T_92 ? 3'h5 : _T_651; // @[Lookup.scala 11:37:@1538.4]
  assign _T_653 = _T_88 ? 3'h1 : _T_652; // @[Lookup.scala 11:37:@1539.4]
  assign _T_654 = _T_84 ? 3'h2 : _T_653; // @[Lookup.scala 11:37:@1540.4]
  assign _T_655 = _T_80 ? 3'h3 : _T_654; // @[Lookup.scala 11:37:@1541.4]
  assign _T_656 = _T_76 ? 3'h0 : _T_655; // @[Lookup.scala 11:37:@1542.4]
  assign _T_657 = _T_72 ? 3'h0 : _T_656; // @[Lookup.scala 11:37:@1543.4]
  assign _T_658 = _T_68 ? 3'h0 : _T_657; // @[Lookup.scala 11:37:@1544.4]
  assign _T_659 = _T_64 ? 3'h0 : _T_658; // @[Lookup.scala 11:37:@1545.4]
  assign _T_660 = _T_60 ? 3'h0 : _T_659; // @[Lookup.scala 11:37:@1546.4]
  assign _T_661 = _T_56 ? 3'h0 : _T_660; // @[Lookup.scala 11:37:@1547.4]
  assign _T_662 = _T_52 ? 3'h0 : _T_661; // @[Lookup.scala 11:37:@1548.4]
  assign _T_663 = _T_48 ? 3'h0 : _T_662; // @[Lookup.scala 11:37:@1549.4]
  assign _T_664 = _T_44 ? 3'h0 : _T_663; // @[Lookup.scala 11:37:@1550.4]
  assign _T_667 = _T_224 ? 2'h3 : _T_234; // @[Lookup.scala 11:37:@1554.4]
  assign _T_668 = _T_220 ? 2'h3 : _T_667; // @[Lookup.scala 11:37:@1555.4]
  assign _T_669 = _T_216 ? 2'h3 : _T_668; // @[Lookup.scala 11:37:@1556.4]
  assign _T_670 = _T_212 ? 2'h3 : _T_669; // @[Lookup.scala 11:37:@1557.4]
  assign _T_671 = _T_208 ? 2'h3 : _T_670; // @[Lookup.scala 11:37:@1558.4]
  assign _T_672 = _T_204 ? 2'h3 : _T_671; // @[Lookup.scala 11:37:@1559.4]
  assign _T_673 = _T_200 ? 2'h3 : _T_672; // @[Lookup.scala 11:37:@1560.4]
  assign _T_674 = _T_196 ? 2'h3 : _T_673; // @[Lookup.scala 11:37:@1561.4]
  assign _T_675 = _T_192 ? 2'h0 : _T_674; // @[Lookup.scala 11:37:@1562.4]
  assign _T_676 = _T_188 ? 2'h0 : _T_675; // @[Lookup.scala 11:37:@1563.4]
  assign _T_677 = _T_184 ? 2'h0 : _T_676; // @[Lookup.scala 11:37:@1564.4]
  assign _T_678 = _T_180 ? 2'h0 : _T_677; // @[Lookup.scala 11:37:@1565.4]
  assign _T_679 = _T_176 ? 2'h0 : _T_678; // @[Lookup.scala 11:37:@1566.4]
  assign _T_680 = _T_172 ? 2'h0 : _T_679; // @[Lookup.scala 11:37:@1567.4]
  assign _T_681 = _T_168 ? 2'h0 : _T_680; // @[Lookup.scala 11:37:@1568.4]
  assign _T_682 = _T_164 ? 2'h0 : _T_681; // @[Lookup.scala 11:37:@1569.4]
  assign _T_683 = _T_160 ? 2'h0 : _T_682; // @[Lookup.scala 11:37:@1570.4]
  assign _T_684 = _T_156 ? 2'h0 : _T_683; // @[Lookup.scala 11:37:@1571.4]
  assign _T_685 = _T_152 ? 2'h0 : _T_684; // @[Lookup.scala 11:37:@1572.4]
  assign _T_686 = _T_148 ? 2'h0 : _T_685; // @[Lookup.scala 11:37:@1573.4]
  assign _T_687 = _T_144 ? 2'h0 : _T_686; // @[Lookup.scala 11:37:@1574.4]
  assign _T_688 = _T_140 ? 2'h0 : _T_687; // @[Lookup.scala 11:37:@1575.4]
  assign _T_689 = _T_136 ? 2'h0 : _T_688; // @[Lookup.scala 11:37:@1576.4]
  assign _T_690 = _T_132 ? 2'h0 : _T_689; // @[Lookup.scala 11:37:@1577.4]
  assign _T_691 = _T_128 ? 2'h0 : _T_690; // @[Lookup.scala 11:37:@1578.4]
  assign _T_692 = _T_124 ? 2'h0 : _T_691; // @[Lookup.scala 11:37:@1579.4]
  assign _T_693 = _T_120 ? 2'h0 : _T_692; // @[Lookup.scala 11:37:@1580.4]
  assign _T_694 = _T_116 ? 2'h0 : _T_693; // @[Lookup.scala 11:37:@1581.4]
  assign _T_695 = _T_112 ? 2'h0 : _T_694; // @[Lookup.scala 11:37:@1582.4]
  assign _T_696 = _T_108 ? 2'h0 : _T_695; // @[Lookup.scala 11:37:@1583.4]
  assign _T_697 = _T_104 ? 2'h0 : _T_696; // @[Lookup.scala 11:37:@1584.4]
  assign _T_698 = _T_100 ? 2'h0 : _T_697; // @[Lookup.scala 11:37:@1585.4]
  assign _T_699 = _T_96 ? 2'h1 : _T_698; // @[Lookup.scala 11:37:@1586.4]
  assign _T_700 = _T_92 ? 2'h1 : _T_699; // @[Lookup.scala 11:37:@1587.4]
  assign _T_701 = _T_88 ? 2'h1 : _T_700; // @[Lookup.scala 11:37:@1588.4]
  assign _T_702 = _T_84 ? 2'h1 : _T_701; // @[Lookup.scala 11:37:@1589.4]
  assign _T_703 = _T_80 ? 2'h1 : _T_702; // @[Lookup.scala 11:37:@1590.4]
  assign _T_704 = _T_76 ? 2'h0 : _T_703; // @[Lookup.scala 11:37:@1591.4]
  assign _T_705 = _T_72 ? 2'h0 : _T_704; // @[Lookup.scala 11:37:@1592.4]
  assign _T_706 = _T_68 ? 2'h0 : _T_705; // @[Lookup.scala 11:37:@1593.4]
  assign _T_707 = _T_64 ? 2'h0 : _T_706; // @[Lookup.scala 11:37:@1594.4]
  assign _T_708 = _T_60 ? 2'h0 : _T_707; // @[Lookup.scala 11:37:@1595.4]
  assign _T_709 = _T_56 ? 2'h0 : _T_708; // @[Lookup.scala 11:37:@1596.4]
  assign _T_710 = _T_52 ? 2'h2 : _T_709; // @[Lookup.scala 11:37:@1597.4]
  assign _T_711 = _T_48 ? 2'h2 : _T_710; // @[Lookup.scala 11:37:@1598.4]
  assign _T_712 = _T_44 ? 2'h0 : _T_711; // @[Lookup.scala 11:37:@1599.4]
  assign _T_718 = _T_212 ? 1'h1 : _T_216; // @[Lookup.scala 11:37:@1606.4]
  assign _T_719 = _T_208 ? 1'h1 : _T_718; // @[Lookup.scala 11:37:@1607.4]
  assign _T_720 = _T_204 ? 1'h1 : _T_719; // @[Lookup.scala 11:37:@1608.4]
  assign _T_721 = _T_200 ? 1'h1 : _T_720; // @[Lookup.scala 11:37:@1609.4]
  assign _T_722 = _T_196 ? 1'h1 : _T_721; // @[Lookup.scala 11:37:@1610.4]
  assign _T_723 = _T_192 ? 1'h0 : _T_722; // @[Lookup.scala 11:37:@1611.4]
  assign _T_724 = _T_188 ? 1'h0 : _T_723; // @[Lookup.scala 11:37:@1612.4]
  assign _T_725 = _T_184 ? 1'h1 : _T_724; // @[Lookup.scala 11:37:@1613.4]
  assign _T_726 = _T_180 ? 1'h1 : _T_725; // @[Lookup.scala 11:37:@1614.4]
  assign _T_727 = _T_176 ? 1'h1 : _T_726; // @[Lookup.scala 11:37:@1615.4]
  assign _T_728 = _T_172 ? 1'h1 : _T_727; // @[Lookup.scala 11:37:@1616.4]
  assign _T_729 = _T_168 ? 1'h1 : _T_728; // @[Lookup.scala 11:37:@1617.4]
  assign _T_730 = _T_164 ? 1'h1 : _T_729; // @[Lookup.scala 11:37:@1618.4]
  assign _T_731 = _T_160 ? 1'h1 : _T_730; // @[Lookup.scala 11:37:@1619.4]
  assign _T_732 = _T_156 ? 1'h1 : _T_731; // @[Lookup.scala 11:37:@1620.4]
  assign _T_733 = _T_152 ? 1'h1 : _T_732; // @[Lookup.scala 11:37:@1621.4]
  assign _T_734 = _T_148 ? 1'h1 : _T_733; // @[Lookup.scala 11:37:@1622.4]
  assign _T_735 = _T_144 ? 1'h1 : _T_734; // @[Lookup.scala 11:37:@1623.4]
  assign _T_736 = _T_140 ? 1'h1 : _T_735; // @[Lookup.scala 11:37:@1624.4]
  assign _T_737 = _T_136 ? 1'h1 : _T_736; // @[Lookup.scala 11:37:@1625.4]
  assign _T_738 = _T_132 ? 1'h1 : _T_737; // @[Lookup.scala 11:37:@1626.4]
  assign _T_739 = _T_128 ? 1'h1 : _T_738; // @[Lookup.scala 11:37:@1627.4]
  assign _T_740 = _T_124 ? 1'h1 : _T_739; // @[Lookup.scala 11:37:@1628.4]
  assign _T_741 = _T_120 ? 1'h1 : _T_740; // @[Lookup.scala 11:37:@1629.4]
  assign _T_742 = _T_116 ? 1'h1 : _T_741; // @[Lookup.scala 11:37:@1630.4]
  assign _T_743 = _T_112 ? 1'h1 : _T_742; // @[Lookup.scala 11:37:@1631.4]
  assign _T_744 = _T_108 ? 1'h0 : _T_743; // @[Lookup.scala 11:37:@1632.4]
  assign _T_745 = _T_104 ? 1'h0 : _T_744; // @[Lookup.scala 11:37:@1633.4]
  assign _T_746 = _T_100 ? 1'h0 : _T_745; // @[Lookup.scala 11:37:@1634.4]
  assign _T_747 = _T_96 ? 1'h1 : _T_746; // @[Lookup.scala 11:37:@1635.4]
  assign _T_748 = _T_92 ? 1'h1 : _T_747; // @[Lookup.scala 11:37:@1636.4]
  assign _T_749 = _T_88 ? 1'h1 : _T_748; // @[Lookup.scala 11:37:@1637.4]
  assign _T_750 = _T_84 ? 1'h1 : _T_749; // @[Lookup.scala 11:37:@1638.4]
  assign _T_751 = _T_80 ? 1'h1 : _T_750; // @[Lookup.scala 11:37:@1639.4]
  assign _T_752 = _T_76 ? 1'h0 : _T_751; // @[Lookup.scala 11:37:@1640.4]
  assign _T_753 = _T_72 ? 1'h0 : _T_752; // @[Lookup.scala 11:37:@1641.4]
  assign _T_754 = _T_68 ? 1'h0 : _T_753; // @[Lookup.scala 11:37:@1642.4]
  assign _T_755 = _T_64 ? 1'h0 : _T_754; // @[Lookup.scala 11:37:@1643.4]
  assign _T_756 = _T_60 ? 1'h0 : _T_755; // @[Lookup.scala 11:37:@1644.4]
  assign _T_757 = _T_56 ? 1'h0 : _T_756; // @[Lookup.scala 11:37:@1645.4]
  assign _T_758 = _T_52 ? 1'h1 : _T_757; // @[Lookup.scala 11:37:@1646.4]
  assign _T_759 = _T_48 ? 1'h1 : _T_758; // @[Lookup.scala 11:37:@1647.4]
  assign _T_760 = _T_44 ? 1'h1 : _T_759; // @[Lookup.scala 11:37:@1648.4]
  assign _T_762 = _T_228 ? 3'h4 : 3'h0; // @[Lookup.scala 11:37:@1651.4]
  assign _T_763 = _T_224 ? 3'h4 : _T_762; // @[Lookup.scala 11:37:@1652.4]
  assign _T_764 = _T_220 ? 3'h4 : _T_763; // @[Lookup.scala 11:37:@1653.4]
  assign _T_765 = _T_216 ? 3'h3 : _T_764; // @[Lookup.scala 11:37:@1654.4]
  assign _T_766 = _T_212 ? 3'h2 : _T_765; // @[Lookup.scala 11:37:@1655.4]
  assign _T_767 = _T_208 ? 3'h1 : _T_766; // @[Lookup.scala 11:37:@1656.4]
  assign _T_768 = _T_204 ? 3'h3 : _T_767; // @[Lookup.scala 11:37:@1657.4]
  assign _T_769 = _T_200 ? 3'h2 : _T_768; // @[Lookup.scala 11:37:@1658.4]
  assign _T_770 = _T_196 ? 3'h1 : _T_769; // @[Lookup.scala 11:37:@1659.4]
  assign _T_771 = _T_192 ? 3'h0 : _T_770; // @[Lookup.scala 11:37:@1660.4]
  assign _T_772 = _T_188 ? 3'h0 : _T_771; // @[Lookup.scala 11:37:@1661.4]
  assign _T_773 = _T_184 ? 3'h0 : _T_772; // @[Lookup.scala 11:37:@1662.4]
  assign _T_774 = _T_180 ? 3'h0 : _T_773; // @[Lookup.scala 11:37:@1663.4]
  assign _T_775 = _T_176 ? 3'h0 : _T_774; // @[Lookup.scala 11:37:@1664.4]
  assign _T_776 = _T_172 ? 3'h0 : _T_775; // @[Lookup.scala 11:37:@1665.4]
  assign _T_777 = _T_168 ? 3'h0 : _T_776; // @[Lookup.scala 11:37:@1666.4]
  assign _T_778 = _T_164 ? 3'h0 : _T_777; // @[Lookup.scala 11:37:@1667.4]
  assign _T_779 = _T_160 ? 3'h0 : _T_778; // @[Lookup.scala 11:37:@1668.4]
  assign _T_780 = _T_156 ? 3'h0 : _T_779; // @[Lookup.scala 11:37:@1669.4]
  assign _T_781 = _T_152 ? 3'h0 : _T_780; // @[Lookup.scala 11:37:@1670.4]
  assign _T_782 = _T_148 ? 3'h0 : _T_781; // @[Lookup.scala 11:37:@1671.4]
  assign _T_783 = _T_144 ? 3'h0 : _T_782; // @[Lookup.scala 11:37:@1672.4]
  assign _T_784 = _T_140 ? 3'h0 : _T_783; // @[Lookup.scala 11:37:@1673.4]
  assign _T_785 = _T_136 ? 3'h0 : _T_784; // @[Lookup.scala 11:37:@1674.4]
  assign _T_786 = _T_132 ? 3'h0 : _T_785; // @[Lookup.scala 11:37:@1675.4]
  assign _T_787 = _T_128 ? 3'h0 : _T_786; // @[Lookup.scala 11:37:@1676.4]
  assign _T_788 = _T_124 ? 3'h0 : _T_787; // @[Lookup.scala 11:37:@1677.4]
  assign _T_789 = _T_120 ? 3'h0 : _T_788; // @[Lookup.scala 11:37:@1678.4]
  assign _T_790 = _T_116 ? 3'h0 : _T_789; // @[Lookup.scala 11:37:@1679.4]
  assign _T_791 = _T_112 ? 3'h0 : _T_790; // @[Lookup.scala 11:37:@1680.4]
  assign _T_792 = _T_108 ? 3'h0 : _T_791; // @[Lookup.scala 11:37:@1681.4]
  assign _T_793 = _T_104 ? 3'h0 : _T_792; // @[Lookup.scala 11:37:@1682.4]
  assign _T_794 = _T_100 ? 3'h0 : _T_793; // @[Lookup.scala 11:37:@1683.4]
  assign _T_795 = _T_96 ? 3'h0 : _T_794; // @[Lookup.scala 11:37:@1684.4]
  assign _T_796 = _T_92 ? 3'h0 : _T_795; // @[Lookup.scala 11:37:@1685.4]
  assign _T_797 = _T_88 ? 3'h0 : _T_796; // @[Lookup.scala 11:37:@1686.4]
  assign _T_798 = _T_84 ? 3'h0 : _T_797; // @[Lookup.scala 11:37:@1687.4]
  assign _T_799 = _T_80 ? 3'h0 : _T_798; // @[Lookup.scala 11:37:@1688.4]
  assign _T_800 = _T_76 ? 3'h0 : _T_799; // @[Lookup.scala 11:37:@1689.4]
  assign _T_801 = _T_72 ? 3'h0 : _T_800; // @[Lookup.scala 11:37:@1690.4]
  assign _T_802 = _T_68 ? 3'h0 : _T_801; // @[Lookup.scala 11:37:@1691.4]
  assign _T_803 = _T_64 ? 3'h0 : _T_802; // @[Lookup.scala 11:37:@1692.4]
  assign _T_804 = _T_60 ? 3'h0 : _T_803; // @[Lookup.scala 11:37:@1693.4]
  assign _T_805 = _T_56 ? 3'h0 : _T_804; // @[Lookup.scala 11:37:@1694.4]
  assign _T_806 = _T_52 ? 3'h0 : _T_805; // @[Lookup.scala 11:37:@1695.4]
  assign _T_807 = _T_48 ? 3'h0 : _T_806; // @[Lookup.scala 11:37:@1696.4]
  assign _T_808 = _T_44 ? 3'h0 : _T_807; // @[Lookup.scala 11:37:@1697.4]
  assign _T_809 = _T_232 ? 1'h0 : 1'h1; // @[Lookup.scala 11:37:@1699.4]
  assign _T_810 = _T_228 ? 1'h0 : _T_809; // @[Lookup.scala 11:37:@1700.4]
  assign _T_811 = _T_224 ? 1'h0 : _T_810; // @[Lookup.scala 11:37:@1701.4]
  assign _T_812 = _T_220 ? 1'h0 : _T_811; // @[Lookup.scala 11:37:@1702.4]
  assign _T_813 = _T_216 ? 1'h0 : _T_812; // @[Lookup.scala 11:37:@1703.4]
  assign _T_814 = _T_212 ? 1'h0 : _T_813; // @[Lookup.scala 11:37:@1704.4]
  assign _T_815 = _T_208 ? 1'h0 : _T_814; // @[Lookup.scala 11:37:@1705.4]
  assign _T_816 = _T_204 ? 1'h0 : _T_815; // @[Lookup.scala 11:37:@1706.4]
  assign _T_817 = _T_200 ? 1'h0 : _T_816; // @[Lookup.scala 11:37:@1707.4]
  assign _T_818 = _T_196 ? 1'h0 : _T_817; // @[Lookup.scala 11:37:@1708.4]
  assign _T_819 = _T_192 ? 1'h0 : _T_818; // @[Lookup.scala 11:37:@1709.4]
  assign _T_820 = _T_188 ? 1'h0 : _T_819; // @[Lookup.scala 11:37:@1710.4]
  assign _T_821 = _T_184 ? 1'h0 : _T_820; // @[Lookup.scala 11:37:@1711.4]
  assign _T_822 = _T_180 ? 1'h0 : _T_821; // @[Lookup.scala 11:37:@1712.4]
  assign _T_823 = _T_176 ? 1'h0 : _T_822; // @[Lookup.scala 11:37:@1713.4]
  assign _T_824 = _T_172 ? 1'h0 : _T_823; // @[Lookup.scala 11:37:@1714.4]
  assign _T_825 = _T_168 ? 1'h0 : _T_824; // @[Lookup.scala 11:37:@1715.4]
  assign _T_826 = _T_164 ? 1'h0 : _T_825; // @[Lookup.scala 11:37:@1716.4]
  assign _T_827 = _T_160 ? 1'h0 : _T_826; // @[Lookup.scala 11:37:@1717.4]
  assign _T_828 = _T_156 ? 1'h0 : _T_827; // @[Lookup.scala 11:37:@1718.4]
  assign _T_829 = _T_152 ? 1'h0 : _T_828; // @[Lookup.scala 11:37:@1719.4]
  assign _T_830 = _T_148 ? 1'h0 : _T_829; // @[Lookup.scala 11:37:@1720.4]
  assign _T_831 = _T_144 ? 1'h0 : _T_830; // @[Lookup.scala 11:37:@1721.4]
  assign _T_832 = _T_140 ? 1'h0 : _T_831; // @[Lookup.scala 11:37:@1722.4]
  assign _T_833 = _T_136 ? 1'h0 : _T_832; // @[Lookup.scala 11:37:@1723.4]
  assign _T_834 = _T_132 ? 1'h0 : _T_833; // @[Lookup.scala 11:37:@1724.4]
  assign _T_835 = _T_128 ? 1'h0 : _T_834; // @[Lookup.scala 11:37:@1725.4]
  assign _T_836 = _T_124 ? 1'h0 : _T_835; // @[Lookup.scala 11:37:@1726.4]
  assign _T_837 = _T_120 ? 1'h0 : _T_836; // @[Lookup.scala 11:37:@1727.4]
  assign _T_838 = _T_116 ? 1'h0 : _T_837; // @[Lookup.scala 11:37:@1728.4]
  assign _T_839 = _T_112 ? 1'h0 : _T_838; // @[Lookup.scala 11:37:@1729.4]
  assign _T_840 = _T_108 ? 1'h0 : _T_839; // @[Lookup.scala 11:37:@1730.4]
  assign _T_841 = _T_104 ? 1'h0 : _T_840; // @[Lookup.scala 11:37:@1731.4]
  assign _T_842 = _T_100 ? 1'h0 : _T_841; // @[Lookup.scala 11:37:@1732.4]
  assign _T_843 = _T_96 ? 1'h0 : _T_842; // @[Lookup.scala 11:37:@1733.4]
  assign _T_844 = _T_92 ? 1'h0 : _T_843; // @[Lookup.scala 11:37:@1734.4]
  assign _T_845 = _T_88 ? 1'h0 : _T_844; // @[Lookup.scala 11:37:@1735.4]
  assign _T_846 = _T_84 ? 1'h0 : _T_845; // @[Lookup.scala 11:37:@1736.4]
  assign _T_847 = _T_80 ? 1'h0 : _T_846; // @[Lookup.scala 11:37:@1737.4]
  assign _T_848 = _T_76 ? 1'h0 : _T_847; // @[Lookup.scala 11:37:@1738.4]
  assign _T_849 = _T_72 ? 1'h0 : _T_848; // @[Lookup.scala 11:37:@1739.4]
  assign _T_850 = _T_68 ? 1'h0 : _T_849; // @[Lookup.scala 11:37:@1740.4]
  assign _T_851 = _T_64 ? 1'h0 : _T_850; // @[Lookup.scala 11:37:@1741.4]
  assign _T_852 = _T_60 ? 1'h0 : _T_851; // @[Lookup.scala 11:37:@1742.4]
  assign _T_853 = _T_56 ? 1'h0 : _T_852; // @[Lookup.scala 11:37:@1743.4]
  assign _T_854 = _T_52 ? 1'h0 : _T_853; // @[Lookup.scala 11:37:@1744.4]
  assign _T_855 = _T_48 ? 1'h0 : _T_854; // @[Lookup.scala 11:37:@1745.4]
  assign _T_856 = _T_44 ? 1'h0 : _T_855; // @[Lookup.scala 11:37:@1746.4]
  assign _T_896 = _T_76 ? 1'h1 : _T_319; // @[Lookup.scala 11:37:@1787.4]
  assign _T_897 = _T_72 ? 1'h1 : _T_896; // @[Lookup.scala 11:37:@1788.4]
  assign _T_898 = _T_68 ? 1'h1 : _T_897; // @[Lookup.scala 11:37:@1789.4]
  assign _T_899 = _T_64 ? 1'h1 : _T_898; // @[Lookup.scala 11:37:@1790.4]
  assign _T_900 = _T_60 ? 1'h1 : _T_899; // @[Lookup.scala 11:37:@1791.4]
  assign _T_901 = _T_56 ? 1'h1 : _T_900; // @[Lookup.scala 11:37:@1792.4]
  assign _T_902 = _T_52 ? 1'h1 : _T_901; // @[Lookup.scala 11:37:@1793.4]
  assign _T_903 = _T_48 ? 1'h0 : _T_902; // @[Lookup.scala 11:37:@1794.4]
  assign _T_904 = _T_44 ? 1'h0 : _T_903; // @[Lookup.scala 11:37:@1795.4]
  assign _T_936 = _T_108 ? 1'h1 : _T_359; // @[Lookup.scala 11:37:@1828.4]
  assign _T_937 = _T_104 ? 1'h1 : _T_936; // @[Lookup.scala 11:37:@1829.4]
  assign _T_938 = _T_100 ? 1'h1 : _T_937; // @[Lookup.scala 11:37:@1830.4]
  assign _T_939 = _T_96 ? 1'h0 : _T_938; // @[Lookup.scala 11:37:@1831.4]
  assign _T_940 = _T_92 ? 1'h0 : _T_939; // @[Lookup.scala 11:37:@1832.4]
  assign _T_941 = _T_88 ? 1'h0 : _T_940; // @[Lookup.scala 11:37:@1833.4]
  assign _T_942 = _T_84 ? 1'h0 : _T_941; // @[Lookup.scala 11:37:@1834.4]
  assign _T_943 = _T_80 ? 1'h0 : _T_942; // @[Lookup.scala 11:37:@1835.4]
  assign _T_944 = _T_76 ? 1'h1 : _T_943; // @[Lookup.scala 11:37:@1836.4]
  assign _T_945 = _T_72 ? 1'h1 : _T_944; // @[Lookup.scala 11:37:@1837.4]
  assign _T_946 = _T_68 ? 1'h1 : _T_945; // @[Lookup.scala 11:37:@1838.4]
  assign _T_947 = _T_64 ? 1'h1 : _T_946; // @[Lookup.scala 11:37:@1839.4]
  assign _T_948 = _T_60 ? 1'h1 : _T_947; // @[Lookup.scala 11:37:@1840.4]
  assign _T_949 = _T_56 ? 1'h1 : _T_948; // @[Lookup.scala 11:37:@1841.4]
  assign _T_950 = _T_52 ? 1'h0 : _T_949; // @[Lookup.scala 11:37:@1842.4]
  assign _T_951 = _T_48 ? 1'h0 : _T_950; // @[Lookup.scala 11:37:@1843.4]
  assign _T_952 = _T_44 ? 1'h0 : _T_951; // @[Lookup.scala 11:37:@1844.4]
  assign io_pc_sel = _T_40 ? 2'h0 : _T_280; // @[pipeline_control.scala 112:16:@1846.4]
  assign io_inst_kill = _T_40 ? 1'h0 : _T_568; // @[pipeline_control.scala 113:16:@1848.4]
  assign io_a_sel = _T_40 ? 1'h0 : _T_328; // @[pipeline_control.scala 116:17:@1849.4]
  assign io_b_sel = _T_40 ? 1'h0 : _T_376; // @[pipeline_control.scala 117:17:@1850.4]
  assign io_imm_sel = _T_40 ? 3'h3 : _T_424; // @[pipeline_control.scala 118:17:@1851.4]
  assign io_alu_op = {{1'd0}, ctrlSignals_4}; // @[pipeline_control.scala 119:17:@1852.4]
  assign io_br_type = _T_40 ? 3'h0 : _T_520; // @[pipeline_control.scala 120:17:@1853.4]
  assign io_st_type = _T_40 ? 2'h0 : _T_616; // @[pipeline_control.scala 121:17:@1854.4]
  assign io_ld_type = _T_40 ? 3'h0 : _T_664; // @[pipeline_control.scala 124:17:@1855.4]
  assign io_wb_mux_sel = _T_40 ? 2'h0 : _T_712; // @[pipeline_control.scala 125:17:@1856.4]
  assign io_wb_en = _T_40 ? 1'h1 : _T_760; // @[pipeline_control.scala 126:17:@1858.4]
  assign io_csr_cmd = _T_40 ? 3'h0 : _T_808; // @[pipeline_control.scala 127:17:@1859.4]
  assign io_illegal = _T_40 ? 1'h0 : _T_856; // @[pipeline_control.scala 128:17:@1860.4]
  assign io_en_rs1 = _T_40 ? 1'h0 : _T_904; // @[pipeline_control.scala 129:17:@1861.4]
  assign io_en_rs2 = _T_40 ? 1'h0 : _T_952; // @[pipeline_control.scala 130:17:@1862.4]
endmodule
module Core( // @[:@1864.2]
  input         clock, // @[:@1865.4]
  input         reset, // @[:@1866.4]
  input         io_irq_uart_irq, // @[:@1867.4]
  input         io_irq_spi_irq, // @[:@1867.4]
  input         io_irq_m1_irq, // @[:@1867.4]
  input         io_irq_m2_irq, // @[:@1867.4]
  input         io_irq_m3_irq, // @[:@1867.4]
  output [31:0] io_ibus_addr, // @[:@1867.4]
  input  [31:0] io_ibus_inst, // @[:@1867.4]
  input         io_ibus_valid, // @[:@1867.4]
  output [31:0] io_dbus_addr, // @[:@1867.4]
  output [31:0] io_dbus_wdata, // @[:@1867.4]
  input  [31:0] io_dbus_rdata, // @[:@1867.4]
  output        io_dbus_rd_en, // @[:@1867.4]
  output        io_dbus_wr_en, // @[:@1867.4]
  output [1:0]  io_dbus_st_type, // @[:@1867.4]
  output [2:0]  io_dbus_ld_type, // @[:@1867.4]
  input         io_dbus_valid // @[:@1867.4]
);
  wire  dpath_clock; // @[core.scala 58:25:@1869.4]
  wire  dpath_reset; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_irq_uart_irq; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_irq_spi_irq; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_irq_m1_irq; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_irq_m2_irq; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_irq_m3_irq; // @[core.scala 58:25:@1869.4]
  wire [31:0] dpath_io_ibus_addr; // @[core.scala 58:25:@1869.4]
  wire [31:0] dpath_io_ibus_inst; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_ibus_valid; // @[core.scala 58:25:@1869.4]
  wire [31:0] dpath_io_dbus_addr; // @[core.scala 58:25:@1869.4]
  wire [31:0] dpath_io_dbus_wdata; // @[core.scala 58:25:@1869.4]
  wire [31:0] dpath_io_dbus_rdata; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_dbus_rd_en; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_dbus_wr_en; // @[core.scala 58:25:@1869.4]
  wire [1:0] dpath_io_dbus_st_type; // @[core.scala 58:25:@1869.4]
  wire [2:0] dpath_io_dbus_ld_type; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_dbus_valid; // @[core.scala 58:25:@1869.4]
  wire [31:0] dpath_io_ctrl_inst; // @[core.scala 58:25:@1869.4]
  wire [1:0] dpath_io_ctrl_pc_sel; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_ctrl_inst_kill; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_ctrl_a_sel; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_ctrl_b_sel; // @[core.scala 58:25:@1869.4]
  wire [2:0] dpath_io_ctrl_imm_sel; // @[core.scala 58:25:@1869.4]
  wire [4:0] dpath_io_ctrl_alu_op; // @[core.scala 58:25:@1869.4]
  wire [2:0] dpath_io_ctrl_br_type; // @[core.scala 58:25:@1869.4]
  wire [1:0] dpath_io_ctrl_st_type; // @[core.scala 58:25:@1869.4]
  wire [2:0] dpath_io_ctrl_ld_type; // @[core.scala 58:25:@1869.4]
  wire [1:0] dpath_io_ctrl_wb_mux_sel; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_ctrl_wb_en; // @[core.scala 58:25:@1869.4]
  wire [2:0] dpath_io_ctrl_csr_cmd; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_ctrl_illegal; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_ctrl_en_rs1; // @[core.scala 58:25:@1869.4]
  wire  dpath_io_ctrl_en_rs2; // @[core.scala 58:25:@1869.4]
  wire [31:0] ctrl_io_inst; // @[core.scala 59:25:@1872.4]
  wire [1:0] ctrl_io_pc_sel; // @[core.scala 59:25:@1872.4]
  wire  ctrl_io_inst_kill; // @[core.scala 59:25:@1872.4]
  wire  ctrl_io_a_sel; // @[core.scala 59:25:@1872.4]
  wire  ctrl_io_b_sel; // @[core.scala 59:25:@1872.4]
  wire [2:0] ctrl_io_imm_sel; // @[core.scala 59:25:@1872.4]
  wire [4:0] ctrl_io_alu_op; // @[core.scala 59:25:@1872.4]
  wire [2:0] ctrl_io_br_type; // @[core.scala 59:25:@1872.4]
  wire [1:0] ctrl_io_st_type; // @[core.scala 59:25:@1872.4]
  wire [2:0] ctrl_io_ld_type; // @[core.scala 59:25:@1872.4]
  wire [1:0] ctrl_io_wb_mux_sel; // @[core.scala 59:25:@1872.4]
  wire  ctrl_io_wb_en; // @[core.scala 59:25:@1872.4]
  wire [2:0] ctrl_io_csr_cmd; // @[core.scala 59:25:@1872.4]
  wire  ctrl_io_illegal; // @[core.scala 59:25:@1872.4]
  wire  ctrl_io_en_rs1; // @[core.scala 59:25:@1872.4]
  wire  ctrl_io_en_rs2; // @[core.scala 59:25:@1872.4]
  Datapath dpath ( // @[core.scala 58:25:@1869.4]
    .clock(dpath_clock),
    .reset(dpath_reset),
    .io_irq_uart_irq(dpath_io_irq_uart_irq),
    .io_irq_spi_irq(dpath_io_irq_spi_irq),
    .io_irq_m1_irq(dpath_io_irq_m1_irq),
    .io_irq_m2_irq(dpath_io_irq_m2_irq),
    .io_irq_m3_irq(dpath_io_irq_m3_irq),
    .io_ibus_addr(dpath_io_ibus_addr),
    .io_ibus_inst(dpath_io_ibus_inst),
    .io_ibus_valid(dpath_io_ibus_valid),
    .io_dbus_addr(dpath_io_dbus_addr),
    .io_dbus_wdata(dpath_io_dbus_wdata),
    .io_dbus_rdata(dpath_io_dbus_rdata),
    .io_dbus_rd_en(dpath_io_dbus_rd_en),
    .io_dbus_wr_en(dpath_io_dbus_wr_en),
    .io_dbus_st_type(dpath_io_dbus_st_type),
    .io_dbus_ld_type(dpath_io_dbus_ld_type),
    .io_dbus_valid(dpath_io_dbus_valid),
    .io_ctrl_inst(dpath_io_ctrl_inst),
    .io_ctrl_pc_sel(dpath_io_ctrl_pc_sel),
    .io_ctrl_inst_kill(dpath_io_ctrl_inst_kill),
    .io_ctrl_a_sel(dpath_io_ctrl_a_sel),
    .io_ctrl_b_sel(dpath_io_ctrl_b_sel),
    .io_ctrl_imm_sel(dpath_io_ctrl_imm_sel),
    .io_ctrl_alu_op(dpath_io_ctrl_alu_op),
    .io_ctrl_br_type(dpath_io_ctrl_br_type),
    .io_ctrl_st_type(dpath_io_ctrl_st_type),
    .io_ctrl_ld_type(dpath_io_ctrl_ld_type),
    .io_ctrl_wb_mux_sel(dpath_io_ctrl_wb_mux_sel),
    .io_ctrl_wb_en(dpath_io_ctrl_wb_en),
    .io_ctrl_csr_cmd(dpath_io_ctrl_csr_cmd),
    .io_ctrl_illegal(dpath_io_ctrl_illegal),
    .io_ctrl_en_rs1(dpath_io_ctrl_en_rs1),
    .io_ctrl_en_rs2(dpath_io_ctrl_en_rs2)
  );
  Control ctrl ( // @[core.scala 59:25:@1872.4]
    .io_inst(ctrl_io_inst),
    .io_pc_sel(ctrl_io_pc_sel),
    .io_inst_kill(ctrl_io_inst_kill),
    .io_a_sel(ctrl_io_a_sel),
    .io_b_sel(ctrl_io_b_sel),
    .io_imm_sel(ctrl_io_imm_sel),
    .io_alu_op(ctrl_io_alu_op),
    .io_br_type(ctrl_io_br_type),
    .io_st_type(ctrl_io_st_type),
    .io_ld_type(ctrl_io_ld_type),
    .io_wb_mux_sel(ctrl_io_wb_mux_sel),
    .io_wb_en(ctrl_io_wb_en),
    .io_csr_cmd(ctrl_io_csr_cmd),
    .io_illegal(ctrl_io_illegal),
    .io_en_rs1(ctrl_io_en_rs1),
    .io_en_rs2(ctrl_io_en_rs2)
  );
  assign io_ibus_addr = dpath_io_ibus_addr; // @[core.scala 64:17:@1882.4]
  assign io_dbus_addr = dpath_io_dbus_addr; // @[core.scala 65:17:@1890.4]
  assign io_dbus_wdata = dpath_io_dbus_wdata; // @[core.scala 65:17:@1889.4]
  assign io_dbus_rd_en = dpath_io_dbus_rd_en; // @[core.scala 65:17:@1887.4]
  assign io_dbus_wr_en = dpath_io_dbus_wr_en; // @[core.scala 65:17:@1886.4]
  assign io_dbus_st_type = dpath_io_dbus_st_type; // @[core.scala 65:17:@1885.4]
  assign io_dbus_ld_type = dpath_io_dbus_ld_type; // @[core.scala 65:17:@1884.4]
  assign dpath_clock = clock; // @[:@1870.4]
  assign dpath_reset = reset; // @[:@1871.4]
  assign dpath_io_irq_uart_irq = io_irq_uart_irq; // @[core.scala 63:17:@1879.4]
  assign dpath_io_irq_spi_irq = io_irq_spi_irq; // @[core.scala 63:17:@1878.4]
  assign dpath_io_irq_m1_irq = io_irq_m1_irq; // @[core.scala 63:17:@1877.4]
  assign dpath_io_irq_m2_irq = io_irq_m2_irq; // @[core.scala 63:17:@1876.4]
  assign dpath_io_irq_m3_irq = io_irq_m3_irq; // @[core.scala 63:17:@1875.4]
  assign dpath_io_ibus_inst = io_ibus_inst; // @[core.scala 64:17:@1881.4]
  assign dpath_io_ibus_valid = io_ibus_valid; // @[core.scala 64:17:@1880.4]
  assign dpath_io_dbus_rdata = io_dbus_rdata; // @[core.scala 65:17:@1888.4]
  assign dpath_io_dbus_valid = io_dbus_valid; // @[core.scala 65:17:@1883.4]
  assign dpath_io_ctrl_pc_sel = ctrl_io_pc_sel; // @[core.scala 66:17:@1905.4]
  assign dpath_io_ctrl_inst_kill = ctrl_io_inst_kill; // @[core.scala 66:17:@1904.4]
  assign dpath_io_ctrl_a_sel = ctrl_io_a_sel; // @[core.scala 66:17:@1903.4]
  assign dpath_io_ctrl_b_sel = ctrl_io_b_sel; // @[core.scala 66:17:@1902.4]
  assign dpath_io_ctrl_imm_sel = ctrl_io_imm_sel; // @[core.scala 66:17:@1901.4]
  assign dpath_io_ctrl_alu_op = ctrl_io_alu_op; // @[core.scala 66:17:@1900.4]
  assign dpath_io_ctrl_br_type = ctrl_io_br_type; // @[core.scala 66:17:@1899.4]
  assign dpath_io_ctrl_st_type = ctrl_io_st_type; // @[core.scala 66:17:@1898.4]
  assign dpath_io_ctrl_ld_type = ctrl_io_ld_type; // @[core.scala 66:17:@1897.4]
  assign dpath_io_ctrl_wb_mux_sel = ctrl_io_wb_mux_sel; // @[core.scala 66:17:@1896.4]
  assign dpath_io_ctrl_wb_en = ctrl_io_wb_en; // @[core.scala 66:17:@1895.4]
  assign dpath_io_ctrl_csr_cmd = ctrl_io_csr_cmd; // @[core.scala 66:17:@1894.4]
  assign dpath_io_ctrl_illegal = ctrl_io_illegal; // @[core.scala 66:17:@1893.4]
  assign dpath_io_ctrl_en_rs1 = ctrl_io_en_rs1; // @[core.scala 66:17:@1892.4]
  assign dpath_io_ctrl_en_rs2 = ctrl_io_en_rs2; // @[core.scala 66:17:@1891.4]
  assign ctrl_io_inst = dpath_io_ctrl_inst; // @[core.scala 66:17:@1906.4]
endmodule
module DMem( // @[:@1908.2]
  input         clock, // @[:@1909.4]
  input  [10:0] io_dmem_addr, // @[:@1911.4]
  input  [31:0] io_dmem_wdata, // @[:@1911.4]
  output [31:0] io_dmem_rdata, // @[:@1911.4]
  input         io_wr_en, // @[:@1911.4]
  input  [3:0]  io_st_type // @[:@1911.4]
);
  reg [7:0] dmem [0:2047]; // @[memory.scala 78:26:@1913.4]
  reg [31:0] _RAND_0;
  wire [7:0] dmem__T_46_data; // @[memory.scala 78:26:@1913.4]
  wire [10:0] dmem__T_46_addr; // @[memory.scala 78:26:@1913.4]
  wire [7:0] dmem__T_50_data; // @[memory.scala 78:26:@1913.4]
  wire [10:0] dmem__T_50_addr; // @[memory.scala 78:26:@1913.4]
  wire [7:0] dmem__T_54_data; // @[memory.scala 78:26:@1913.4]
  wire [10:0] dmem__T_54_addr; // @[memory.scala 78:26:@1913.4]
  wire [7:0] dmem__T_55_data; // @[memory.scala 78:26:@1913.4]
  wire [10:0] dmem__T_55_addr; // @[memory.scala 78:26:@1913.4]
  wire [7:0] dmem__T_19_data; // @[memory.scala 78:26:@1913.4]
  wire [10:0] dmem__T_19_addr; // @[memory.scala 78:26:@1913.4]
  wire  dmem__T_19_mask; // @[memory.scala 78:26:@1913.4]
  wire  dmem__T_19_en; // @[memory.scala 78:26:@1913.4]
  wire [7:0] dmem__T_26_data; // @[memory.scala 78:26:@1913.4]
  wire [10:0] dmem__T_26_addr; // @[memory.scala 78:26:@1913.4]
  wire  dmem__T_26_mask; // @[memory.scala 78:26:@1913.4]
  wire  dmem__T_26_en; // @[memory.scala 78:26:@1913.4]
  wire [7:0] dmem__T_33_data; // @[memory.scala 78:26:@1913.4]
  wire [10:0] dmem__T_33_addr; // @[memory.scala 78:26:@1913.4]
  wire  dmem__T_33_mask; // @[memory.scala 78:26:@1913.4]
  wire  dmem__T_33_en; // @[memory.scala 78:26:@1913.4]
  wire [7:0] dmem__T_40_data; // @[memory.scala 78:26:@1913.4]
  wire [10:0] dmem__T_40_addr; // @[memory.scala 78:26:@1913.4]
  wire  dmem__T_40_mask; // @[memory.scala 78:26:@1913.4]
  wire  dmem__T_40_en; // @[memory.scala 78:26:@1913.4]
  wire  _T_17; // @[memory.scala 86:18:@1915.6]
  wire  _GEN_3; // @[memory.scala 86:30:@1917.6]
  wire  _T_21; // @[memory.scala 89:18:@1922.6]
  wire [11:0] _T_24; // @[memory.scala 90:17:@1925.8]
  wire [10:0] _T_25; // @[memory.scala 90:17:@1926.8]
  wire  _T_28; // @[memory.scala 92:18:@1931.6]
  wire [11:0] _T_31; // @[memory.scala 93:17:@1934.8]
  wire [10:0] _T_32; // @[memory.scala 93:17:@1935.8]
  wire  _T_35; // @[memory.scala 95:18:@1940.6]
  wire [11:0] _T_38; // @[memory.scala 96:17:@1943.8]
  wire [10:0] _T_39; // @[memory.scala 96:17:@1944.8]
  wire [15:0] _T_56; // @[Cat.scala 30:58:@1961.4]
  wire [15:0] _T_57; // @[Cat.scala 30:58:@1962.4]
  reg [10:0] dmem__T_46_addr_pipe_0;
  reg [31:0] _RAND_1;
  reg [10:0] dmem__T_50_addr_pipe_0;
  reg [31:0] _RAND_2;
  reg [10:0] dmem__T_54_addr_pipe_0;
  reg [31:0] _RAND_3;
  reg [10:0] dmem__T_55_addr_pipe_0;
  reg [31:0] _RAND_4;
  assign dmem__T_46_addr = dmem__T_46_addr_pipe_0;
  assign dmem__T_46_data = dmem[dmem__T_46_addr]; // @[memory.scala 78:26:@1913.4]
  assign dmem__T_50_addr = dmem__T_50_addr_pipe_0;
  assign dmem__T_50_data = dmem[dmem__T_50_addr]; // @[memory.scala 78:26:@1913.4]
  assign dmem__T_54_addr = dmem__T_54_addr_pipe_0;
  assign dmem__T_54_data = dmem[dmem__T_54_addr]; // @[memory.scala 78:26:@1913.4]
  assign dmem__T_55_addr = dmem__T_55_addr_pipe_0;
  assign dmem__T_55_data = dmem[dmem__T_55_addr]; // @[memory.scala 78:26:@1913.4]
  assign dmem__T_19_data = io_dmem_wdata[7:0];
  assign dmem__T_19_addr = io_dmem_addr;
  assign dmem__T_19_mask = 1'h1;
  assign dmem__T_19_en = io_wr_en ? _T_17 : 1'h0;
  assign dmem__T_26_data = io_dmem_wdata[15:8];
  assign dmem__T_26_addr = io_dmem_addr + 11'h1;
  assign dmem__T_26_mask = 1'h1;
  assign dmem__T_26_en = io_wr_en ? _T_21 : 1'h0;
  assign dmem__T_33_data = io_dmem_wdata[23:16];
  assign dmem__T_33_addr = io_dmem_addr + 11'h2;
  assign dmem__T_33_mask = 1'h1;
  assign dmem__T_33_en = io_wr_en ? _T_28 : 1'h0;
  assign dmem__T_40_data = io_dmem_wdata[31:24];
  assign dmem__T_40_addr = io_dmem_addr + 11'h3;
  assign dmem__T_40_mask = 1'h1;
  assign dmem__T_40_en = io_wr_en ? _T_35 : 1'h0;
  assign _T_17 = io_st_type[0]; // @[memory.scala 86:18:@1915.6]
  assign _GEN_3 = 1'h1; // @[memory.scala 86:30:@1917.6]
  assign _T_21 = io_st_type[1]; // @[memory.scala 89:18:@1922.6]
  assign _T_24 = io_dmem_addr + 11'h1; // @[memory.scala 90:17:@1925.8]
  assign _T_25 = io_dmem_addr + 11'h1; // @[memory.scala 90:17:@1926.8]
  assign _T_28 = io_st_type[2]; // @[memory.scala 92:18:@1931.6]
  assign _T_31 = io_dmem_addr + 11'h2; // @[memory.scala 93:17:@1934.8]
  assign _T_32 = io_dmem_addr + 11'h2; // @[memory.scala 93:17:@1935.8]
  assign _T_35 = io_st_type[3]; // @[memory.scala 95:18:@1940.6]
  assign _T_38 = io_dmem_addr + 11'h3; // @[memory.scala 96:17:@1943.8]
  assign _T_39 = io_dmem_addr + 11'h3; // @[memory.scala 96:17:@1944.8]
  assign _T_56 = {dmem__T_54_data,dmem__T_55_data}; // @[Cat.scala 30:58:@1961.4]
  assign _T_57 = {dmem__T_46_data,dmem__T_50_data}; // @[Cat.scala 30:58:@1962.4]
  assign io_dmem_rdata = {_T_57,_T_56}; // @[memory.scala 103:17:@1965.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2048; initvar = initvar+1)
    dmem[initvar] = _RAND_0[7:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  dmem__T_46_addr_pipe_0 = _RAND_1[10:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  dmem__T_50_addr_pipe_0 = _RAND_2[10:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  dmem__T_54_addr_pipe_0 = _RAND_3[10:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  dmem__T_55_addr_pipe_0 = _RAND_4[10:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(dmem__T_19_en & dmem__T_19_mask) begin
      dmem[dmem__T_19_addr] <= dmem__T_19_data; // @[memory.scala 78:26:@1913.4]
    end
    if(dmem__T_26_en & dmem__T_26_mask) begin
      dmem[dmem__T_26_addr] <= dmem__T_26_data; // @[memory.scala 78:26:@1913.4]
    end
    if(dmem__T_33_en & dmem__T_33_mask) begin
      dmem[dmem__T_33_addr] <= dmem__T_33_data; // @[memory.scala 78:26:@1913.4]
    end
    if(dmem__T_40_en & dmem__T_40_mask) begin
      dmem[dmem__T_40_addr] <= dmem__T_40_data; // @[memory.scala 78:26:@1913.4]
    end
    if (_GEN_3) begin
      dmem__T_46_addr_pipe_0 <= _T_39;
    end
    if (_GEN_3) begin
      dmem__T_50_addr_pipe_0 <= _T_32;
    end
    if (_GEN_3) begin
      dmem__T_54_addr_pipe_0 <= _T_25;
    end
    if (_GEN_3) begin
      dmem__T_55_addr_pipe_0 <= io_dmem_addr;
    end
  end
endmodule
module DMem_Interface( // @[:@1967.2]
  input         clock, // @[:@1968.4]
  input         reset, // @[:@1969.4]
  input  [15:0] io_wbs_m2s_addr, // @[:@1970.4]
  input  [31:0] io_wbs_m2s_data, // @[:@1970.4]
  input         io_wbs_m2s_we, // @[:@1970.4]
  input  [3:0]  io_wbs_m2s_sel, // @[:@1970.4]
  input         io_wbs_m2s_stb, // @[:@1970.4]
  output        io_wbs_ack_o, // @[:@1970.4]
  output [31:0] io_wbs_data_o // @[:@1970.4]
);
  wire  dmem_clock; // @[dmem_interface.scala 35:20:@1972.4]
  wire [10:0] dmem_io_dmem_addr; // @[dmem_interface.scala 35:20:@1972.4]
  wire [31:0] dmem_io_dmem_wdata; // @[dmem_interface.scala 35:20:@1972.4]
  wire [31:0] dmem_io_dmem_rdata; // @[dmem_interface.scala 35:20:@1972.4]
  wire  dmem_io_wr_en; // @[dmem_interface.scala 35:20:@1972.4]
  wire [3:0] dmem_io_st_type; // @[dmem_interface.scala 35:20:@1972.4]
  wire [3:0] _T_35; // @[dmem_interface.scala 37:41:@1975.4]
  wire  dmem_addr_match; // @[dmem_interface.scala 37:79:@1976.4]
  wire  dmem_select; // @[dmem_interface.scala 39:41:@1977.4]
  wire  _T_44; // @[dmem_interface.scala 40:26:@1978.4]
  reg  ack2; // @[dmem_interface.scala 48:28:@1986.4]
  reg [31:0] _RAND_0;
  wire  dmem_res_en; // @[dmem_interface.scala 49:49:@1988.4]
  wire  _GEN_0; // @[dmem_interface.scala 51:21:@1989.4]
  reg  ack; // @[dmem_interface.scala 55:28:@1993.4]
  reg [31:0] _RAND_1;
  reg  rd_resp; // @[dmem_interface.scala 60:24:@1998.4]
  reg [31:0] _RAND_2;
  DMem dmem ( // @[dmem_interface.scala 35:20:@1972.4]
    .clock(dmem_clock),
    .io_dmem_addr(dmem_io_dmem_addr),
    .io_dmem_wdata(dmem_io_dmem_wdata),
    .io_dmem_rdata(dmem_io_dmem_rdata),
    .io_wr_en(dmem_io_wr_en),
    .io_st_type(dmem_io_st_type)
  );
  assign _T_35 = io_wbs_m2s_addr[15:12]; // @[dmem_interface.scala 37:41:@1975.4]
  assign dmem_addr_match = _T_35 == 4'h1; // @[dmem_interface.scala 37:79:@1976.4]
  assign dmem_select = io_wbs_m2s_stb & dmem_addr_match; // @[dmem_interface.scala 39:41:@1977.4]
  assign _T_44 = io_wbs_m2s_we == 1'h0; // @[dmem_interface.scala 40:26:@1978.4]
  assign dmem_res_en = ack2 ^ io_wbs_m2s_stb; // @[dmem_interface.scala 49:49:@1988.4]
  assign _GEN_0 = dmem_res_en ? io_wbs_m2s_stb : ack2; // @[dmem_interface.scala 51:21:@1989.4]
  assign io_wbs_ack_o = ack | ack2; // @[dmem_interface.scala 57:18:@1997.4]
  assign io_wbs_data_o = rd_resp ? dmem_io_dmem_rdata : 32'h0; // @[dmem_interface.scala 62:18:@2001.4]
  assign dmem_clock = clock; // @[:@1973.4]
  assign dmem_io_dmem_addr = io_wbs_m2s_addr[10:0]; // @[dmem_interface.scala 42:23:@1981.4]
  assign dmem_io_dmem_wdata = io_wbs_m2s_data; // @[dmem_interface.scala 43:23:@1982.4]
  assign dmem_io_wr_en = io_wbs_m2s_we & dmem_select; // @[dmem_interface.scala 44:23:@1984.4]
  assign dmem_io_st_type = io_wbs_m2s_sel; // @[dmem_interface.scala 45:23:@1985.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ack2 = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  ack = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  rd_resp = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      ack2 <= 1'h0;
    end else begin
      if (dmem_res_en) begin
        ack2 <= io_wbs_m2s_stb;
      end
    end
    if (reset) begin
      ack <= 1'h0;
    end else begin
      ack <= io_wbs_m2s_stb;
    end
    rd_resp <= _T_44 & dmem_select;
  end
endmodule
module IMem( // @[:@2003.2]
  input         clock, // @[:@2004.4]
  input  [31:0] io_imem_addr, // @[:@2006.4]
  output [31:0] io_imem_rdata, // @[:@2006.4]
  input  [31:0] io_imem_wdata, // @[:@2006.4]
  input         io_wr_en // @[:@2006.4]
);
  reg [31:0] imem [0:2047]; // @[memory.scala 32:25:@2008.4]
  reg [31:0] _RAND_0;
  wire [31:0] imem__T_24_data; // @[memory.scala 32:25:@2008.4]
  wire [10:0] imem__T_24_addr; // @[memory.scala 32:25:@2008.4]
  wire [31:0] imem__T_20_data; // @[memory.scala 32:25:@2008.4]
  wire [10:0] imem__T_20_addr; // @[memory.scala 32:25:@2008.4]
  wire  imem__T_20_mask; // @[memory.scala 32:25:@2008.4]
  wire  imem__T_20_en; // @[memory.scala 32:25:@2008.4]
  wire [31:0] _T_18; // @[memory.scala 43:23:@2010.6]
  wire [10:0] _T_19; // @[memory.scala 43:9:@2011.6]
  wire  _GEN_3; // @[memory.scala 42:19:@2009.4]
  reg [10:0] imem__T_24_addr_pipe_0;
  reg [31:0] _RAND_1;
  assign imem__T_24_addr = imem__T_24_addr_pipe_0;
  assign imem__T_24_data = imem[imem__T_24_addr]; // @[memory.scala 32:25:@2008.4]
  assign imem__T_20_data = io_imem_wdata;
  assign imem__T_20_addr = _T_18[10:0];
  assign imem__T_20_mask = 1'h1;
  assign imem__T_20_en = io_wr_en;
  assign _T_18 = io_imem_addr / 32'h4; // @[memory.scala 43:23:@2010.6]
  assign _T_19 = _T_18[10:0]; // @[memory.scala 43:9:@2011.6]
  assign _GEN_3 = 1'h1; // @[memory.scala 42:19:@2009.4]
  assign io_imem_rdata = imem__T_24_data; // @[memory.scala 61:17:@2018.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2048; initvar = initvar+1)
    imem[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  imem__T_24_addr_pipe_0 = _RAND_1[10:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(imem__T_20_en & imem__T_20_mask) begin
      imem[imem__T_20_addr] <= imem__T_20_data; // @[memory.scala 32:25:@2008.4]
    end
    if (_GEN_3) begin
      imem__T_24_addr_pipe_0 <= _T_19;
    end
  end
endmodule
module BMem( // @[:@2020.2]
  input         clock, // @[:@2021.4]
  input         reset, // @[:@2022.4]
  input  [31:0] io_bmem_addr, // @[:@2023.4]
  output [31:0] io_bmem_rdata // @[:@2023.4]
);
  wire [9:0] _T_9; // @[bmem.scala 26:26:@2025.4]
  wire [9:0] addr; // @[bmem.scala 26:33:@2026.4]
  reg [31:0] bmem_data; // @[bmem.scala 27:26:@2027.4]
  reg [31:0] _RAND_0;
  wire  _T_14; // @[Conditional.scala 37:30:@2028.4]
  wire  _T_17; // @[Conditional.scala 37:30:@2033.6]
  wire  _T_20; // @[Conditional.scala 37:30:@2038.8]
  wire  _T_23; // @[Conditional.scala 37:30:@2043.10]
  wire  _T_26; // @[Conditional.scala 37:30:@2048.12]
  wire  _T_29; // @[Conditional.scala 37:30:@2053.14]
  wire  _T_32; // @[Conditional.scala 37:30:@2058.16]
  wire  _T_35; // @[Conditional.scala 37:30:@2063.18]
  wire  _T_38; // @[Conditional.scala 37:30:@2068.20]
  wire  _T_41; // @[Conditional.scala 37:30:@2073.22]
  wire  _T_44; // @[Conditional.scala 37:30:@2078.24]
  wire  _T_47; // @[Conditional.scala 37:30:@2083.26]
  wire  _T_50; // @[Conditional.scala 37:30:@2088.28]
  wire  _T_53; // @[Conditional.scala 37:30:@2093.30]
  wire  _T_56; // @[Conditional.scala 37:30:@2098.32]
  wire  _T_59; // @[Conditional.scala 37:30:@2103.34]
  wire  _T_62; // @[Conditional.scala 37:30:@2108.36]
  wire  _T_65; // @[Conditional.scala 37:30:@2113.38]
  wire  _T_68; // @[Conditional.scala 37:30:@2118.40]
  wire  _T_71; // @[Conditional.scala 37:30:@2123.42]
  wire  _T_74; // @[Conditional.scala 37:30:@2128.44]
  wire  _T_77; // @[Conditional.scala 37:30:@2133.46]
  wire  _T_80; // @[Conditional.scala 37:30:@2138.48]
  wire  _T_83; // @[Conditional.scala 37:30:@2143.50]
  wire  _T_86; // @[Conditional.scala 37:30:@2148.52]
  wire  _T_89; // @[Conditional.scala 37:30:@2153.54]
  wire  _T_92; // @[Conditional.scala 37:30:@2158.56]
  wire  _T_95; // @[Conditional.scala 37:30:@2163.58]
  wire  _T_98; // @[Conditional.scala 37:30:@2168.60]
  wire  _T_101; // @[Conditional.scala 37:30:@2173.62]
  wire  _T_104; // @[Conditional.scala 37:30:@2178.64]
  wire  _T_107; // @[Conditional.scala 37:30:@2183.66]
  wire  _T_110; // @[Conditional.scala 37:30:@2188.68]
  wire  _T_113; // @[Conditional.scala 37:30:@2193.70]
  wire  _T_116; // @[Conditional.scala 37:30:@2198.72]
  wire  _T_119; // @[Conditional.scala 37:30:@2203.74]
  wire  _T_122; // @[Conditional.scala 37:30:@2208.76]
  wire  _T_125; // @[Conditional.scala 37:30:@2213.78]
  wire  _T_128; // @[Conditional.scala 37:30:@2218.80]
  wire  _T_131; // @[Conditional.scala 37:30:@2223.82]
  wire  _T_134; // @[Conditional.scala 37:30:@2228.84]
  wire  _T_137; // @[Conditional.scala 37:30:@2233.86]
  wire  _T_140; // @[Conditional.scala 37:30:@2238.88]
  wire  _T_143; // @[Conditional.scala 37:30:@2243.90]
  wire  _T_146; // @[Conditional.scala 37:30:@2248.92]
  wire  _T_149; // @[Conditional.scala 37:30:@2253.94]
  wire  _T_152; // @[Conditional.scala 37:30:@2258.96]
  wire  _T_155; // @[Conditional.scala 37:30:@2263.98]
  wire  _T_158; // @[Conditional.scala 37:30:@2268.100]
  wire  _T_161; // @[Conditional.scala 37:30:@2273.102]
  wire  _T_164; // @[Conditional.scala 37:30:@2278.104]
  wire  _T_167; // @[Conditional.scala 37:30:@2283.106]
  wire  _T_170; // @[Conditional.scala 37:30:@2288.108]
  wire  _T_173; // @[Conditional.scala 37:30:@2293.110]
  wire  _T_176; // @[Conditional.scala 37:30:@2298.112]
  wire  _T_179; // @[Conditional.scala 37:30:@2303.114]
  wire  _T_182; // @[Conditional.scala 37:30:@2308.116]
  wire  _T_185; // @[Conditional.scala 37:30:@2313.118]
  wire  _T_188; // @[Conditional.scala 37:30:@2318.120]
  wire  _T_191; // @[Conditional.scala 37:30:@2323.122]
  wire  _T_194; // @[Conditional.scala 37:30:@2328.124]
  wire  _T_197; // @[Conditional.scala 37:30:@2333.126]
  wire  _T_200; // @[Conditional.scala 37:30:@2338.128]
  wire  _T_203; // @[Conditional.scala 37:30:@2343.130]
  wire  _T_206; // @[Conditional.scala 37:30:@2348.132]
  wire  _T_209; // @[Conditional.scala 37:30:@2353.134]
  wire  _T_212; // @[Conditional.scala 37:30:@2358.136]
  wire  _T_215; // @[Conditional.scala 37:30:@2363.138]
  wire  _T_218; // @[Conditional.scala 37:30:@2368.140]
  wire  _T_221; // @[Conditional.scala 37:30:@2373.142]
  wire  _T_224; // @[Conditional.scala 37:30:@2378.144]
  wire  _T_227; // @[Conditional.scala 37:30:@2383.146]
  wire  _T_230; // @[Conditional.scala 37:30:@2388.148]
  wire  _T_233; // @[Conditional.scala 37:30:@2393.150]
  wire  _T_236; // @[Conditional.scala 37:30:@2398.152]
  wire  _T_239; // @[Conditional.scala 37:30:@2403.154]
  wire  _T_242; // @[Conditional.scala 37:30:@2408.156]
  wire  _T_245; // @[Conditional.scala 37:30:@2413.158]
  wire  _T_248; // @[Conditional.scala 37:30:@2418.160]
  wire  _T_251; // @[Conditional.scala 37:30:@2423.162]
  wire  _T_254; // @[Conditional.scala 37:30:@2428.164]
  wire  _T_257; // @[Conditional.scala 37:30:@2433.166]
  wire  _T_260; // @[Conditional.scala 37:30:@2438.168]
  wire  _T_263; // @[Conditional.scala 37:30:@2443.170]
  wire  _T_266; // @[Conditional.scala 37:30:@2448.172]
  wire  _T_269; // @[Conditional.scala 37:30:@2453.174]
  wire  _T_272; // @[Conditional.scala 37:30:@2458.176]
  wire  _T_275; // @[Conditional.scala 37:30:@2463.178]
  wire  _T_278; // @[Conditional.scala 37:30:@2468.180]
  wire  _T_281; // @[Conditional.scala 37:30:@2473.182]
  wire  _T_284; // @[Conditional.scala 37:30:@2478.184]
  wire  _T_287; // @[Conditional.scala 37:30:@2483.186]
  wire  _T_290; // @[Conditional.scala 37:30:@2488.188]
  wire  _T_293; // @[Conditional.scala 37:30:@2493.190]
  wire  _T_296; // @[Conditional.scala 37:30:@2498.192]
  wire  _T_299; // @[Conditional.scala 37:30:@2503.194]
  wire  _T_302; // @[Conditional.scala 37:30:@2508.196]
  wire  _T_305; // @[Conditional.scala 37:30:@2513.198]
  wire  _T_308; // @[Conditional.scala 37:30:@2518.200]
  wire  _T_311; // @[Conditional.scala 37:30:@2523.202]
  wire  _T_314; // @[Conditional.scala 37:30:@2528.204]
  wire  _T_317; // @[Conditional.scala 37:30:@2533.206]
  wire  _T_320; // @[Conditional.scala 37:30:@2538.208]
  wire  _T_323; // @[Conditional.scala 37:30:@2543.210]
  wire  _T_326; // @[Conditional.scala 37:30:@2548.212]
  wire  _T_329; // @[Conditional.scala 37:30:@2553.214]
  wire  _T_332; // @[Conditional.scala 37:30:@2558.216]
  wire  _T_335; // @[Conditional.scala 37:30:@2563.218]
  wire  _T_338; // @[Conditional.scala 37:30:@2568.220]
  wire  _T_341; // @[Conditional.scala 37:30:@2573.222]
  wire  _T_344; // @[Conditional.scala 37:30:@2578.224]
  wire  _T_347; // @[Conditional.scala 37:30:@2583.226]
  wire  _T_350; // @[Conditional.scala 37:30:@2588.228]
  wire  _T_353; // @[Conditional.scala 37:30:@2593.230]
  wire  _T_356; // @[Conditional.scala 37:30:@2598.232]
  wire  _T_359; // @[Conditional.scala 37:30:@2603.234]
  wire  _T_362; // @[Conditional.scala 37:30:@2608.236]
  wire  _T_365; // @[Conditional.scala 37:30:@2613.238]
  wire  _T_368; // @[Conditional.scala 37:30:@2618.240]
  wire  _T_371; // @[Conditional.scala 37:30:@2623.242]
  wire  _T_374; // @[Conditional.scala 37:30:@2628.244]
  wire  _T_377; // @[Conditional.scala 37:30:@2633.246]
  wire  _T_380; // @[Conditional.scala 37:30:@2638.248]
  wire  _T_383; // @[Conditional.scala 37:30:@2643.250]
  wire  _T_386; // @[Conditional.scala 37:30:@2648.252]
  wire  _T_389; // @[Conditional.scala 37:30:@2653.254]
  wire  _T_392; // @[Conditional.scala 37:30:@2658.256]
  wire  _T_395; // @[Conditional.scala 37:30:@2663.258]
  wire  _T_398; // @[Conditional.scala 37:30:@2668.260]
  wire  _T_401; // @[Conditional.scala 37:30:@2673.262]
  wire  _T_404; // @[Conditional.scala 37:30:@2678.264]
  wire  _T_407; // @[Conditional.scala 37:30:@2683.266]
  wire  _T_410; // @[Conditional.scala 37:30:@2688.268]
  wire  _T_413; // @[Conditional.scala 37:30:@2693.270]
  wire  _T_416; // @[Conditional.scala 37:30:@2698.272]
  wire  _T_419; // @[Conditional.scala 37:30:@2703.274]
  wire  _T_422; // @[Conditional.scala 37:30:@2708.276]
  wire  _T_425; // @[Conditional.scala 37:30:@2713.278]
  wire  _T_428; // @[Conditional.scala 37:30:@2718.280]
  wire  _T_431; // @[Conditional.scala 37:30:@2723.282]
  wire  _T_434; // @[Conditional.scala 37:30:@2728.284]
  wire  _T_437; // @[Conditional.scala 37:30:@2733.286]
  wire  _T_440; // @[Conditional.scala 37:30:@2738.288]
  wire  _T_443; // @[Conditional.scala 37:30:@2743.290]
  wire  _T_446; // @[Conditional.scala 37:30:@2748.292]
  wire  _T_449; // @[Conditional.scala 37:30:@2753.294]
  wire  _T_452; // @[Conditional.scala 37:30:@2758.296]
  wire  _T_455; // @[Conditional.scala 37:30:@2763.298]
  wire  _T_458; // @[Conditional.scala 37:30:@2768.300]
  wire  _T_461; // @[Conditional.scala 37:30:@2773.302]
  wire  _T_464; // @[Conditional.scala 37:30:@2778.304]
  wire  _T_467; // @[Conditional.scala 37:30:@2783.306]
  wire  _T_470; // @[Conditional.scala 37:30:@2788.308]
  wire  _T_473; // @[Conditional.scala 37:30:@2793.310]
  wire  _T_476; // @[Conditional.scala 37:30:@2798.312]
  wire  _T_479; // @[Conditional.scala 37:30:@2803.314]
  wire  _T_482; // @[Conditional.scala 37:30:@2808.316]
  wire  _T_485; // @[Conditional.scala 37:30:@2813.318]
  wire  _T_488; // @[Conditional.scala 37:30:@2818.320]
  wire  _T_491; // @[Conditional.scala 37:30:@2823.322]
  wire  _T_494; // @[Conditional.scala 37:30:@2828.324]
  wire  _T_497; // @[Conditional.scala 37:30:@2833.326]
  wire  _T_500; // @[Conditional.scala 37:30:@2838.328]
  wire  _T_503; // @[Conditional.scala 37:30:@2843.330]
  wire  _T_506; // @[Conditional.scala 37:30:@2848.332]
  wire  _T_509; // @[Conditional.scala 37:30:@2853.334]
  wire  _T_512; // @[Conditional.scala 37:30:@2858.336]
  wire  _T_515; // @[Conditional.scala 37:30:@2863.338]
  wire  _T_518; // @[Conditional.scala 37:30:@2868.340]
  wire  _T_521; // @[Conditional.scala 37:30:@2873.342]
  wire  _T_524; // @[Conditional.scala 37:30:@2878.344]
  wire  _T_527; // @[Conditional.scala 37:30:@2883.346]
  wire  _T_530; // @[Conditional.scala 37:30:@2888.348]
  wire  _T_533; // @[Conditional.scala 37:30:@2893.350]
  wire  _T_536; // @[Conditional.scala 37:30:@2898.352]
  wire  _T_539; // @[Conditional.scala 37:30:@2903.354]
  wire  _T_542; // @[Conditional.scala 37:30:@2908.356]
  wire  _T_545; // @[Conditional.scala 37:30:@2913.358]
  wire  _T_548; // @[Conditional.scala 37:30:@2918.360]
  wire  _T_551; // @[Conditional.scala 37:30:@2923.362]
  wire  _T_554; // @[Conditional.scala 37:30:@2928.364]
  wire  _T_557; // @[Conditional.scala 37:30:@2933.366]
  wire  _T_560; // @[Conditional.scala 37:30:@2938.368]
  wire  _T_563; // @[Conditional.scala 37:30:@2943.370]
  wire  _T_566; // @[Conditional.scala 37:30:@2948.372]
  wire  _T_569; // @[Conditional.scala 37:30:@2953.374]
  wire  _T_572; // @[Conditional.scala 37:30:@2958.376]
  wire  _T_575; // @[Conditional.scala 37:30:@2963.378]
  wire  _T_578; // @[Conditional.scala 37:30:@2968.380]
  wire  _T_581; // @[Conditional.scala 37:30:@2973.382]
  wire  _T_584; // @[Conditional.scala 37:30:@2978.384]
  wire  _T_587; // @[Conditional.scala 37:30:@2983.386]
  wire  _T_590; // @[Conditional.scala 37:30:@2988.388]
  wire  _T_593; // @[Conditional.scala 37:30:@2993.390]
  wire  _T_596; // @[Conditional.scala 37:30:@2998.392]
  wire  _T_599; // @[Conditional.scala 37:30:@3003.394]
  wire  _T_602; // @[Conditional.scala 37:30:@3008.396]
  wire  _T_605; // @[Conditional.scala 37:30:@3013.398]
  wire  _T_608; // @[Conditional.scala 37:30:@3018.400]
  wire  _T_611; // @[Conditional.scala 37:30:@3023.402]
  wire  _T_614; // @[Conditional.scala 37:30:@3028.404]
  wire  _T_617; // @[Conditional.scala 37:30:@3033.406]
  wire  _T_620; // @[Conditional.scala 37:30:@3038.408]
  wire  _T_623; // @[Conditional.scala 37:30:@3043.410]
  wire  _T_626; // @[Conditional.scala 37:30:@3048.412]
  wire  _T_629; // @[Conditional.scala 37:30:@3053.414]
  wire  _T_632; // @[Conditional.scala 37:30:@3058.416]
  wire  _T_635; // @[Conditional.scala 37:30:@3063.418]
  wire  _T_638; // @[Conditional.scala 37:30:@3068.420]
  wire  _T_641; // @[Conditional.scala 37:30:@3073.422]
  wire  _T_644; // @[Conditional.scala 37:30:@3078.424]
  wire  _T_647; // @[Conditional.scala 37:30:@3083.426]
  wire  _T_650; // @[Conditional.scala 37:30:@3088.428]
  wire  _T_653; // @[Conditional.scala 37:30:@3093.430]
  wire  _T_656; // @[Conditional.scala 37:30:@3098.432]
  wire  _T_659; // @[Conditional.scala 37:30:@3103.434]
  wire  _T_662; // @[Conditional.scala 37:30:@3108.436]
  wire  _T_665; // @[Conditional.scala 37:30:@3113.438]
  wire [31:0] _GEN_0; // @[Conditional.scala 39:67:@3114.438]
  wire [31:0] _GEN_1; // @[Conditional.scala 39:67:@3109.436]
  wire [31:0] _GEN_2; // @[Conditional.scala 39:67:@3104.434]
  wire [31:0] _GEN_3; // @[Conditional.scala 39:67:@3099.432]
  wire [31:0] _GEN_4; // @[Conditional.scala 39:67:@3094.430]
  wire [31:0] _GEN_5; // @[Conditional.scala 39:67:@3089.428]
  wire [31:0] _GEN_6; // @[Conditional.scala 39:67:@3084.426]
  wire [31:0] _GEN_7; // @[Conditional.scala 39:67:@3079.424]
  wire [31:0] _GEN_8; // @[Conditional.scala 39:67:@3074.422]
  wire [31:0] _GEN_9; // @[Conditional.scala 39:67:@3069.420]
  wire [31:0] _GEN_10; // @[Conditional.scala 39:67:@3064.418]
  wire [31:0] _GEN_11; // @[Conditional.scala 39:67:@3059.416]
  wire [31:0] _GEN_12; // @[Conditional.scala 39:67:@3054.414]
  wire [31:0] _GEN_13; // @[Conditional.scala 39:67:@3049.412]
  wire [31:0] _GEN_14; // @[Conditional.scala 39:67:@3044.410]
  wire [31:0] _GEN_15; // @[Conditional.scala 39:67:@3039.408]
  wire [31:0] _GEN_16; // @[Conditional.scala 39:67:@3034.406]
  wire [31:0] _GEN_17; // @[Conditional.scala 39:67:@3029.404]
  wire [31:0] _GEN_18; // @[Conditional.scala 39:67:@3024.402]
  wire [31:0] _GEN_19; // @[Conditional.scala 39:67:@3019.400]
  wire [31:0] _GEN_20; // @[Conditional.scala 39:67:@3014.398]
  wire [31:0] _GEN_21; // @[Conditional.scala 39:67:@3009.396]
  wire [31:0] _GEN_22; // @[Conditional.scala 39:67:@3004.394]
  wire [31:0] _GEN_23; // @[Conditional.scala 39:67:@2999.392]
  wire [31:0] _GEN_24; // @[Conditional.scala 39:67:@2994.390]
  wire [31:0] _GEN_25; // @[Conditional.scala 39:67:@2989.388]
  wire [31:0] _GEN_26; // @[Conditional.scala 39:67:@2984.386]
  wire [31:0] _GEN_27; // @[Conditional.scala 39:67:@2979.384]
  wire [31:0] _GEN_28; // @[Conditional.scala 39:67:@2974.382]
  wire [31:0] _GEN_29; // @[Conditional.scala 39:67:@2969.380]
  wire [31:0] _GEN_30; // @[Conditional.scala 39:67:@2964.378]
  wire [31:0] _GEN_31; // @[Conditional.scala 39:67:@2959.376]
  wire [31:0] _GEN_32; // @[Conditional.scala 39:67:@2954.374]
  wire [31:0] _GEN_33; // @[Conditional.scala 39:67:@2949.372]
  wire [31:0] _GEN_34; // @[Conditional.scala 39:67:@2944.370]
  wire [31:0] _GEN_35; // @[Conditional.scala 39:67:@2939.368]
  wire [31:0] _GEN_36; // @[Conditional.scala 39:67:@2934.366]
  wire [31:0] _GEN_37; // @[Conditional.scala 39:67:@2929.364]
  wire [31:0] _GEN_38; // @[Conditional.scala 39:67:@2924.362]
  wire [31:0] _GEN_39; // @[Conditional.scala 39:67:@2919.360]
  wire [31:0] _GEN_40; // @[Conditional.scala 39:67:@2914.358]
  wire [31:0] _GEN_41; // @[Conditional.scala 39:67:@2909.356]
  wire [31:0] _GEN_42; // @[Conditional.scala 39:67:@2904.354]
  wire [31:0] _GEN_43; // @[Conditional.scala 39:67:@2899.352]
  wire [31:0] _GEN_44; // @[Conditional.scala 39:67:@2894.350]
  wire [31:0] _GEN_45; // @[Conditional.scala 39:67:@2889.348]
  wire [31:0] _GEN_46; // @[Conditional.scala 39:67:@2884.346]
  wire [31:0] _GEN_47; // @[Conditional.scala 39:67:@2879.344]
  wire [31:0] _GEN_48; // @[Conditional.scala 39:67:@2874.342]
  wire [31:0] _GEN_49; // @[Conditional.scala 39:67:@2869.340]
  wire [31:0] _GEN_50; // @[Conditional.scala 39:67:@2864.338]
  wire [31:0] _GEN_51; // @[Conditional.scala 39:67:@2859.336]
  wire [31:0] _GEN_52; // @[Conditional.scala 39:67:@2854.334]
  wire [31:0] _GEN_53; // @[Conditional.scala 39:67:@2849.332]
  wire [31:0] _GEN_54; // @[Conditional.scala 39:67:@2844.330]
  wire [31:0] _GEN_55; // @[Conditional.scala 39:67:@2839.328]
  wire [31:0] _GEN_56; // @[Conditional.scala 39:67:@2834.326]
  wire [31:0] _GEN_57; // @[Conditional.scala 39:67:@2829.324]
  wire [31:0] _GEN_58; // @[Conditional.scala 39:67:@2824.322]
  wire [31:0] _GEN_59; // @[Conditional.scala 39:67:@2819.320]
  wire [31:0] _GEN_60; // @[Conditional.scala 39:67:@2814.318]
  wire [31:0] _GEN_61; // @[Conditional.scala 39:67:@2809.316]
  wire [31:0] _GEN_62; // @[Conditional.scala 39:67:@2804.314]
  wire [31:0] _GEN_63; // @[Conditional.scala 39:67:@2799.312]
  wire [31:0] _GEN_64; // @[Conditional.scala 39:67:@2794.310]
  wire [31:0] _GEN_65; // @[Conditional.scala 39:67:@2789.308]
  wire [31:0] _GEN_66; // @[Conditional.scala 39:67:@2784.306]
  wire [31:0] _GEN_67; // @[Conditional.scala 39:67:@2779.304]
  wire [31:0] _GEN_68; // @[Conditional.scala 39:67:@2774.302]
  wire [31:0] _GEN_69; // @[Conditional.scala 39:67:@2769.300]
  wire [31:0] _GEN_70; // @[Conditional.scala 39:67:@2764.298]
  wire [31:0] _GEN_71; // @[Conditional.scala 39:67:@2759.296]
  wire [31:0] _GEN_72; // @[Conditional.scala 39:67:@2754.294]
  wire [31:0] _GEN_73; // @[Conditional.scala 39:67:@2749.292]
  wire [31:0] _GEN_74; // @[Conditional.scala 39:67:@2744.290]
  wire [31:0] _GEN_75; // @[Conditional.scala 39:67:@2739.288]
  wire [31:0] _GEN_76; // @[Conditional.scala 39:67:@2734.286]
  wire [31:0] _GEN_77; // @[Conditional.scala 39:67:@2729.284]
  wire [31:0] _GEN_78; // @[Conditional.scala 39:67:@2724.282]
  wire [31:0] _GEN_79; // @[Conditional.scala 39:67:@2719.280]
  wire [31:0] _GEN_80; // @[Conditional.scala 39:67:@2714.278]
  wire [31:0] _GEN_81; // @[Conditional.scala 39:67:@2709.276]
  wire [31:0] _GEN_82; // @[Conditional.scala 39:67:@2704.274]
  wire [31:0] _GEN_83; // @[Conditional.scala 39:67:@2699.272]
  wire [31:0] _GEN_84; // @[Conditional.scala 39:67:@2694.270]
  wire [31:0] _GEN_85; // @[Conditional.scala 39:67:@2689.268]
  wire [31:0] _GEN_86; // @[Conditional.scala 39:67:@2684.266]
  wire [31:0] _GEN_87; // @[Conditional.scala 39:67:@2679.264]
  wire [31:0] _GEN_88; // @[Conditional.scala 39:67:@2674.262]
  wire [31:0] _GEN_89; // @[Conditional.scala 39:67:@2669.260]
  wire [31:0] _GEN_90; // @[Conditional.scala 39:67:@2664.258]
  wire [31:0] _GEN_91; // @[Conditional.scala 39:67:@2659.256]
  wire [31:0] _GEN_92; // @[Conditional.scala 39:67:@2654.254]
  wire [31:0] _GEN_93; // @[Conditional.scala 39:67:@2649.252]
  wire [31:0] _GEN_94; // @[Conditional.scala 39:67:@2644.250]
  wire [31:0] _GEN_95; // @[Conditional.scala 39:67:@2639.248]
  wire [31:0] _GEN_96; // @[Conditional.scala 39:67:@2634.246]
  wire [31:0] _GEN_97; // @[Conditional.scala 39:67:@2629.244]
  wire [31:0] _GEN_98; // @[Conditional.scala 39:67:@2624.242]
  wire [31:0] _GEN_99; // @[Conditional.scala 39:67:@2619.240]
  wire [31:0] _GEN_100; // @[Conditional.scala 39:67:@2614.238]
  wire [31:0] _GEN_101; // @[Conditional.scala 39:67:@2609.236]
  wire [31:0] _GEN_102; // @[Conditional.scala 39:67:@2604.234]
  wire [31:0] _GEN_103; // @[Conditional.scala 39:67:@2599.232]
  wire [31:0] _GEN_104; // @[Conditional.scala 39:67:@2594.230]
  wire [31:0] _GEN_105; // @[Conditional.scala 39:67:@2589.228]
  wire [31:0] _GEN_106; // @[Conditional.scala 39:67:@2584.226]
  wire [31:0] _GEN_107; // @[Conditional.scala 39:67:@2579.224]
  wire [31:0] _GEN_108; // @[Conditional.scala 39:67:@2574.222]
  wire [31:0] _GEN_109; // @[Conditional.scala 39:67:@2569.220]
  wire [31:0] _GEN_110; // @[Conditional.scala 39:67:@2564.218]
  wire [31:0] _GEN_111; // @[Conditional.scala 39:67:@2559.216]
  wire [31:0] _GEN_112; // @[Conditional.scala 39:67:@2554.214]
  wire [31:0] _GEN_113; // @[Conditional.scala 39:67:@2549.212]
  wire [31:0] _GEN_114; // @[Conditional.scala 39:67:@2544.210]
  wire [31:0] _GEN_115; // @[Conditional.scala 39:67:@2539.208]
  wire [31:0] _GEN_116; // @[Conditional.scala 39:67:@2534.206]
  wire [31:0] _GEN_117; // @[Conditional.scala 39:67:@2529.204]
  wire [31:0] _GEN_118; // @[Conditional.scala 39:67:@2524.202]
  wire [31:0] _GEN_119; // @[Conditional.scala 39:67:@2519.200]
  wire [31:0] _GEN_120; // @[Conditional.scala 39:67:@2514.198]
  wire [31:0] _GEN_121; // @[Conditional.scala 39:67:@2509.196]
  wire [31:0] _GEN_122; // @[Conditional.scala 39:67:@2504.194]
  wire [31:0] _GEN_123; // @[Conditional.scala 39:67:@2499.192]
  wire [31:0] _GEN_124; // @[Conditional.scala 39:67:@2494.190]
  wire [31:0] _GEN_125; // @[Conditional.scala 39:67:@2489.188]
  wire [31:0] _GEN_126; // @[Conditional.scala 39:67:@2484.186]
  wire [31:0] _GEN_127; // @[Conditional.scala 39:67:@2479.184]
  wire [31:0] _GEN_128; // @[Conditional.scala 39:67:@2474.182]
  wire [31:0] _GEN_129; // @[Conditional.scala 39:67:@2469.180]
  wire [31:0] _GEN_130; // @[Conditional.scala 39:67:@2464.178]
  wire [31:0] _GEN_131; // @[Conditional.scala 39:67:@2459.176]
  wire [31:0] _GEN_132; // @[Conditional.scala 39:67:@2454.174]
  wire [31:0] _GEN_133; // @[Conditional.scala 39:67:@2449.172]
  wire [31:0] _GEN_134; // @[Conditional.scala 39:67:@2444.170]
  wire [31:0] _GEN_135; // @[Conditional.scala 39:67:@2439.168]
  wire [31:0] _GEN_136; // @[Conditional.scala 39:67:@2434.166]
  wire [31:0] _GEN_137; // @[Conditional.scala 39:67:@2429.164]
  wire [31:0] _GEN_138; // @[Conditional.scala 39:67:@2424.162]
  wire [31:0] _GEN_139; // @[Conditional.scala 39:67:@2419.160]
  wire [31:0] _GEN_140; // @[Conditional.scala 39:67:@2414.158]
  wire [31:0] _GEN_141; // @[Conditional.scala 39:67:@2409.156]
  wire [31:0] _GEN_142; // @[Conditional.scala 39:67:@2404.154]
  wire [31:0] _GEN_143; // @[Conditional.scala 39:67:@2399.152]
  wire [31:0] _GEN_144; // @[Conditional.scala 39:67:@2394.150]
  wire [31:0] _GEN_145; // @[Conditional.scala 39:67:@2389.148]
  wire [31:0] _GEN_146; // @[Conditional.scala 39:67:@2384.146]
  wire [31:0] _GEN_147; // @[Conditional.scala 39:67:@2379.144]
  wire [31:0] _GEN_148; // @[Conditional.scala 39:67:@2374.142]
  wire [31:0] _GEN_149; // @[Conditional.scala 39:67:@2369.140]
  wire [31:0] _GEN_150; // @[Conditional.scala 39:67:@2364.138]
  wire [31:0] _GEN_151; // @[Conditional.scala 39:67:@2359.136]
  wire [31:0] _GEN_152; // @[Conditional.scala 39:67:@2354.134]
  wire [31:0] _GEN_153; // @[Conditional.scala 39:67:@2349.132]
  wire [31:0] _GEN_154; // @[Conditional.scala 39:67:@2344.130]
  wire [31:0] _GEN_155; // @[Conditional.scala 39:67:@2339.128]
  wire [31:0] _GEN_156; // @[Conditional.scala 39:67:@2334.126]
  wire [31:0] _GEN_157; // @[Conditional.scala 39:67:@2329.124]
  wire [31:0] _GEN_158; // @[Conditional.scala 39:67:@2324.122]
  wire [31:0] _GEN_159; // @[Conditional.scala 39:67:@2319.120]
  wire [31:0] _GEN_160; // @[Conditional.scala 39:67:@2314.118]
  wire [31:0] _GEN_161; // @[Conditional.scala 39:67:@2309.116]
  wire [31:0] _GEN_162; // @[Conditional.scala 39:67:@2304.114]
  wire [31:0] _GEN_163; // @[Conditional.scala 39:67:@2299.112]
  wire [31:0] _GEN_164; // @[Conditional.scala 39:67:@2294.110]
  wire [31:0] _GEN_165; // @[Conditional.scala 39:67:@2289.108]
  wire [31:0] _GEN_166; // @[Conditional.scala 39:67:@2284.106]
  wire [31:0] _GEN_167; // @[Conditional.scala 39:67:@2279.104]
  wire [31:0] _GEN_168; // @[Conditional.scala 39:67:@2274.102]
  wire [31:0] _GEN_169; // @[Conditional.scala 39:67:@2269.100]
  wire [31:0] _GEN_170; // @[Conditional.scala 39:67:@2264.98]
  wire [31:0] _GEN_171; // @[Conditional.scala 39:67:@2259.96]
  wire [31:0] _GEN_172; // @[Conditional.scala 39:67:@2254.94]
  wire [31:0] _GEN_173; // @[Conditional.scala 39:67:@2249.92]
  wire [31:0] _GEN_174; // @[Conditional.scala 39:67:@2244.90]
  wire [31:0] _GEN_175; // @[Conditional.scala 39:67:@2239.88]
  wire [31:0] _GEN_176; // @[Conditional.scala 39:67:@2234.86]
  wire [31:0] _GEN_177; // @[Conditional.scala 39:67:@2229.84]
  wire [31:0] _GEN_178; // @[Conditional.scala 39:67:@2224.82]
  wire [31:0] _GEN_179; // @[Conditional.scala 39:67:@2219.80]
  wire [31:0] _GEN_180; // @[Conditional.scala 39:67:@2214.78]
  wire [31:0] _GEN_181; // @[Conditional.scala 39:67:@2209.76]
  wire [31:0] _GEN_182; // @[Conditional.scala 39:67:@2204.74]
  wire [31:0] _GEN_183; // @[Conditional.scala 39:67:@2199.72]
  wire [31:0] _GEN_184; // @[Conditional.scala 39:67:@2194.70]
  wire [31:0] _GEN_185; // @[Conditional.scala 39:67:@2189.68]
  wire [31:0] _GEN_186; // @[Conditional.scala 39:67:@2184.66]
  wire [31:0] _GEN_187; // @[Conditional.scala 39:67:@2179.64]
  wire [31:0] _GEN_188; // @[Conditional.scala 39:67:@2174.62]
  wire [31:0] _GEN_189; // @[Conditional.scala 39:67:@2169.60]
  wire [31:0] _GEN_190; // @[Conditional.scala 39:67:@2164.58]
  wire [31:0] _GEN_191; // @[Conditional.scala 39:67:@2159.56]
  wire [31:0] _GEN_192; // @[Conditional.scala 39:67:@2154.54]
  wire [31:0] _GEN_193; // @[Conditional.scala 39:67:@2149.52]
  wire [31:0] _GEN_194; // @[Conditional.scala 39:67:@2144.50]
  wire [31:0] _GEN_195; // @[Conditional.scala 39:67:@2139.48]
  wire [31:0] _GEN_196; // @[Conditional.scala 39:67:@2134.46]
  wire [31:0] _GEN_197; // @[Conditional.scala 39:67:@2129.44]
  wire [31:0] _GEN_198; // @[Conditional.scala 39:67:@2124.42]
  wire [31:0] _GEN_199; // @[Conditional.scala 39:67:@2119.40]
  wire [31:0] _GEN_200; // @[Conditional.scala 39:67:@2114.38]
  wire [31:0] _GEN_201; // @[Conditional.scala 39:67:@2109.36]
  wire [31:0] _GEN_202; // @[Conditional.scala 39:67:@2104.34]
  wire [31:0] _GEN_203; // @[Conditional.scala 39:67:@2099.32]
  wire [31:0] _GEN_204; // @[Conditional.scala 39:67:@2094.30]
  wire [31:0] _GEN_205; // @[Conditional.scala 39:67:@2089.28]
  wire [31:0] _GEN_206; // @[Conditional.scala 39:67:@2084.26]
  wire [31:0] _GEN_207; // @[Conditional.scala 39:67:@2079.24]
  wire [31:0] _GEN_208; // @[Conditional.scala 39:67:@2074.22]
  wire [31:0] _GEN_209; // @[Conditional.scala 39:67:@2069.20]
  wire [31:0] _GEN_210; // @[Conditional.scala 39:67:@2064.18]
  wire [31:0] _GEN_211; // @[Conditional.scala 39:67:@2059.16]
  wire [31:0] _GEN_212; // @[Conditional.scala 39:67:@2054.14]
  wire [31:0] _GEN_213; // @[Conditional.scala 39:67:@2049.12]
  wire [31:0] _GEN_214; // @[Conditional.scala 39:67:@2044.10]
  wire [31:0] _GEN_215; // @[Conditional.scala 39:67:@2039.8]
  wire [31:0] _GEN_216; // @[Conditional.scala 39:67:@2034.6]
  wire [31:0] _GEN_217; // @[Conditional.scala 40:58:@2029.4]
  assign _T_9 = io_bmem_addr[9:0]; // @[bmem.scala 26:26:@2025.4]
  assign addr = _T_9 / 10'h4; // @[bmem.scala 26:33:@2026.4]
  assign _T_14 = 10'h0 == addr; // @[Conditional.scala 37:30:@2028.4]
  assign _T_17 = 10'h1 == addr; // @[Conditional.scala 37:30:@2033.6]
  assign _T_20 = 10'h2 == addr; // @[Conditional.scala 37:30:@2038.8]
  assign _T_23 = 10'h3 == addr; // @[Conditional.scala 37:30:@2043.10]
  assign _T_26 = 10'h4 == addr; // @[Conditional.scala 37:30:@2048.12]
  assign _T_29 = 10'h5 == addr; // @[Conditional.scala 37:30:@2053.14]
  assign _T_32 = 10'h6 == addr; // @[Conditional.scala 37:30:@2058.16]
  assign _T_35 = 10'h7 == addr; // @[Conditional.scala 37:30:@2063.18]
  assign _T_38 = 10'h8 == addr; // @[Conditional.scala 37:30:@2068.20]
  assign _T_41 = 10'h9 == addr; // @[Conditional.scala 37:30:@2073.22]
  assign _T_44 = 10'ha == addr; // @[Conditional.scala 37:30:@2078.24]
  assign _T_47 = 10'hb == addr; // @[Conditional.scala 37:30:@2083.26]
  assign _T_50 = 10'hc == addr; // @[Conditional.scala 37:30:@2088.28]
  assign _T_53 = 10'hd == addr; // @[Conditional.scala 37:30:@2093.30]
  assign _T_56 = 10'he == addr; // @[Conditional.scala 37:30:@2098.32]
  assign _T_59 = 10'hf == addr; // @[Conditional.scala 37:30:@2103.34]
  assign _T_62 = 10'h10 == addr; // @[Conditional.scala 37:30:@2108.36]
  assign _T_65 = 10'h11 == addr; // @[Conditional.scala 37:30:@2113.38]
  assign _T_68 = 10'h12 == addr; // @[Conditional.scala 37:30:@2118.40]
  assign _T_71 = 10'h13 == addr; // @[Conditional.scala 37:30:@2123.42]
  assign _T_74 = 10'h14 == addr; // @[Conditional.scala 37:30:@2128.44]
  assign _T_77 = 10'h15 == addr; // @[Conditional.scala 37:30:@2133.46]
  assign _T_80 = 10'h16 == addr; // @[Conditional.scala 37:30:@2138.48]
  assign _T_83 = 10'h17 == addr; // @[Conditional.scala 37:30:@2143.50]
  assign _T_86 = 10'h18 == addr; // @[Conditional.scala 37:30:@2148.52]
  assign _T_89 = 10'h19 == addr; // @[Conditional.scala 37:30:@2153.54]
  assign _T_92 = 10'h1a == addr; // @[Conditional.scala 37:30:@2158.56]
  assign _T_95 = 10'h1b == addr; // @[Conditional.scala 37:30:@2163.58]
  assign _T_98 = 10'h1c == addr; // @[Conditional.scala 37:30:@2168.60]
  assign _T_101 = 10'h1d == addr; // @[Conditional.scala 37:30:@2173.62]
  assign _T_104 = 10'h1e == addr; // @[Conditional.scala 37:30:@2178.64]
  assign _T_107 = 10'h1f == addr; // @[Conditional.scala 37:30:@2183.66]
  assign _T_110 = 10'h20 == addr; // @[Conditional.scala 37:30:@2188.68]
  assign _T_113 = 10'h21 == addr; // @[Conditional.scala 37:30:@2193.70]
  assign _T_116 = 10'h22 == addr; // @[Conditional.scala 37:30:@2198.72]
  assign _T_119 = 10'h23 == addr; // @[Conditional.scala 37:30:@2203.74]
  assign _T_122 = 10'h24 == addr; // @[Conditional.scala 37:30:@2208.76]
  assign _T_125 = 10'h25 == addr; // @[Conditional.scala 37:30:@2213.78]
  assign _T_128 = 10'h26 == addr; // @[Conditional.scala 37:30:@2218.80]
  assign _T_131 = 10'h27 == addr; // @[Conditional.scala 37:30:@2223.82]
  assign _T_134 = 10'h28 == addr; // @[Conditional.scala 37:30:@2228.84]
  assign _T_137 = 10'h29 == addr; // @[Conditional.scala 37:30:@2233.86]
  assign _T_140 = 10'h2a == addr; // @[Conditional.scala 37:30:@2238.88]
  assign _T_143 = 10'h2b == addr; // @[Conditional.scala 37:30:@2243.90]
  assign _T_146 = 10'h2c == addr; // @[Conditional.scala 37:30:@2248.92]
  assign _T_149 = 10'h2d == addr; // @[Conditional.scala 37:30:@2253.94]
  assign _T_152 = 10'h2e == addr; // @[Conditional.scala 37:30:@2258.96]
  assign _T_155 = 10'h2f == addr; // @[Conditional.scala 37:30:@2263.98]
  assign _T_158 = 10'h30 == addr; // @[Conditional.scala 37:30:@2268.100]
  assign _T_161 = 10'h31 == addr; // @[Conditional.scala 37:30:@2273.102]
  assign _T_164 = 10'h32 == addr; // @[Conditional.scala 37:30:@2278.104]
  assign _T_167 = 10'h33 == addr; // @[Conditional.scala 37:30:@2283.106]
  assign _T_170 = 10'h34 == addr; // @[Conditional.scala 37:30:@2288.108]
  assign _T_173 = 10'h35 == addr; // @[Conditional.scala 37:30:@2293.110]
  assign _T_176 = 10'h36 == addr; // @[Conditional.scala 37:30:@2298.112]
  assign _T_179 = 10'h37 == addr; // @[Conditional.scala 37:30:@2303.114]
  assign _T_182 = 10'h38 == addr; // @[Conditional.scala 37:30:@2308.116]
  assign _T_185 = 10'h39 == addr; // @[Conditional.scala 37:30:@2313.118]
  assign _T_188 = 10'h3a == addr; // @[Conditional.scala 37:30:@2318.120]
  assign _T_191 = 10'h3b == addr; // @[Conditional.scala 37:30:@2323.122]
  assign _T_194 = 10'h3c == addr; // @[Conditional.scala 37:30:@2328.124]
  assign _T_197 = 10'h3d == addr; // @[Conditional.scala 37:30:@2333.126]
  assign _T_200 = 10'h3e == addr; // @[Conditional.scala 37:30:@2338.128]
  assign _T_203 = 10'h3f == addr; // @[Conditional.scala 37:30:@2343.130]
  assign _T_206 = 10'h40 == addr; // @[Conditional.scala 37:30:@2348.132]
  assign _T_209 = 10'h41 == addr; // @[Conditional.scala 37:30:@2353.134]
  assign _T_212 = 10'h42 == addr; // @[Conditional.scala 37:30:@2358.136]
  assign _T_215 = 10'h43 == addr; // @[Conditional.scala 37:30:@2363.138]
  assign _T_218 = 10'h44 == addr; // @[Conditional.scala 37:30:@2368.140]
  assign _T_221 = 10'h45 == addr; // @[Conditional.scala 37:30:@2373.142]
  assign _T_224 = 10'h46 == addr; // @[Conditional.scala 37:30:@2378.144]
  assign _T_227 = 10'h47 == addr; // @[Conditional.scala 37:30:@2383.146]
  assign _T_230 = 10'h48 == addr; // @[Conditional.scala 37:30:@2388.148]
  assign _T_233 = 10'h49 == addr; // @[Conditional.scala 37:30:@2393.150]
  assign _T_236 = 10'h4a == addr; // @[Conditional.scala 37:30:@2398.152]
  assign _T_239 = 10'h4b == addr; // @[Conditional.scala 37:30:@2403.154]
  assign _T_242 = 10'h4c == addr; // @[Conditional.scala 37:30:@2408.156]
  assign _T_245 = 10'h4d == addr; // @[Conditional.scala 37:30:@2413.158]
  assign _T_248 = 10'h4e == addr; // @[Conditional.scala 37:30:@2418.160]
  assign _T_251 = 10'h4f == addr; // @[Conditional.scala 37:30:@2423.162]
  assign _T_254 = 10'h50 == addr; // @[Conditional.scala 37:30:@2428.164]
  assign _T_257 = 10'h51 == addr; // @[Conditional.scala 37:30:@2433.166]
  assign _T_260 = 10'h52 == addr; // @[Conditional.scala 37:30:@2438.168]
  assign _T_263 = 10'h53 == addr; // @[Conditional.scala 37:30:@2443.170]
  assign _T_266 = 10'h54 == addr; // @[Conditional.scala 37:30:@2448.172]
  assign _T_269 = 10'h55 == addr; // @[Conditional.scala 37:30:@2453.174]
  assign _T_272 = 10'h56 == addr; // @[Conditional.scala 37:30:@2458.176]
  assign _T_275 = 10'h57 == addr; // @[Conditional.scala 37:30:@2463.178]
  assign _T_278 = 10'h58 == addr; // @[Conditional.scala 37:30:@2468.180]
  assign _T_281 = 10'h59 == addr; // @[Conditional.scala 37:30:@2473.182]
  assign _T_284 = 10'h5a == addr; // @[Conditional.scala 37:30:@2478.184]
  assign _T_287 = 10'h5b == addr; // @[Conditional.scala 37:30:@2483.186]
  assign _T_290 = 10'h5c == addr; // @[Conditional.scala 37:30:@2488.188]
  assign _T_293 = 10'h5d == addr; // @[Conditional.scala 37:30:@2493.190]
  assign _T_296 = 10'h5e == addr; // @[Conditional.scala 37:30:@2498.192]
  assign _T_299 = 10'h5f == addr; // @[Conditional.scala 37:30:@2503.194]
  assign _T_302 = 10'h60 == addr; // @[Conditional.scala 37:30:@2508.196]
  assign _T_305 = 10'h61 == addr; // @[Conditional.scala 37:30:@2513.198]
  assign _T_308 = 10'h62 == addr; // @[Conditional.scala 37:30:@2518.200]
  assign _T_311 = 10'h63 == addr; // @[Conditional.scala 37:30:@2523.202]
  assign _T_314 = 10'h64 == addr; // @[Conditional.scala 37:30:@2528.204]
  assign _T_317 = 10'h65 == addr; // @[Conditional.scala 37:30:@2533.206]
  assign _T_320 = 10'h66 == addr; // @[Conditional.scala 37:30:@2538.208]
  assign _T_323 = 10'h67 == addr; // @[Conditional.scala 37:30:@2543.210]
  assign _T_326 = 10'h68 == addr; // @[Conditional.scala 37:30:@2548.212]
  assign _T_329 = 10'h69 == addr; // @[Conditional.scala 37:30:@2553.214]
  assign _T_332 = 10'h6a == addr; // @[Conditional.scala 37:30:@2558.216]
  assign _T_335 = 10'h6b == addr; // @[Conditional.scala 37:30:@2563.218]
  assign _T_338 = 10'h6c == addr; // @[Conditional.scala 37:30:@2568.220]
  assign _T_341 = 10'h6d == addr; // @[Conditional.scala 37:30:@2573.222]
  assign _T_344 = 10'h6e == addr; // @[Conditional.scala 37:30:@2578.224]
  assign _T_347 = 10'h6f == addr; // @[Conditional.scala 37:30:@2583.226]
  assign _T_350 = 10'h70 == addr; // @[Conditional.scala 37:30:@2588.228]
  assign _T_353 = 10'h71 == addr; // @[Conditional.scala 37:30:@2593.230]
  assign _T_356 = 10'h72 == addr; // @[Conditional.scala 37:30:@2598.232]
  assign _T_359 = 10'h73 == addr; // @[Conditional.scala 37:30:@2603.234]
  assign _T_362 = 10'h74 == addr; // @[Conditional.scala 37:30:@2608.236]
  assign _T_365 = 10'h75 == addr; // @[Conditional.scala 37:30:@2613.238]
  assign _T_368 = 10'h76 == addr; // @[Conditional.scala 37:30:@2618.240]
  assign _T_371 = 10'h77 == addr; // @[Conditional.scala 37:30:@2623.242]
  assign _T_374 = 10'h78 == addr; // @[Conditional.scala 37:30:@2628.244]
  assign _T_377 = 10'h79 == addr; // @[Conditional.scala 37:30:@2633.246]
  assign _T_380 = 10'h7a == addr; // @[Conditional.scala 37:30:@2638.248]
  assign _T_383 = 10'h7b == addr; // @[Conditional.scala 37:30:@2643.250]
  assign _T_386 = 10'h7c == addr; // @[Conditional.scala 37:30:@2648.252]
  assign _T_389 = 10'h7d == addr; // @[Conditional.scala 37:30:@2653.254]
  assign _T_392 = 10'h7e == addr; // @[Conditional.scala 37:30:@2658.256]
  assign _T_395 = 10'h7f == addr; // @[Conditional.scala 37:30:@2663.258]
  assign _T_398 = 10'h80 == addr; // @[Conditional.scala 37:30:@2668.260]
  assign _T_401 = 10'h81 == addr; // @[Conditional.scala 37:30:@2673.262]
  assign _T_404 = 10'h82 == addr; // @[Conditional.scala 37:30:@2678.264]
  assign _T_407 = 10'h83 == addr; // @[Conditional.scala 37:30:@2683.266]
  assign _T_410 = 10'h84 == addr; // @[Conditional.scala 37:30:@2688.268]
  assign _T_413 = 10'h85 == addr; // @[Conditional.scala 37:30:@2693.270]
  assign _T_416 = 10'h86 == addr; // @[Conditional.scala 37:30:@2698.272]
  assign _T_419 = 10'h87 == addr; // @[Conditional.scala 37:30:@2703.274]
  assign _T_422 = 10'h88 == addr; // @[Conditional.scala 37:30:@2708.276]
  assign _T_425 = 10'h89 == addr; // @[Conditional.scala 37:30:@2713.278]
  assign _T_428 = 10'h8a == addr; // @[Conditional.scala 37:30:@2718.280]
  assign _T_431 = 10'h8b == addr; // @[Conditional.scala 37:30:@2723.282]
  assign _T_434 = 10'h8c == addr; // @[Conditional.scala 37:30:@2728.284]
  assign _T_437 = 10'h8d == addr; // @[Conditional.scala 37:30:@2733.286]
  assign _T_440 = 10'h8e == addr; // @[Conditional.scala 37:30:@2738.288]
  assign _T_443 = 10'h8f == addr; // @[Conditional.scala 37:30:@2743.290]
  assign _T_446 = 10'h90 == addr; // @[Conditional.scala 37:30:@2748.292]
  assign _T_449 = 10'h91 == addr; // @[Conditional.scala 37:30:@2753.294]
  assign _T_452 = 10'h92 == addr; // @[Conditional.scala 37:30:@2758.296]
  assign _T_455 = 10'h93 == addr; // @[Conditional.scala 37:30:@2763.298]
  assign _T_458 = 10'h94 == addr; // @[Conditional.scala 37:30:@2768.300]
  assign _T_461 = 10'h95 == addr; // @[Conditional.scala 37:30:@2773.302]
  assign _T_464 = 10'h96 == addr; // @[Conditional.scala 37:30:@2778.304]
  assign _T_467 = 10'h97 == addr; // @[Conditional.scala 37:30:@2783.306]
  assign _T_470 = 10'h98 == addr; // @[Conditional.scala 37:30:@2788.308]
  assign _T_473 = 10'h99 == addr; // @[Conditional.scala 37:30:@2793.310]
  assign _T_476 = 10'h9a == addr; // @[Conditional.scala 37:30:@2798.312]
  assign _T_479 = 10'h9b == addr; // @[Conditional.scala 37:30:@2803.314]
  assign _T_482 = 10'h9c == addr; // @[Conditional.scala 37:30:@2808.316]
  assign _T_485 = 10'h9d == addr; // @[Conditional.scala 37:30:@2813.318]
  assign _T_488 = 10'h9e == addr; // @[Conditional.scala 37:30:@2818.320]
  assign _T_491 = 10'h9f == addr; // @[Conditional.scala 37:30:@2823.322]
  assign _T_494 = 10'ha0 == addr; // @[Conditional.scala 37:30:@2828.324]
  assign _T_497 = 10'ha1 == addr; // @[Conditional.scala 37:30:@2833.326]
  assign _T_500 = 10'ha2 == addr; // @[Conditional.scala 37:30:@2838.328]
  assign _T_503 = 10'ha3 == addr; // @[Conditional.scala 37:30:@2843.330]
  assign _T_506 = 10'ha4 == addr; // @[Conditional.scala 37:30:@2848.332]
  assign _T_509 = 10'ha5 == addr; // @[Conditional.scala 37:30:@2853.334]
  assign _T_512 = 10'ha6 == addr; // @[Conditional.scala 37:30:@2858.336]
  assign _T_515 = 10'ha7 == addr; // @[Conditional.scala 37:30:@2863.338]
  assign _T_518 = 10'ha8 == addr; // @[Conditional.scala 37:30:@2868.340]
  assign _T_521 = 10'ha9 == addr; // @[Conditional.scala 37:30:@2873.342]
  assign _T_524 = 10'haa == addr; // @[Conditional.scala 37:30:@2878.344]
  assign _T_527 = 10'hab == addr; // @[Conditional.scala 37:30:@2883.346]
  assign _T_530 = 10'hac == addr; // @[Conditional.scala 37:30:@2888.348]
  assign _T_533 = 10'had == addr; // @[Conditional.scala 37:30:@2893.350]
  assign _T_536 = 10'hae == addr; // @[Conditional.scala 37:30:@2898.352]
  assign _T_539 = 10'haf == addr; // @[Conditional.scala 37:30:@2903.354]
  assign _T_542 = 10'hb0 == addr; // @[Conditional.scala 37:30:@2908.356]
  assign _T_545 = 10'hb1 == addr; // @[Conditional.scala 37:30:@2913.358]
  assign _T_548 = 10'hb2 == addr; // @[Conditional.scala 37:30:@2918.360]
  assign _T_551 = 10'hb3 == addr; // @[Conditional.scala 37:30:@2923.362]
  assign _T_554 = 10'hb4 == addr; // @[Conditional.scala 37:30:@2928.364]
  assign _T_557 = 10'hb5 == addr; // @[Conditional.scala 37:30:@2933.366]
  assign _T_560 = 10'hb6 == addr; // @[Conditional.scala 37:30:@2938.368]
  assign _T_563 = 10'hb7 == addr; // @[Conditional.scala 37:30:@2943.370]
  assign _T_566 = 10'hb8 == addr; // @[Conditional.scala 37:30:@2948.372]
  assign _T_569 = 10'hb9 == addr; // @[Conditional.scala 37:30:@2953.374]
  assign _T_572 = 10'hba == addr; // @[Conditional.scala 37:30:@2958.376]
  assign _T_575 = 10'hbb == addr; // @[Conditional.scala 37:30:@2963.378]
  assign _T_578 = 10'hbc == addr; // @[Conditional.scala 37:30:@2968.380]
  assign _T_581 = 10'hbd == addr; // @[Conditional.scala 37:30:@2973.382]
  assign _T_584 = 10'hbe == addr; // @[Conditional.scala 37:30:@2978.384]
  assign _T_587 = 10'hbf == addr; // @[Conditional.scala 37:30:@2983.386]
  assign _T_590 = 10'hc0 == addr; // @[Conditional.scala 37:30:@2988.388]
  assign _T_593 = 10'hc1 == addr; // @[Conditional.scala 37:30:@2993.390]
  assign _T_596 = 10'hc2 == addr; // @[Conditional.scala 37:30:@2998.392]
  assign _T_599 = 10'hc3 == addr; // @[Conditional.scala 37:30:@3003.394]
  assign _T_602 = 10'hc4 == addr; // @[Conditional.scala 37:30:@3008.396]
  assign _T_605 = 10'hc5 == addr; // @[Conditional.scala 37:30:@3013.398]
  assign _T_608 = 10'hc6 == addr; // @[Conditional.scala 37:30:@3018.400]
  assign _T_611 = 10'hc7 == addr; // @[Conditional.scala 37:30:@3023.402]
  assign _T_614 = 10'hc8 == addr; // @[Conditional.scala 37:30:@3028.404]
  assign _T_617 = 10'hc9 == addr; // @[Conditional.scala 37:30:@3033.406]
  assign _T_620 = 10'hca == addr; // @[Conditional.scala 37:30:@3038.408]
  assign _T_623 = 10'hcb == addr; // @[Conditional.scala 37:30:@3043.410]
  assign _T_626 = 10'hcc == addr; // @[Conditional.scala 37:30:@3048.412]
  assign _T_629 = 10'hcd == addr; // @[Conditional.scala 37:30:@3053.414]
  assign _T_632 = 10'hce == addr; // @[Conditional.scala 37:30:@3058.416]
  assign _T_635 = 10'hcf == addr; // @[Conditional.scala 37:30:@3063.418]
  assign _T_638 = 10'hd0 == addr; // @[Conditional.scala 37:30:@3068.420]
  assign _T_641 = 10'hd1 == addr; // @[Conditional.scala 37:30:@3073.422]
  assign _T_644 = 10'hd2 == addr; // @[Conditional.scala 37:30:@3078.424]
  assign _T_647 = 10'hd3 == addr; // @[Conditional.scala 37:30:@3083.426]
  assign _T_650 = 10'hd4 == addr; // @[Conditional.scala 37:30:@3088.428]
  assign _T_653 = 10'hd5 == addr; // @[Conditional.scala 37:30:@3093.430]
  assign _T_656 = 10'hd6 == addr; // @[Conditional.scala 37:30:@3098.432]
  assign _T_659 = 10'hd7 == addr; // @[Conditional.scala 37:30:@3103.434]
  assign _T_662 = 10'hd8 == addr; // @[Conditional.scala 37:30:@3108.436]
  assign _T_665 = 10'hd9 == addr; // @[Conditional.scala 37:30:@3113.438]
  assign _GEN_0 = _T_665 ? 32'h8067 : bmem_data; // @[Conditional.scala 39:67:@3114.438]
  assign _GEN_1 = _T_662 ? 32'h3010113 : _GEN_0; // @[Conditional.scala 39:67:@3109.436]
  assign _GEN_2 = _T_659 ? 32'h2812403 : _GEN_1; // @[Conditional.scala 39:67:@3104.434]
  assign _GEN_3 = _T_656 ? 32'h2c12083 : _GEN_2; // @[Conditional.scala 39:67:@3099.432]
  assign _GEN_4 = _T_653 ? 32'h13 : _GEN_3; // @[Conditional.scala 39:67:@3094.430]
  assign _GEN_5 = _T_650 ? 32'hfc07dce3 : _GEN_4; // @[Conditional.scala 39:67:@3089.428]
  assign _GEN_6 = _T_647 ? 32'hfec42783 : _GEN_5; // @[Conditional.scala 39:67:@3084.426]
  assign _GEN_7 = _T_644 ? 32'hfef42623 : _GEN_6; // @[Conditional.scala 39:67:@3079.424]
  assign _GEN_8 = _T_641 ? 32'hfff78793 : _GEN_7; // @[Conditional.scala 39:67:@3074.422]
  assign _GEN_9 = _T_638 ? 32'hfec42783 : _GEN_8; // @[Conditional.scala 39:67:@3069.420]
  assign _GEN_10 = _T_635 ? 32'hd25ff0ef : _GEN_9; // @[Conditional.scala 39:67:@3064.418]
  assign _GEN_11 = _T_632 ? 32'h78513 : _GEN_10; // @[Conditional.scala 39:67:@3059.416]
  assign _GEN_12 = _T_629 ? 32'hff87c783 : _GEN_11; // @[Conditional.scala 39:67:@3054.414]
  assign _GEN_13 = _T_626 ? 32'hf707b3 : _GEN_12; // @[Conditional.scala 39:67:@3049.412]
  assign _GEN_14 = _T_623 ? 32'hff040713 : _GEN_13; // @[Conditional.scala 39:67:@3044.410]
  assign _GEN_15 = _T_620 ? 32'hfec42783 : _GEN_14; // @[Conditional.scala 39:67:@3039.408]
  assign _GEN_16 = _T_617 ? 32'h280006f : _GEN_15; // @[Conditional.scala 39:67:@3034.406]
  assign _GEN_17 = _T_614 ? 32'hfef42623 : _GEN_16; // @[Conditional.scala 39:67:@3029.404]
  assign _GEN_18 = _T_611 ? 32'h200793 : _GEN_17; // @[Conditional.scala 39:67:@3024.402]
  assign _GEN_19 = _T_608 ? 32'hfef42423 : _GEN_18; // @[Conditional.scala 39:67:@3019.400]
  assign _GEN_20 = _T_605 ? 32'hfdc42783 : _GEN_19; // @[Conditional.scala 39:67:@3014.398]
  assign _GEN_21 = _T_602 ? 32'hfca42e23 : _GEN_20; // @[Conditional.scala 39:67:@3009.396]
  assign _GEN_22 = _T_599 ? 32'h3010413 : _GEN_21; // @[Conditional.scala 39:67:@3004.394]
  assign _GEN_23 = _T_596 ? 32'h2812423 : _GEN_22; // @[Conditional.scala 39:67:@2999.392]
  assign _GEN_24 = _T_593 ? 32'h2112623 : _GEN_23; // @[Conditional.scala 39:67:@2994.390]
  assign _GEN_25 = _T_590 ? 32'hfd010113 : _GEN_24; // @[Conditional.scala 39:67:@2989.388]
  assign _GEN_26 = _T_587 ? 32'h8067 : _GEN_25; // @[Conditional.scala 39:67:@2984.386]
  assign _GEN_27 = _T_584 ? 32'h3010113 : _GEN_26; // @[Conditional.scala 39:67:@2979.384]
  assign _GEN_28 = _T_581 ? 32'h2812403 : _GEN_27; // @[Conditional.scala 39:67:@2974.382]
  assign _GEN_29 = _T_578 ? 32'h2c12083 : _GEN_28; // @[Conditional.scala 39:67:@2969.380]
  assign _GEN_30 = _T_575 ? 32'h78513 : _GEN_29; // @[Conditional.scala 39:67:@2964.378]
  assign _GEN_31 = _T_572 ? 32'hfe842783 : _GEN_30; // @[Conditional.scala 39:67:@2959.376]
  assign _GEN_32 = _T_569 ? 32'he782a3 : _GEN_31; // @[Conditional.scala 39:67:@2954.374]
  assign _GEN_33 = _T_566 ? 32'hff77713 : _GEN_32; // @[Conditional.scala 39:67:@2949.372]
  assign _GEN_34 = _T_563 ? 32'hffe77713 : _GEN_33; // @[Conditional.scala 39:67:@2944.370]
  assign _GEN_35 = _T_560 ? 32'h37b7 : _GEN_34; // @[Conditional.scala 39:67:@2939.368]
  assign _GEN_36 = _T_557 ? 32'hff7f713 : _GEN_35; // @[Conditional.scala 39:67:@2934.366]
  assign _GEN_37 = _T_554 ? 32'h57c783 : _GEN_36; // @[Conditional.scala 39:67:@2929.364]
  assign _GEN_38 = _T_551 ? 32'h37b7 : _GEN_37; // @[Conditional.scala 39:67:@2924.362]
  assign _GEN_39 = _T_548 ? 32'hfce7f6e3 : _GEN_38; // @[Conditional.scala 39:67:@2919.360]
  assign _GEN_40 = _T_545 ? 32'h300793 : _GEN_39; // @[Conditional.scala 39:67:@2914.358]
  assign _GEN_41 = _T_542 ? 32'hfec42703 : _GEN_40; // @[Conditional.scala 39:67:@2909.356]
  assign _GEN_42 = _T_539 ? 32'hfef42623 : _GEN_41; // @[Conditional.scala 39:67:@2904.354]
  assign _GEN_43 = _T_536 ? 32'h178793 : _GEN_42; // @[Conditional.scala 39:67:@2899.352]
  assign _GEN_44 = _T_533 ? 32'hfec42783 : _GEN_43; // @[Conditional.scala 39:67:@2894.350]
  assign _GEN_45 = _T_530 ? 32'hfee78c23 : _GEN_44; // @[Conditional.scala 39:67:@2889.348]
  assign _GEN_46 = _T_527 ? 32'hf687b3 : _GEN_45; // @[Conditional.scala 39:67:@2884.346]
  assign _GEN_47 = _T_524 ? 32'hff040693 : _GEN_46; // @[Conditional.scala 39:67:@2879.344]
  assign _GEN_48 = _T_521 ? 32'hfec42783 : _GEN_47; // @[Conditional.scala 39:67:@2874.342]
  assign _GEN_49 = _T_518 ? 32'h78713 : _GEN_48; // @[Conditional.scala 39:67:@2869.340]
  assign _GEN_50 = _T_515 ? 32'h50793 : _GEN_49; // @[Conditional.scala 39:67:@2864.338]
  assign _GEN_51 = _T_512 ? 32'hdc9ff0ef : _GEN_50; // @[Conditional.scala 39:67:@2859.336]
  assign _GEN_52 = _T_509 ? 32'h513 : _GEN_51; // @[Conditional.scala 39:67:@2854.334]
  assign _GEN_53 = _T_506 ? 32'h300006f : _GEN_52; // @[Conditional.scala 39:67:@2849.332]
  assign _GEN_54 = _T_503 ? 32'hfe042623 : _GEN_53; // @[Conditional.scala 39:67:@2844.330]
  assign _GEN_55 = _T_500 ? 32'h78000ef : _GEN_54; // @[Conditional.scala 39:67:@2839.328]
  assign _GEN_56 = _T_497 ? 32'hfdc42503 : _GEN_55; // @[Conditional.scala 39:67:@2834.326]
  assign _GEN_57 = _T_494 ? 32'hde1ff0ef : _GEN_56; // @[Conditional.scala 39:67:@2829.324]
  assign _GEN_58 = _T_491 ? 32'h300513 : _GEN_57; // @[Conditional.scala 39:67:@2824.322]
  assign _GEN_59 = _T_488 ? 32'he782a3 : _GEN_58; // @[Conditional.scala 39:67:@2819.320]
  assign _GEN_60 = _T_485 ? 32'hff77713 : _GEN_59; // @[Conditional.scala 39:67:@2814.318]
  assign _GEN_61 = _T_482 ? 32'h176713 : _GEN_60; // @[Conditional.scala 39:67:@2809.316]
  assign _GEN_62 = _T_479 ? 32'h37b7 : _GEN_61; // @[Conditional.scala 39:67:@2804.314]
  assign _GEN_63 = _T_476 ? 32'hff7f713 : _GEN_62; // @[Conditional.scala 39:67:@2799.312]
  assign _GEN_64 = _T_473 ? 32'h57c783 : _GEN_63; // @[Conditional.scala 39:67:@2794.310]
  assign _GEN_65 = _T_470 ? 32'h37b7 : _GEN_64; // @[Conditional.scala 39:67:@2789.308]
  assign _GEN_66 = _T_467 ? 32'hfca42e23 : _GEN_65; // @[Conditional.scala 39:67:@2784.306]
  assign _GEN_67 = _T_464 ? 32'h3010413 : _GEN_66; // @[Conditional.scala 39:67:@2779.304]
  assign _GEN_68 = _T_461 ? 32'h2812423 : _GEN_67; // @[Conditional.scala 39:67:@2774.302]
  assign _GEN_69 = _T_458 ? 32'h2112623 : _GEN_68; // @[Conditional.scala 39:67:@2769.300]
  assign _GEN_70 = _T_455 ? 32'hfd010113 : _GEN_69; // @[Conditional.scala 39:67:@2764.298]
  assign _GEN_71 = _T_452 ? 32'h8067 : _GEN_70; // @[Conditional.scala 39:67:@2759.296]
  assign _GEN_72 = _T_449 ? 32'h3010113 : _GEN_71; // @[Conditional.scala 39:67:@2754.294]
  assign _GEN_73 = _T_446 ? 32'h2812403 : _GEN_72; // @[Conditional.scala 39:67:@2749.292]
  assign _GEN_74 = _T_443 ? 32'h2c12083 : _GEN_73; // @[Conditional.scala 39:67:@2744.290]
  assign _GEN_75 = _T_440 ? 32'h13 : _GEN_74; // @[Conditional.scala 39:67:@2739.288]
  assign _GEN_76 = _T_437 ? 32'hfaf76ee3 : _GEN_75; // @[Conditional.scala 39:67:@2734.286]
  assign _GEN_77 = _T_434 ? 32'hfe842703 : _GEN_76; // @[Conditional.scala 39:67:@2729.284]
  assign _GEN_78 = _T_431 ? 32'h27d793 : _GEN_77; // @[Conditional.scala 39:67:@2724.282]
  assign _GEN_79 = _T_428 ? 32'hfd842783 : _GEN_78; // @[Conditional.scala 39:67:@2719.280]
  assign _GEN_80 = _T_425 ? 32'hfef42623 : _GEN_79; // @[Conditional.scala 39:67:@2714.278]
  assign _GEN_81 = _T_422 ? 32'h478793 : _GEN_80; // @[Conditional.scala 39:67:@2709.276]
  assign _GEN_82 = _T_419 ? 32'hfec42783 : _GEN_81; // @[Conditional.scala 39:67:@2704.274]
  assign _GEN_83 = _T_416 ? 32'he7a023 : _GEN_82; // @[Conditional.scala 39:67:@2699.272]
  assign _GEN_84 = _T_413 ? 32'hfe042703 : _GEN_83; // @[Conditional.scala 39:67:@2694.270]
  assign _GEN_85 = _T_410 ? 32'hf707b3 : _GEN_84; // @[Conditional.scala 39:67:@2689.268]
  assign _GEN_86 = _T_407 ? 32'hfe442703 : _GEN_85; // @[Conditional.scala 39:67:@2684.266]
  assign _GEN_87 = _T_404 ? 32'h279793 : _GEN_86; // @[Conditional.scala 39:67:@2679.264]
  assign _GEN_88 = _T_401 ? 32'hfee42423 : _GEN_87; // @[Conditional.scala 39:67:@2674.262]
  assign _GEN_89 = _T_398 ? 32'h178713 : _GEN_88; // @[Conditional.scala 39:67:@2669.260]
  assign _GEN_90 = _T_395 ? 32'hfe842783 : _GEN_89; // @[Conditional.scala 39:67:@2664.258]
  assign _GEN_91 = _T_392 ? 32'hfea42023 : _GEN_90; // @[Conditional.scala 39:67:@2659.256]
  assign _GEN_92 = _T_389 ? 32'h58000ef : _GEN_91; // @[Conditional.scala 39:67:@2654.254]
  assign _GEN_93 = _T_386 ? 32'hfec42503 : _GEN_92; // @[Conditional.scala 39:67:@2649.252]
  assign _GEN_94 = _T_383 ? 32'h3c0006f : _GEN_93; // @[Conditional.scala 39:67:@2644.250]
  assign _GEN_95 = _T_380 ? 32'hfef42623 : _GEN_94; // @[Conditional.scala 39:67:@2639.248]
  assign _GEN_96 = _T_377 ? 32'h878793 : _GEN_95; // @[Conditional.scala 39:67:@2634.246]
  assign _GEN_97 = _T_374 ? 32'hfec42783 : _GEN_96; // @[Conditional.scala 39:67:@2629.244]
  assign _GEN_98 = _T_371 ? 32'hfca42c23 : _GEN_97; // @[Conditional.scala 39:67:@2624.242]
  assign _GEN_99 = _T_368 ? 32'h74000ef : _GEN_98; // @[Conditional.scala 39:67:@2619.240]
  assign _GEN_100 = _T_365 ? 32'h78513 : _GEN_99; // @[Conditional.scala 39:67:@2614.238]
  assign _GEN_101 = _T_362 ? 32'h478793 : _GEN_100; // @[Conditional.scala 39:67:@2609.236]
  assign _GEN_102 = _T_359 ? 32'hfec42783 : _GEN_101; // @[Conditional.scala 39:67:@2604.234]
  assign _GEN_103 = _T_356 ? 32'hfca42e23 : _GEN_102; // @[Conditional.scala 39:67:@2599.232]
  assign _GEN_104 = _T_353 ? 32'h88000ef : _GEN_103; // @[Conditional.scala 39:67:@2594.230]
  assign _GEN_105 = _T_350 ? 32'hfec42503 : _GEN_104; // @[Conditional.scala 39:67:@2589.228]
  assign _GEN_106 = _T_347 ? 32'hfe042423 : _GEN_105; // @[Conditional.scala 39:67:@2584.226]
  assign _GEN_107 = _T_344 ? 32'hfe042023 : _GEN_106; // @[Conditional.scala 39:67:@2579.224]
  assign _GEN_108 = _T_341 ? 32'hfe042223 : _GEN_107; // @[Conditional.scala 39:67:@2574.222]
  assign _GEN_109 = _T_338 ? 32'hfe042623 : _GEN_108; // @[Conditional.scala 39:67:@2569.220]
  assign _GEN_110 = _T_335 ? 32'h3010413 : _GEN_109; // @[Conditional.scala 39:67:@2564.218]
  assign _GEN_111 = _T_332 ? 32'h2812423 : _GEN_110; // @[Conditional.scala 39:67:@2559.216]
  assign _GEN_112 = _T_329 ? 32'h2112623 : _GEN_111; // @[Conditional.scala 39:67:@2554.214]
  assign _GEN_113 = _T_326 ? 32'hfd010113 : _GEN_112; // @[Conditional.scala 39:67:@2549.212]
  assign _GEN_114 = _T_323 ? 32'h8067 : _GEN_113; // @[Conditional.scala 39:67:@2544.210]
  assign _GEN_115 = _T_320 ? 32'h1010113 : _GEN_114; // @[Conditional.scala 39:67:@2539.208]
  assign _GEN_116 = _T_317 ? 32'hc12403 : _GEN_115; // @[Conditional.scala 39:67:@2534.206]
  assign _GEN_117 = _T_314 ? 32'h13 : _GEN_116; // @[Conditional.scala 39:67:@2529.204]
  assign _GEN_118 = _T_311 ? 32'h28067 : _GEN_117; // @[Conditional.scala 39:67:@2524.202]
  assign _GEN_119 = _T_308 ? 32'h2b7 : _GEN_118; // @[Conditional.scala 39:67:@2519.200]
  assign _GEN_120 = _T_305 ? 32'h1010413 : _GEN_119; // @[Conditional.scala 39:67:@2514.198]
  assign _GEN_121 = _T_302 ? 32'h812623 : _GEN_120; // @[Conditional.scala 39:67:@2509.196]
  assign _GEN_122 = _T_299 ? 32'hff010113 : _GEN_121; // @[Conditional.scala 39:67:@2504.194]
  assign _GEN_123 = _T_296 ? 32'h8067 : _GEN_122; // @[Conditional.scala 39:67:@2499.192]
  assign _GEN_124 = _T_293 ? 32'h1010113 : _GEN_123; // @[Conditional.scala 39:67:@2494.190]
  assign _GEN_125 = _T_290 ? 32'h812403 : _GEN_124; // @[Conditional.scala 39:67:@2489.188]
  assign _GEN_126 = _T_287 ? 32'hc12083 : _GEN_125; // @[Conditional.scala 39:67:@2484.186]
  assign _GEN_127 = _T_284 ? 32'h78513 : _GEN_126; // @[Conditional.scala 39:67:@2479.184]
  assign _GEN_128 = _T_281 ? 32'h793 : _GEN_127; // @[Conditional.scala 39:67:@2474.182]
  assign _GEN_129 = _T_278 ? 32'h1c000ef : _GEN_128; // @[Conditional.scala 39:67:@2469.180]
  assign _GEN_130 = _T_275 ? 32'hf89ff0ef : _GEN_129; // @[Conditional.scala 39:67:@2464.178]
  assign _GEN_131 = _T_272 ? 32'h6b00513 : _GEN_130; // @[Conditional.scala 39:67:@2459.176]
  assign _GEN_132 = _T_269 ? 32'hf91ff0ef : _GEN_131; // @[Conditional.scala 39:67:@2454.174]
  assign _GEN_133 = _T_266 ? 32'h4f00513 : _GEN_132; // @[Conditional.scala 39:67:@2449.172]
  assign _GEN_134 = _T_263 ? 32'h54000ef : _GEN_133; // @[Conditional.scala 39:67:@2444.170]
  assign _GEN_135 = _T_260 ? 32'hed5ff0ef : _GEN_134; // @[Conditional.scala 39:67:@2439.168]
  assign _GEN_136 = _T_257 ? 32'h800513 : _GEN_135; // @[Conditional.scala 39:67:@2434.166]
  assign _GEN_137 = _T_254 ? 32'hf75ff0ef : _GEN_136; // @[Conditional.scala 39:67:@2429.164]
  assign _GEN_138 = _T_251 ? 32'h1000513 : _GEN_137; // @[Conditional.scala 39:67:@2424.162]
  assign _GEN_139 = _T_248 ? 32'h1010413 : _GEN_138; // @[Conditional.scala 39:67:@2419.160]
  assign _GEN_140 = _T_245 ? 32'h812423 : _GEN_139; // @[Conditional.scala 39:67:@2414.158]
  assign _GEN_141 = _T_242 ? 32'h112623 : _GEN_140; // @[Conditional.scala 39:67:@2409.156]
  assign _GEN_142 = _T_239 ? 32'hff010113 : _GEN_141; // @[Conditional.scala 39:67:@2404.154]
  assign _GEN_143 = _T_236 ? 32'h8067 : _GEN_142; // @[Conditional.scala 39:67:@2399.152]
  assign _GEN_144 = _T_233 ? 32'h2010113 : _GEN_143; // @[Conditional.scala 39:67:@2394.150]
  assign _GEN_145 = _T_230 ? 32'h1c12403 : _GEN_144; // @[Conditional.scala 39:67:@2389.148]
  assign _GEN_146 = _T_227 ? 32'h13 : _GEN_145; // @[Conditional.scala 39:67:@2384.146]
  assign _GEN_147 = _T_224 ? 32'he780a3 : _GEN_146; // @[Conditional.scala 39:67:@2379.144]
  assign _GEN_148 = _T_221 ? 32'hfef44703 : _GEN_147; // @[Conditional.scala 39:67:@2374.142]
  assign _GEN_149 = _T_218 ? 32'h27b7 : _GEN_148; // @[Conditional.scala 39:67:@2369.140]
  assign _GEN_150 = _T_215 ? 32'hfe0788e3 : _GEN_149; // @[Conditional.scala 39:67:@2364.138]
  assign _GEN_151 = _T_212 ? 32'h27f793 : _GEN_150; // @[Conditional.scala 39:67:@2359.136]
  assign _GEN_152 = _T_209 ? 32'hff7f793 : _GEN_151; // @[Conditional.scala 39:67:@2354.134]
  assign _GEN_153 = _T_206 ? 32'h47c783 : _GEN_152; // @[Conditional.scala 39:67:@2349.132]
  assign _GEN_154 = _T_203 ? 32'h27b7 : _GEN_153; // @[Conditional.scala 39:67:@2344.130]
  assign _GEN_155 = _T_200 ? 32'h13 : _GEN_154; // @[Conditional.scala 39:67:@2339.128]
  assign _GEN_156 = _T_197 ? 32'hfef407a3 : _GEN_155; // @[Conditional.scala 39:67:@2334.126]
  assign _GEN_157 = _T_194 ? 32'h50793 : _GEN_156; // @[Conditional.scala 39:67:@2329.124]
  assign _GEN_158 = _T_191 ? 32'h2010413 : _GEN_157; // @[Conditional.scala 39:67:@2324.122]
  assign _GEN_159 = _T_188 ? 32'h812e23 : _GEN_158; // @[Conditional.scala 39:67:@2319.120]
  assign _GEN_160 = _T_185 ? 32'hfe010113 : _GEN_159; // @[Conditional.scala 39:67:@2314.118]
  assign _GEN_161 = _T_182 ? 32'h8067 : _GEN_160; // @[Conditional.scala 39:67:@2309.116]
  assign _GEN_162 = _T_179 ? 32'h2010113 : _GEN_161; // @[Conditional.scala 39:67:@2304.114]
  assign _GEN_163 = _T_176 ? 32'h1c12403 : _GEN_162; // @[Conditional.scala 39:67:@2299.112]
  assign _GEN_164 = _T_173 ? 32'h13 : _GEN_163; // @[Conditional.scala 39:67:@2294.110]
  assign _GEN_165 = _T_170 ? 32'he78123 : _GEN_164; // @[Conditional.scala 39:67:@2289.108]
  assign _GEN_166 = _T_167 ? 32'hfef44703 : _GEN_165; // @[Conditional.scala 39:67:@2284.106]
  assign _GEN_167 = _T_164 ? 32'h27b7 : _GEN_166; // @[Conditional.scala 39:67:@2279.104]
  assign _GEN_168 = _T_161 ? 32'hfef407a3 : _GEN_167; // @[Conditional.scala 39:67:@2274.102]
  assign _GEN_169 = _T_158 ? 32'h50793 : _GEN_168; // @[Conditional.scala 39:67:@2269.100]
  assign _GEN_170 = _T_155 ? 32'h2010413 : _GEN_169; // @[Conditional.scala 39:67:@2264.98]
  assign _GEN_171 = _T_152 ? 32'h812e23 : _GEN_170; // @[Conditional.scala 39:67:@2259.96]
  assign _GEN_172 = _T_149 ? 32'hfe010113 : _GEN_171; // @[Conditional.scala 39:67:@2254.94]
  assign _GEN_173 = _T_146 ? 32'h8067 : _GEN_172; // @[Conditional.scala 39:67:@2249.92]
  assign _GEN_174 = _T_143 ? 32'h2010113 : _GEN_173; // @[Conditional.scala 39:67:@2244.90]
  assign _GEN_175 = _T_140 ? 32'h1c12403 : _GEN_174; // @[Conditional.scala 39:67:@2239.88]
  assign _GEN_176 = _T_137 ? 32'h78513 : _GEN_175; // @[Conditional.scala 39:67:@2234.86]
  assign _GEN_177 = _T_134 ? 32'hff7f793 : _GEN_176; // @[Conditional.scala 39:67:@2229.84]
  assign _GEN_178 = _T_131 ? 32'h7c783 : _GEN_177; // @[Conditional.scala 39:67:@2224.82]
  assign _GEN_179 = _T_128 ? 32'h37b7 : _GEN_178; // @[Conditional.scala 39:67:@2219.80]
  assign _GEN_180 = _T_125 ? 32'hfe0788e3 : _GEN_179; // @[Conditional.scala 39:67:@2214.78]
  assign _GEN_181 = _T_122 ? 32'h107f793 : _GEN_180; // @[Conditional.scala 39:67:@2209.76]
  assign _GEN_182 = _T_119 ? 32'hff7f793 : _GEN_181; // @[Conditional.scala 39:67:@2204.74]
  assign _GEN_183 = _T_116 ? 32'h47c783 : _GEN_182; // @[Conditional.scala 39:67:@2199.72]
  assign _GEN_184 = _T_113 ? 32'h37b7 : _GEN_183; // @[Conditional.scala 39:67:@2194.70]
  assign _GEN_185 = _T_110 ? 32'h13 : _GEN_184; // @[Conditional.scala 39:67:@2189.68]
  assign _GEN_186 = _T_107 ? 32'he780a3 : _GEN_185; // @[Conditional.scala 39:67:@2184.66]
  assign _GEN_187 = _T_104 ? 32'hfef44703 : _GEN_186; // @[Conditional.scala 39:67:@2179.64]
  assign _GEN_188 = _T_101 ? 32'h37b7 : _GEN_187; // @[Conditional.scala 39:67:@2174.62]
  assign _GEN_189 = _T_98 ? 32'hfef407a3 : _GEN_188; // @[Conditional.scala 39:67:@2169.60]
  assign _GEN_190 = _T_95 ? 32'h50793 : _GEN_189; // @[Conditional.scala 39:67:@2164.58]
  assign _GEN_191 = _T_92 ? 32'h2010413 : _GEN_190; // @[Conditional.scala 39:67:@2159.56]
  assign _GEN_192 = _T_89 ? 32'h812e23 : _GEN_191; // @[Conditional.scala 39:67:@2154.54]
  assign _GEN_193 = _T_86 ? 32'hfe010113 : _GEN_192; // @[Conditional.scala 39:67:@2149.52]
  assign _GEN_194 = _T_83 ? 32'h8067 : _GEN_193; // @[Conditional.scala 39:67:@2144.50]
  assign _GEN_195 = _T_80 ? 32'h2010113 : _GEN_194; // @[Conditional.scala 39:67:@2139.48]
  assign _GEN_196 = _T_77 ? 32'h1c12403 : _GEN_195; // @[Conditional.scala 39:67:@2134.46]
  assign _GEN_197 = _T_74 ? 32'h13 : _GEN_196; // @[Conditional.scala 39:67:@2129.44]
  assign _GEN_198 = _T_71 ? 32'he78123 : _GEN_197; // @[Conditional.scala 39:67:@2124.42]
  assign _GEN_199 = _T_68 ? 32'hff77713 : _GEN_198; // @[Conditional.scala 39:67:@2119.40]
  assign _GEN_200 = _T_65 ? 32'he6e733 : _GEN_199; // @[Conditional.scala 39:67:@2114.38]
  assign _GEN_201 = _T_62 ? 32'hfef44703 : _GEN_200; // @[Conditional.scala 39:67:@2109.36]
  assign _GEN_202 = _T_59 ? 32'h37b7 : _GEN_201; // @[Conditional.scala 39:67:@2104.34]
  assign _GEN_203 = _T_56 ? 32'hff7f693 : _GEN_202; // @[Conditional.scala 39:67:@2099.32]
  assign _GEN_204 = _T_53 ? 32'h27c783 : _GEN_203; // @[Conditional.scala 39:67:@2094.30]
  assign _GEN_205 = _T_50 ? 32'h37b7 : _GEN_204; // @[Conditional.scala 39:67:@2089.28]
  assign _GEN_206 = _T_47 ? 32'hfef407a3 : _GEN_205; // @[Conditional.scala 39:67:@2084.26]
  assign _GEN_207 = _T_44 ? 32'h50793 : _GEN_206; // @[Conditional.scala 39:67:@2079.24]
  assign _GEN_208 = _T_41 ? 32'h2010413 : _GEN_207; // @[Conditional.scala 39:67:@2074.22]
  assign _GEN_209 = _T_38 ? 32'h812e23 : _GEN_208; // @[Conditional.scala 39:67:@2069.20]
  assign _GEN_210 = _T_35 ? 32'hfe010113 : _GEN_209; // @[Conditional.scala 39:67:@2064.18]
  assign _GEN_211 = _T_32 ? 32'h114000ef : _GEN_210; // @[Conditional.scala 39:67:@2059.16]
  assign _GEN_212 = _T_29 ? 32'h593 : _GEN_211; // @[Conditional.scala 39:67:@2054.14]
  assign _GEN_213 = _T_26 ? 32'h513 : _GEN_212; // @[Conditional.scala 39:67:@2049.12]
  assign _GEN_214 = _T_23 ? 32'hf810113 : _GEN_213; // @[Conditional.scala 39:67:@2044.10]
  assign _GEN_215 = _T_20 ? 32'hffffa117 : _GEN_214; // @[Conditional.scala 39:67:@2039.8]
  assign _GEN_216 = _T_17 ? 32'h40006f : _GEN_215; // @[Conditional.scala 39:67:@2034.6]
  assign _GEN_217 = _T_14 ? 32'h13 : _GEN_216; // @[Conditional.scala 40:58:@2029.4]
  assign io_bmem_rdata = bmem_data; // @[bmem.scala 250:17:@3117.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  bmem_data = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      bmem_data <= 32'h0;
    end else begin
      if (_T_14) begin
        bmem_data <= 32'h13;
      end else begin
        if (_T_17) begin
          bmem_data <= 32'h40006f;
        end else begin
          if (_T_20) begin
            bmem_data <= 32'hffffa117;
          end else begin
            if (_T_23) begin
              bmem_data <= 32'hf810113;
            end else begin
              if (_T_26) begin
                bmem_data <= 32'h513;
              end else begin
                if (_T_29) begin
                  bmem_data <= 32'h593;
                end else begin
                  if (_T_32) begin
                    bmem_data <= 32'h114000ef;
                  end else begin
                    if (_T_35) begin
                      bmem_data <= 32'hfe010113;
                    end else begin
                      if (_T_38) begin
                        bmem_data <= 32'h812e23;
                      end else begin
                        if (_T_41) begin
                          bmem_data <= 32'h2010413;
                        end else begin
                          if (_T_44) begin
                            bmem_data <= 32'h50793;
                          end else begin
                            if (_T_47) begin
                              bmem_data <= 32'hfef407a3;
                            end else begin
                              if (_T_50) begin
                                bmem_data <= 32'h37b7;
                              end else begin
                                if (_T_53) begin
                                  bmem_data <= 32'h27c783;
                                end else begin
                                  if (_T_56) begin
                                    bmem_data <= 32'hff7f693;
                                  end else begin
                                    if (_T_59) begin
                                      bmem_data <= 32'h37b7;
                                    end else begin
                                      if (_T_62) begin
                                        bmem_data <= 32'hfef44703;
                                      end else begin
                                        if (_T_65) begin
                                          bmem_data <= 32'he6e733;
                                        end else begin
                                          if (_T_68) begin
                                            bmem_data <= 32'hff77713;
                                          end else begin
                                            if (_T_71) begin
                                              bmem_data <= 32'he78123;
                                            end else begin
                                              if (_T_74) begin
                                                bmem_data <= 32'h13;
                                              end else begin
                                                if (_T_77) begin
                                                  bmem_data <= 32'h1c12403;
                                                end else begin
                                                  if (_T_80) begin
                                                    bmem_data <= 32'h2010113;
                                                  end else begin
                                                    if (_T_83) begin
                                                      bmem_data <= 32'h8067;
                                                    end else begin
                                                      if (_T_86) begin
                                                        bmem_data <= 32'hfe010113;
                                                      end else begin
                                                        if (_T_89) begin
                                                          bmem_data <= 32'h812e23;
                                                        end else begin
                                                          if (_T_92) begin
                                                            bmem_data <= 32'h2010413;
                                                          end else begin
                                                            if (_T_95) begin
                                                              bmem_data <= 32'h50793;
                                                            end else begin
                                                              if (_T_98) begin
                                                                bmem_data <= 32'hfef407a3;
                                                              end else begin
                                                                if (_T_101) begin
                                                                  bmem_data <= 32'h37b7;
                                                                end else begin
                                                                  if (_T_104) begin
                                                                    bmem_data <= 32'hfef44703;
                                                                  end else begin
                                                                    if (_T_107) begin
                                                                      bmem_data <= 32'he780a3;
                                                                    end else begin
                                                                      if (_T_110) begin
                                                                        bmem_data <= 32'h13;
                                                                      end else begin
                                                                        if (_T_113) begin
                                                                          bmem_data <= 32'h37b7;
                                                                        end else begin
                                                                          if (_T_116) begin
                                                                            bmem_data <= 32'h47c783;
                                                                          end else begin
                                                                            if (_T_119) begin
                                                                              bmem_data <= 32'hff7f793;
                                                                            end else begin
                                                                              if (_T_122) begin
                                                                                bmem_data <= 32'h107f793;
                                                                              end else begin
                                                                                if (_T_125) begin
                                                                                  bmem_data <= 32'hfe0788e3;
                                                                                end else begin
                                                                                  if (_T_128) begin
                                                                                    bmem_data <= 32'h37b7;
                                                                                  end else begin
                                                                                    if (_T_131) begin
                                                                                      bmem_data <= 32'h7c783;
                                                                                    end else begin
                                                                                      if (_T_134) begin
                                                                                        bmem_data <= 32'hff7f793;
                                                                                      end else begin
                                                                                        if (_T_137) begin
                                                                                          bmem_data <= 32'h78513;
                                                                                        end else begin
                                                                                          if (_T_140) begin
                                                                                            bmem_data <= 32'h1c12403;
                                                                                          end else begin
                                                                                            if (_T_143) begin
                                                                                              bmem_data <= 32'h2010113;
                                                                                            end else begin
                                                                                              if (_T_146) begin
                                                                                                bmem_data <= 32'h8067;
                                                                                              end else begin
                                                                                                if (_T_149) begin
                                                                                                  bmem_data <= 32'hfe010113;
                                                                                                end else begin
                                                                                                  if (_T_152) begin
                                                                                                    bmem_data <= 32'h812e23;
                                                                                                  end else begin
                                                                                                    if (_T_155) begin
                                                                                                      bmem_data <= 32'h2010413;
                                                                                                    end else begin
                                                                                                      if (_T_158) begin
                                                                                                        bmem_data <= 32'h50793;
                                                                                                      end else begin
                                                                                                        if (_T_161) begin
                                                                                                          bmem_data <= 32'hfef407a3;
                                                                                                        end else begin
                                                                                                          if (_T_164) begin
                                                                                                            bmem_data <= 32'h27b7;
                                                                                                          end else begin
                                                                                                            if (_T_167) begin
                                                                                                              bmem_data <= 32'hfef44703;
                                                                                                            end else begin
                                                                                                              if (_T_170) begin
                                                                                                                bmem_data <= 32'he78123;
                                                                                                              end else begin
                                                                                                                if (_T_173) begin
                                                                                                                  bmem_data <= 32'h13;
                                                                                                                end else begin
                                                                                                                  if (_T_176) begin
                                                                                                                    bmem_data <= 32'h1c12403;
                                                                                                                  end else begin
                                                                                                                    if (_T_179) begin
                                                                                                                      bmem_data <= 32'h2010113;
                                                                                                                    end else begin
                                                                                                                      if (_T_182) begin
                                                                                                                        bmem_data <= 32'h8067;
                                                                                                                      end else begin
                                                                                                                        if (_T_185) begin
                                                                                                                          bmem_data <= 32'hfe010113;
                                                                                                                        end else begin
                                                                                                                          if (_T_188) begin
                                                                                                                            bmem_data <= 32'h812e23;
                                                                                                                          end else begin
                                                                                                                            if (_T_191) begin
                                                                                                                              bmem_data <= 32'h2010413;
                                                                                                                            end else begin
                                                                                                                              if (_T_194) begin
                                                                                                                                bmem_data <= 32'h50793;
                                                                                                                              end else begin
                                                                                                                                if (_T_197) begin
                                                                                                                                  bmem_data <= 32'hfef407a3;
                                                                                                                                end else begin
                                                                                                                                  if (_T_200) begin
                                                                                                                                    bmem_data <= 32'h13;
                                                                                                                                  end else begin
                                                                                                                                    if (_T_203) begin
                                                                                                                                      bmem_data <= 32'h27b7;
                                                                                                                                    end else begin
                                                                                                                                      if (_T_206) begin
                                                                                                                                        bmem_data <= 32'h47c783;
                                                                                                                                      end else begin
                                                                                                                                        if (_T_209) begin
                                                                                                                                          bmem_data <= 32'hff7f793;
                                                                                                                                        end else begin
                                                                                                                                          if (_T_212) begin
                                                                                                                                            bmem_data <= 32'h27f793;
                                                                                                                                          end else begin
                                                                                                                                            if (_T_215) begin
                                                                                                                                              bmem_data <= 32'hfe0788e3;
                                                                                                                                            end else begin
                                                                                                                                              if (_T_218) begin
                                                                                                                                                bmem_data <= 32'h27b7;
                                                                                                                                              end else begin
                                                                                                                                                if (_T_221) begin
                                                                                                                                                  bmem_data <= 32'hfef44703;
                                                                                                                                                end else begin
                                                                                                                                                  if (_T_224) begin
                                                                                                                                                    bmem_data <= 32'he780a3;
                                                                                                                                                  end else begin
                                                                                                                                                    if (_T_227) begin
                                                                                                                                                      bmem_data <= 32'h13;
                                                                                                                                                    end else begin
                                                                                                                                                      if (_T_230) begin
                                                                                                                                                        bmem_data <= 32'h1c12403;
                                                                                                                                                      end else begin
                                                                                                                                                        if (_T_233) begin
                                                                                                                                                          bmem_data <= 32'h2010113;
                                                                                                                                                        end else begin
                                                                                                                                                          if (_T_236) begin
                                                                                                                                                            bmem_data <= 32'h8067;
                                                                                                                                                          end else begin
                                                                                                                                                            if (_T_239) begin
                                                                                                                                                              bmem_data <= 32'hff010113;
                                                                                                                                                            end else begin
                                                                                                                                                              if (_T_242) begin
                                                                                                                                                                bmem_data <= 32'h112623;
                                                                                                                                                              end else begin
                                                                                                                                                                if (_T_245) begin
                                                                                                                                                                  bmem_data <= 32'h812423;
                                                                                                                                                                end else begin
                                                                                                                                                                  if (_T_248) begin
                                                                                                                                                                    bmem_data <= 32'h1010413;
                                                                                                                                                                  end else begin
                                                                                                                                                                    if (_T_251) begin
                                                                                                                                                                      bmem_data <= 32'h1000513;
                                                                                                                                                                    end else begin
                                                                                                                                                                      if (_T_254) begin
                                                                                                                                                                        bmem_data <= 32'hf75ff0ef;
                                                                                                                                                                      end else begin
                                                                                                                                                                        if (_T_257) begin
                                                                                                                                                                          bmem_data <= 32'h800513;
                                                                                                                                                                        end else begin
                                                                                                                                                                          if (_T_260) begin
                                                                                                                                                                            bmem_data <= 32'hed5ff0ef;
                                                                                                                                                                          end else begin
                                                                                                                                                                            if (_T_263) begin
                                                                                                                                                                              bmem_data <= 32'h54000ef;
                                                                                                                                                                            end else begin
                                                                                                                                                                              if (_T_266) begin
                                                                                                                                                                                bmem_data <= 32'h4f00513;
                                                                                                                                                                              end else begin
                                                                                                                                                                                if (_T_269) begin
                                                                                                                                                                                  bmem_data <= 32'hf91ff0ef;
                                                                                                                                                                                end else begin
                                                                                                                                                                                  if (_T_272) begin
                                                                                                                                                                                    bmem_data <= 32'h6b00513;
                                                                                                                                                                                  end else begin
                                                                                                                                                                                    if (_T_275) begin
                                                                                                                                                                                      bmem_data <= 32'hf89ff0ef;
                                                                                                                                                                                    end else begin
                                                                                                                                                                                      if (_T_278) begin
                                                                                                                                                                                        bmem_data <= 32'h1c000ef;
                                                                                                                                                                                      end else begin
                                                                                                                                                                                        if (_T_281) begin
                                                                                                                                                                                          bmem_data <= 32'h793;
                                                                                                                                                                                        end else begin
                                                                                                                                                                                          if (_T_284) begin
                                                                                                                                                                                            bmem_data <= 32'h78513;
                                                                                                                                                                                          end else begin
                                                                                                                                                                                            if (_T_287) begin
                                                                                                                                                                                              bmem_data <= 32'hc12083;
                                                                                                                                                                                            end else begin
                                                                                                                                                                                              if (_T_290) begin
                                                                                                                                                                                                bmem_data <= 32'h812403;
                                                                                                                                                                                              end else begin
                                                                                                                                                                                                if (_T_293) begin
                                                                                                                                                                                                  bmem_data <= 32'h1010113;
                                                                                                                                                                                                end else begin
                                                                                                                                                                                                  if (_T_296) begin
                                                                                                                                                                                                    bmem_data <= 32'h8067;
                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                    if (_T_299) begin
                                                                                                                                                                                                      bmem_data <= 32'hff010113;
                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                      if (_T_302) begin
                                                                                                                                                                                                        bmem_data <= 32'h812623;
                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                        if (_T_305) begin
                                                                                                                                                                                                          bmem_data <= 32'h1010413;
                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                          if (_T_308) begin
                                                                                                                                                                                                            bmem_data <= 32'h2b7;
                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                            if (_T_311) begin
                                                                                                                                                                                                              bmem_data <= 32'h28067;
                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                              if (_T_314) begin
                                                                                                                                                                                                                bmem_data <= 32'h13;
                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                if (_T_317) begin
                                                                                                                                                                                                                  bmem_data <= 32'hc12403;
                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                  if (_T_320) begin
                                                                                                                                                                                                                    bmem_data <= 32'h1010113;
                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                    if (_T_323) begin
                                                                                                                                                                                                                      bmem_data <= 32'h8067;
                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                      if (_T_326) begin
                                                                                                                                                                                                                        bmem_data <= 32'hfd010113;
                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                        if (_T_329) begin
                                                                                                                                                                                                                          bmem_data <= 32'h2112623;
                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                          if (_T_332) begin
                                                                                                                                                                                                                            bmem_data <= 32'h2812423;
                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                            if (_T_335) begin
                                                                                                                                                                                                                              bmem_data <= 32'h3010413;
                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                              if (_T_338) begin
                                                                                                                                                                                                                                bmem_data <= 32'hfe042623;
                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                if (_T_341) begin
                                                                                                                                                                                                                                  bmem_data <= 32'hfe042223;
                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                  if (_T_344) begin
                                                                                                                                                                                                                                    bmem_data <= 32'hfe042023;
                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                    if (_T_347) begin
                                                                                                                                                                                                                                      bmem_data <= 32'hfe042423;
                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                      if (_T_350) begin
                                                                                                                                                                                                                                        bmem_data <= 32'hfec42503;
                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                        if (_T_353) begin
                                                                                                                                                                                                                                          bmem_data <= 32'h88000ef;
                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                          if (_T_356) begin
                                                                                                                                                                                                                                            bmem_data <= 32'hfca42e23;
                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                            if (_T_359) begin
                                                                                                                                                                                                                                              bmem_data <= 32'hfec42783;
                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                              if (_T_362) begin
                                                                                                                                                                                                                                                bmem_data <= 32'h478793;
                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                if (_T_365) begin
                                                                                                                                                                                                                                                  bmem_data <= 32'h78513;
                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                  if (_T_368) begin
                                                                                                                                                                                                                                                    bmem_data <= 32'h74000ef;
                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                    if (_T_371) begin
                                                                                                                                                                                                                                                      bmem_data <= 32'hfca42c23;
                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                      if (_T_374) begin
                                                                                                                                                                                                                                                        bmem_data <= 32'hfec42783;
                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                        if (_T_377) begin
                                                                                                                                                                                                                                                          bmem_data <= 32'h878793;
                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                          if (_T_380) begin
                                                                                                                                                                                                                                                            bmem_data <= 32'hfef42623;
                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                            if (_T_383) begin
                                                                                                                                                                                                                                                              bmem_data <= 32'h3c0006f;
                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                              if (_T_386) begin
                                                                                                                                                                                                                                                                bmem_data <= 32'hfec42503;
                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                if (_T_389) begin
                                                                                                                                                                                                                                                                  bmem_data <= 32'h58000ef;
                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                  if (_T_392) begin
                                                                                                                                                                                                                                                                    bmem_data <= 32'hfea42023;
                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                    if (_T_395) begin
                                                                                                                                                                                                                                                                      bmem_data <= 32'hfe842783;
                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                      if (_T_398) begin
                                                                                                                                                                                                                                                                        bmem_data <= 32'h178713;
                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                        if (_T_401) begin
                                                                                                                                                                                                                                                                          bmem_data <= 32'hfee42423;
                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                          if (_T_404) begin
                                                                                                                                                                                                                                                                            bmem_data <= 32'h279793;
                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                            if (_T_407) begin
                                                                                                                                                                                                                                                                              bmem_data <= 32'hfe442703;
                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                              if (_T_410) begin
                                                                                                                                                                                                                                                                                bmem_data <= 32'hf707b3;
                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                if (_T_413) begin
                                                                                                                                                                                                                                                                                  bmem_data <= 32'hfe042703;
                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                  if (_T_416) begin
                                                                                                                                                                                                                                                                                    bmem_data <= 32'he7a023;
                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                    if (_T_419) begin
                                                                                                                                                                                                                                                                                      bmem_data <= 32'hfec42783;
                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                      if (_T_422) begin
                                                                                                                                                                                                                                                                                        bmem_data <= 32'h478793;
                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                        if (_T_425) begin
                                                                                                                                                                                                                                                                                          bmem_data <= 32'hfef42623;
                                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                                          if (_T_428) begin
                                                                                                                                                                                                                                                                                            bmem_data <= 32'hfd842783;
                                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                                            if (_T_431) begin
                                                                                                                                                                                                                                                                                              bmem_data <= 32'h27d793;
                                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                                              if (_T_434) begin
                                                                                                                                                                                                                                                                                                bmem_data <= 32'hfe842703;
                                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                                if (_T_437) begin
                                                                                                                                                                                                                                                                                                  bmem_data <= 32'hfaf76ee3;
                                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                                  if (_T_440) begin
                                                                                                                                                                                                                                                                                                    bmem_data <= 32'h13;
                                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                                    if (_T_443) begin
                                                                                                                                                                                                                                                                                                      bmem_data <= 32'h2c12083;
                                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                                      if (_T_446) begin
                                                                                                                                                                                                                                                                                                        bmem_data <= 32'h2812403;
                                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                                        if (_T_449) begin
                                                                                                                                                                                                                                                                                                          bmem_data <= 32'h3010113;
                                                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                                                          if (_T_452) begin
                                                                                                                                                                                                                                                                                                            bmem_data <= 32'h8067;
                                                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                                                            if (_T_455) begin
                                                                                                                                                                                                                                                                                                              bmem_data <= 32'hfd010113;
                                                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                                                              if (_T_458) begin
                                                                                                                                                                                                                                                                                                                bmem_data <= 32'h2112623;
                                                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                                                if (_T_461) begin
                                                                                                                                                                                                                                                                                                                  bmem_data <= 32'h2812423;
                                                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                                                  if (_T_464) begin
                                                                                                                                                                                                                                                                                                                    bmem_data <= 32'h3010413;
                                                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                                                    if (_T_467) begin
                                                                                                                                                                                                                                                                                                                      bmem_data <= 32'hfca42e23;
                                                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                                                      if (_T_470) begin
                                                                                                                                                                                                                                                                                                                        bmem_data <= 32'h37b7;
                                                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                                                        if (_T_473) begin
                                                                                                                                                                                                                                                                                                                          bmem_data <= 32'h57c783;
                                                                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                                                                          if (_T_476) begin
                                                                                                                                                                                                                                                                                                                            bmem_data <= 32'hff7f713;
                                                                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                                                                            if (_T_479) begin
                                                                                                                                                                                                                                                                                                                              bmem_data <= 32'h37b7;
                                                                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                                                                              if (_T_482) begin
                                                                                                                                                                                                                                                                                                                                bmem_data <= 32'h176713;
                                                                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                                                                if (_T_485) begin
                                                                                                                                                                                                                                                                                                                                  bmem_data <= 32'hff77713;
                                                                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                                                                  if (_T_488) begin
                                                                                                                                                                                                                                                                                                                                    bmem_data <= 32'he782a3;
                                                                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                                                                    if (_T_491) begin
                                                                                                                                                                                                                                                                                                                                      bmem_data <= 32'h300513;
                                                                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                                                                      if (_T_494) begin
                                                                                                                                                                                                                                                                                                                                        bmem_data <= 32'hde1ff0ef;
                                                                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                                                                        if (_T_497) begin
                                                                                                                                                                                                                                                                                                                                          bmem_data <= 32'hfdc42503;
                                                                                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                                                                                          if (_T_500) begin
                                                                                                                                                                                                                                                                                                                                            bmem_data <= 32'h78000ef;
                                                                                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                                                                                            if (_T_503) begin
                                                                                                                                                                                                                                                                                                                                              bmem_data <= 32'hfe042623;
                                                                                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                                                                                              if (_T_506) begin
                                                                                                                                                                                                                                                                                                                                                bmem_data <= 32'h300006f;
                                                                                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                                                                                if (_T_509) begin
                                                                                                                                                                                                                                                                                                                                                  bmem_data <= 32'h513;
                                                                                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                                                                                  if (_T_512) begin
                                                                                                                                                                                                                                                                                                                                                    bmem_data <= 32'hdc9ff0ef;
                                                                                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                                                                                    if (_T_515) begin
                                                                                                                                                                                                                                                                                                                                                      bmem_data <= 32'h50793;
                                                                                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                                                                                      if (_T_518) begin
                                                                                                                                                                                                                                                                                                                                                        bmem_data <= 32'h78713;
                                                                                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                                                                                        if (_T_521) begin
                                                                                                                                                                                                                                                                                                                                                          bmem_data <= 32'hfec42783;
                                                                                                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                                                                                                          if (_T_524) begin
                                                                                                                                                                                                                                                                                                                                                            bmem_data <= 32'hff040693;
                                                                                                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                                                                                                            if (_T_527) begin
                                                                                                                                                                                                                                                                                                                                                              bmem_data <= 32'hf687b3;
                                                                                                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                                                                                                              if (_T_530) begin
                                                                                                                                                                                                                                                                                                                                                                bmem_data <= 32'hfee78c23;
                                                                                                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                                                                                                if (_T_533) begin
                                                                                                                                                                                                                                                                                                                                                                  bmem_data <= 32'hfec42783;
                                                                                                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                                                                                                  if (_T_536) begin
                                                                                                                                                                                                                                                                                                                                                                    bmem_data <= 32'h178793;
                                                                                                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                                                                                                    if (_T_539) begin
                                                                                                                                                                                                                                                                                                                                                                      bmem_data <= 32'hfef42623;
                                                                                                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                                                                                                      if (_T_542) begin
                                                                                                                                                                                                                                                                                                                                                                        bmem_data <= 32'hfec42703;
                                                                                                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                                                                                                        if (_T_545) begin
                                                                                                                                                                                                                                                                                                                                                                          bmem_data <= 32'h300793;
                                                                                                                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                                                                                                                          if (_T_548) begin
                                                                                                                                                                                                                                                                                                                                                                            bmem_data <= 32'hfce7f6e3;
                                                                                                                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                                                                                                                            if (_T_551) begin
                                                                                                                                                                                                                                                                                                                                                                              bmem_data <= 32'h37b7;
                                                                                                                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                                                                                                                              if (_T_554) begin
                                                                                                                                                                                                                                                                                                                                                                                bmem_data <= 32'h57c783;
                                                                                                                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                                                                                                                if (_T_557) begin
                                                                                                                                                                                                                                                                                                                                                                                  bmem_data <= 32'hff7f713;
                                                                                                                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                                                                                                                  if (_T_560) begin
                                                                                                                                                                                                                                                                                                                                                                                    bmem_data <= 32'h37b7;
                                                                                                                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                                                                                                                    if (_T_563) begin
                                                                                                                                                                                                                                                                                                                                                                                      bmem_data <= 32'hffe77713;
                                                                                                                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                                                                                                                      if (_T_566) begin
                                                                                                                                                                                                                                                                                                                                                                                        bmem_data <= 32'hff77713;
                                                                                                                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                                                                                                                        if (_T_569) begin
                                                                                                                                                                                                                                                                                                                                                                                          bmem_data <= 32'he782a3;
                                                                                                                                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                                                                                                                                          if (_T_572) begin
                                                                                                                                                                                                                                                                                                                                                                                            bmem_data <= 32'hfe842783;
                                                                                                                                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                                                                                                                                            if (_T_575) begin
                                                                                                                                                                                                                                                                                                                                                                                              bmem_data <= 32'h78513;
                                                                                                                                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                                                                                                                                              if (_T_578) begin
                                                                                                                                                                                                                                                                                                                                                                                                bmem_data <= 32'h2c12083;
                                                                                                                                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                                                                                                                                if (_T_581) begin
                                                                                                                                                                                                                                                                                                                                                                                                  bmem_data <= 32'h2812403;
                                                                                                                                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                                                                                                                                  if (_T_584) begin
                                                                                                                                                                                                                                                                                                                                                                                                    bmem_data <= 32'h3010113;
                                                                                                                                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                                                                                                                                    if (_T_587) begin
                                                                                                                                                                                                                                                                                                                                                                                                      bmem_data <= 32'h8067;
                                                                                                                                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                                                                                                                                      if (_T_590) begin
                                                                                                                                                                                                                                                                                                                                                                                                        bmem_data <= 32'hfd010113;
                                                                                                                                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                                                                                                                                        if (_T_593) begin
                                                                                                                                                                                                                                                                                                                                                                                                          bmem_data <= 32'h2112623;
                                                                                                                                                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                                                                                                                                                          if (_T_596) begin
                                                                                                                                                                                                                                                                                                                                                                                                            bmem_data <= 32'h2812423;
                                                                                                                                                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                                                                                                                                                            if (_T_599) begin
                                                                                                                                                                                                                                                                                                                                                                                                              bmem_data <= 32'h3010413;
                                                                                                                                                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                                                                                                                                                              if (_T_602) begin
                                                                                                                                                                                                                                                                                                                                                                                                                bmem_data <= 32'hfca42e23;
                                                                                                                                                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                if (_T_605) begin
                                                                                                                                                                                                                                                                                                                                                                                                                  bmem_data <= 32'hfdc42783;
                                                                                                                                                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                  if (_T_608) begin
                                                                                                                                                                                                                                                                                                                                                                                                                    bmem_data <= 32'hfef42423;
                                                                                                                                                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                    if (_T_611) begin
                                                                                                                                                                                                                                                                                                                                                                                                                      bmem_data <= 32'h200793;
                                                                                                                                                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                      if (_T_614) begin
                                                                                                                                                                                                                                                                                                                                                                                                                        bmem_data <= 32'hfef42623;
                                                                                                                                                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                        if (_T_617) begin
                                                                                                                                                                                                                                                                                                                                                                                                                          bmem_data <= 32'h280006f;
                                                                                                                                                                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                          if (_T_620) begin
                                                                                                                                                                                                                                                                                                                                                                                                                            bmem_data <= 32'hfec42783;
                                                                                                                                                                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                            if (_T_623) begin
                                                                                                                                                                                                                                                                                                                                                                                                                              bmem_data <= 32'hff040713;
                                                                                                                                                                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                              if (_T_626) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                bmem_data <= 32'hf707b3;
                                                                                                                                                                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                if (_T_629) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                  bmem_data <= 32'hff87c783;
                                                                                                                                                                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                  if (_T_632) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                    bmem_data <= 32'h78513;
                                                                                                                                                                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                    if (_T_635) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                      bmem_data <= 32'hd25ff0ef;
                                                                                                                                                                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                      if (_T_638) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                        bmem_data <= 32'hfec42783;
                                                                                                                                                                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                        if (_T_641) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                          bmem_data <= 32'hfff78793;
                                                                                                                                                                                                                                                                                                                                                                                                                                        end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                          if (_T_644) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                            bmem_data <= 32'hfef42623;
                                                                                                                                                                                                                                                                                                                                                                                                                                          end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                            if (_T_647) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                              bmem_data <= 32'hfec42783;
                                                                                                                                                                                                                                                                                                                                                                                                                                            end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                              if (_T_650) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                bmem_data <= 32'hfc07dce3;
                                                                                                                                                                                                                                                                                                                                                                                                                                              end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                if (_T_653) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                  bmem_data <= 32'h13;
                                                                                                                                                                                                                                                                                                                                                                                                                                                end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                  if (_T_656) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                    bmem_data <= 32'h2c12083;
                                                                                                                                                                                                                                                                                                                                                                                                                                                  end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                    if (_T_659) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                      bmem_data <= 32'h2812403;
                                                                                                                                                                                                                                                                                                                                                                                                                                                    end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                      if (_T_662) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                        bmem_data <= 32'h3010113;
                                                                                                                                                                                                                                                                                                                                                                                                                                                      end else begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                        if (_T_665) begin
                                                                                                                                                                                                                                                                                                                                                                                                                                                          bmem_data <= 32'h8067;
                                                                                                                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                end
                                                                                                                                                                                                                              end
                                                                                                                                                                                                                            end
                                                                                                                                                                                                                          end
                                                                                                                                                                                                                        end
                                                                                                                                                                                                                      end
                                                                                                                                                                                                                    end
                                                                                                                                                                                                                  end
                                                                                                                                                                                                                end
                                                                                                                                                                                                              end
                                                                                                                                                                                                            end
                                                                                                                                                                                                          end
                                                                                                                                                                                                        end
                                                                                                                                                                                                      end
                                                                                                                                                                                                    end
                                                                                                                                                                                                  end
                                                                                                                                                                                                end
                                                                                                                                                                                              end
                                                                                                                                                                                            end
                                                                                                                                                                                          end
                                                                                                                                                                                        end
                                                                                                                                                                                      end
                                                                                                                                                                                    end
                                                                                                                                                                                  end
                                                                                                                                                                                end
                                                                                                                                                                              end
                                                                                                                                                                            end
                                                                                                                                                                          end
                                                                                                                                                                        end
                                                                                                                                                                      end
                                                                                                                                                                    end
                                                                                                                                                                  end
                                                                                                                                                                end
                                                                                                                                                              end
                                                                                                                                                            end
                                                                                                                                                          end
                                                                                                                                                        end
                                                                                                                                                      end
                                                                                                                                                    end
                                                                                                                                                  end
                                                                                                                                                end
                                                                                                                                              end
                                                                                                                                            end
                                                                                                                                          end
                                                                                                                                        end
                                                                                                                                      end
                                                                                                                                    end
                                                                                                                                  end
                                                                                                                                end
                                                                                                                              end
                                                                                                                            end
                                                                                                                          end
                                                                                                                        end
                                                                                                                      end
                                                                                                                    end
                                                                                                                  end
                                                                                                                end
                                                                                                              end
                                                                                                            end
                                                                                                          end
                                                                                                        end
                                                                                                      end
                                                                                                    end
                                                                                                  end
                                                                                                end
                                                                                              end
                                                                                            end
                                                                                          end
                                                                                        end
                                                                                      end
                                                                                    end
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
endmodule
module IMem_Interface( // @[:@3119.2]
  input         clock, // @[:@3120.4]
  input         reset, // @[:@3121.4]
  input  [31:0] io_ibus_addr, // @[:@3122.4]
  output [31:0] io_ibus_inst, // @[:@3122.4]
  output        io_ibus_valid, // @[:@3122.4]
  input  [15:0] io_wbs_m2s_addr, // @[:@3122.4]
  input  [31:0] io_wbs_m2s_data, // @[:@3122.4]
  input         io_wbs_m2s_we, // @[:@3122.4]
  input  [3:0]  io_wbs_m2s_sel, // @[:@3122.4]
  input         io_wbs_m2s_stb, // @[:@3122.4]
  output        io_wbs_ack_o, // @[:@3122.4]
  output [31:0] io_wbs_data_o // @[:@3122.4]
);
  wire  imem_clock; // @[imem_interface.scala 40:20:@3124.4]
  wire [31:0] imem_io_imem_addr; // @[imem_interface.scala 40:20:@3124.4]
  wire [31:0] imem_io_imem_rdata; // @[imem_interface.scala 40:20:@3124.4]
  wire [31:0] imem_io_imem_wdata; // @[imem_interface.scala 40:20:@3124.4]
  wire  imem_io_wr_en; // @[imem_interface.scala 40:20:@3124.4]
  wire  bmem_clock; // @[imem_interface.scala 41:20:@3127.4]
  wire  bmem_reset; // @[imem_interface.scala 41:20:@3127.4]
  wire [31:0] bmem_io_bmem_addr; // @[imem_interface.scala 41:20:@3127.4]
  wire [31:0] bmem_io_bmem_rdata; // @[imem_interface.scala 41:20:@3127.4]
  wire [10:0] ibus_imem_addr; // @[imem_interface.scala 47:41:@3130.4]
  wire [9:0] ibus_bmem_addr; // @[imem_interface.scala 48:41:@3131.4]
  wire [10:0] wbs_imem_addr; // @[imem_interface.scala 49:44:@3132.4]
  reg  ack; // @[imem_interface.scala 54:31:@3133.4]
  reg [31:0] _RAND_0;
  reg [3:0] wb_select; // @[imem_interface.scala 55:27:@3134.4]
  reg [31:0] _RAND_1;
  wire  _T_45; // @[imem_interface.scala 57:24:@3135.4]
  wire  wb_rd_en; // @[imem_interface.scala 57:39:@3136.4]
  wire  wb_wr_en; // @[imem_interface.scala 58:38:@3137.4]
  wire [3:0] _T_46; // @[imem_interface.scala 63:46:@3138.4]
  wire  _T_48; // @[imem_interface.scala 63:84:@3139.4]
  wire  imem_wbs_addr_match; // @[imem_interface.scala 63:29:@3140.4]
  wire  _T_52; // @[imem_interface.scala 70:33:@3144.4]
  wire  imem_wbs_sel; // @[imem_interface.scala 70:46:@3145.4]
  reg  imem_ibus_valid; // @[imem_interface.scala 71:32:@3147.4]
  reg [31:0] _RAND_2;
  wire  _T_57; // @[imem_interface.scala 72:22:@3148.4]
  wire [10:0] imem_addr; // @[imem_interface.scala 80:27:@3154.4]
  wire [31:0] rd_imem_inst; // @[imem_interface.scala 92:23:@3159.4]
  wire [31:0] rd_imem_const; // @[imem_interface.scala 92:23:@3159.4]
  wire  _GEN_2; // @[imem_interface.scala 98:20:@3165.4]
  wire  _T_64; // @[imem_interface.scala 106:18:@3171.4]
  wire [7:0] _T_65; // @[imem_interface.scala 107:33:@3173.6]
  wire  _T_66; // @[imem_interface.scala 108:24:@3177.6]
  wire [7:0] _T_67; // @[imem_interface.scala 109:33:@3179.8]
  wire  _T_68; // @[imem_interface.scala 110:24:@3183.8]
  wire [7:0] _T_69; // @[imem_interface.scala 111:33:@3185.10]
  wire  _T_70; // @[imem_interface.scala 112:24:@3189.10]
  wire [7:0] _T_71; // @[imem_interface.scala 113:33:@3191.12]
  wire  _T_72; // @[imem_interface.scala 114:24:@3195.12]
  wire [15:0] _T_73; // @[imem_interface.scala 115:33:@3197.14]
  wire  _T_74; // @[imem_interface.scala 116:24:@3201.14]
  wire [15:0] _T_75; // @[imem_interface.scala 117:33:@3203.16]
  wire [31:0] _GEN_3; // @[imem_interface.scala 116:54:@3202.14]
  wire [31:0] _GEN_4; // @[imem_interface.scala 114:52:@3196.12]
  wire [31:0] _GEN_5; // @[imem_interface.scala 112:52:@3190.10]
  wire [31:0] _GEN_6; // @[imem_interface.scala 110:52:@3184.8]
  wire [31:0] _GEN_7; // @[imem_interface.scala 108:52:@3178.6]
  reg  bmem_ibus_sel; // @[imem_interface.scala 127:31:@3212.4]
  reg [31:0] _RAND_3;
  wire [3:0] _T_79; // @[imem_interface.scala 128:34:@3213.4]
  wire  _T_81; // @[imem_interface.scala 128:66:@3214.4]
  IMem imem ( // @[imem_interface.scala 40:20:@3124.4]
    .clock(imem_clock),
    .io_imem_addr(imem_io_imem_addr),
    .io_imem_rdata(imem_io_imem_rdata),
    .io_imem_wdata(imem_io_imem_wdata),
    .io_wr_en(imem_io_wr_en)
  );
  BMem bmem ( // @[imem_interface.scala 41:20:@3127.4]
    .clock(bmem_clock),
    .reset(bmem_reset),
    .io_bmem_addr(bmem_io_bmem_addr),
    .io_bmem_rdata(bmem_io_bmem_rdata)
  );
  assign ibus_imem_addr = io_ibus_addr[10:0]; // @[imem_interface.scala 47:41:@3130.4]
  assign ibus_bmem_addr = io_ibus_addr[9:0]; // @[imem_interface.scala 48:41:@3131.4]
  assign wbs_imem_addr = io_wbs_m2s_addr[10:0]; // @[imem_interface.scala 49:44:@3132.4]
  assign _T_45 = io_wbs_m2s_we == 1'h0; // @[imem_interface.scala 57:24:@3135.4]
  assign wb_rd_en = _T_45 & io_wbs_m2s_stb; // @[imem_interface.scala 57:39:@3136.4]
  assign wb_wr_en = io_wbs_m2s_we & io_wbs_m2s_stb; // @[imem_interface.scala 58:38:@3137.4]
  assign _T_46 = io_wbs_m2s_addr[15:12]; // @[imem_interface.scala 63:46:@3138.4]
  assign _T_48 = _T_46 != 4'h0; // @[imem_interface.scala 63:84:@3139.4]
  assign imem_wbs_addr_match = _T_48 == 1'h0; // @[imem_interface.scala 63:29:@3140.4]
  assign _T_52 = wb_rd_en | wb_wr_en; // @[imem_interface.scala 70:33:@3144.4]
  assign imem_wbs_sel = _T_52 & imem_wbs_addr_match; // @[imem_interface.scala 70:46:@3145.4]
  assign _T_57 = imem_wbs_sel == 1'h0; // @[imem_interface.scala 72:22:@3148.4]
  assign imem_addr = imem_wbs_sel ? wbs_imem_addr : ibus_imem_addr; // @[imem_interface.scala 80:27:@3154.4]
  assign rd_imem_inst = imem_ibus_valid ? imem_io_imem_rdata : 32'h0; // @[imem_interface.scala 92:23:@3159.4]
  assign rd_imem_const = imem_ibus_valid ? 32'h0 : imem_io_imem_rdata; // @[imem_interface.scala 92:23:@3159.4]
  assign _GEN_2 = imem_wbs_sel ? io_wbs_m2s_stb : ack; // @[imem_interface.scala 98:20:@3165.4]
  assign _T_64 = wb_select == 4'h1; // @[imem_interface.scala 106:18:@3171.4]
  assign _T_65 = rd_imem_const[7:0]; // @[imem_interface.scala 107:33:@3173.6]
  assign _T_66 = wb_select == 4'h2; // @[imem_interface.scala 108:24:@3177.6]
  assign _T_67 = rd_imem_const[15:8]; // @[imem_interface.scala 109:33:@3179.8]
  assign _T_68 = wb_select == 4'h4; // @[imem_interface.scala 110:24:@3183.8]
  assign _T_69 = rd_imem_const[23:16]; // @[imem_interface.scala 111:33:@3185.10]
  assign _T_70 = wb_select == 4'h8; // @[imem_interface.scala 112:24:@3189.10]
  assign _T_71 = rd_imem_const[31:24]; // @[imem_interface.scala 113:33:@3191.12]
  assign _T_72 = wb_select == 4'h3; // @[imem_interface.scala 114:24:@3195.12]
  assign _T_73 = rd_imem_const[15:0]; // @[imem_interface.scala 115:33:@3197.14]
  assign _T_74 = wb_select == 4'hc; // @[imem_interface.scala 116:24:@3201.14]
  assign _T_75 = rd_imem_const[31:16]; // @[imem_interface.scala 117:33:@3203.16]
  assign _GEN_3 = _T_74 ? {{16'd0}, _T_75} : rd_imem_const; // @[imem_interface.scala 116:54:@3202.14]
  assign _GEN_4 = _T_72 ? {{16'd0}, _T_73} : _GEN_3; // @[imem_interface.scala 114:52:@3196.12]
  assign _GEN_5 = _T_70 ? {{24'd0}, _T_71} : _GEN_4; // @[imem_interface.scala 112:52:@3190.10]
  assign _GEN_6 = _T_68 ? {{24'd0}, _T_69} : _GEN_5; // @[imem_interface.scala 110:52:@3184.8]
  assign _GEN_7 = _T_66 ? {{24'd0}, _T_67} : _GEN_6; // @[imem_interface.scala 108:52:@3178.6]
  assign _T_79 = io_ibus_addr[15:12]; // @[imem_interface.scala 128:34:@3213.4]
  assign _T_81 = _T_79 == 4'h7; // @[imem_interface.scala 128:66:@3214.4]
  assign io_ibus_inst = bmem_ibus_sel ? bmem_io_bmem_rdata : rd_imem_inst; // @[imem_interface.scala 137:19:@3218.4]
  assign io_ibus_valid = bmem_ibus_sel ? 1'h1 : imem_ibus_valid; // @[imem_interface.scala 138:19:@3220.4]
  assign io_wbs_ack_o = ack; // @[imem_interface.scala 123:18:@3210.4]
  assign io_wbs_data_o = _T_64 ? {{24'd0}, _T_65} : _GEN_7; // @[imem_interface.scala 124:18:@3211.4]
  assign imem_clock = clock; // @[:@3125.4]
  assign imem_io_imem_addr = {{21'd0}, imem_addr}; // @[imem_interface.scala 81:21:@3155.4]
  assign imem_io_imem_wdata = io_wbs_m2s_data; // @[imem_interface.scala 87:22:@3156.4]
  assign imem_io_wr_en = imem_wbs_addr_match & wb_wr_en; // @[imem_interface.scala 88:17:@3157.4]
  assign bmem_clock = clock; // @[:@3128.4]
  assign bmem_reset = reset; // @[:@3129.4]
  assign bmem_io_bmem_addr = {{22'd0}, ibus_bmem_addr}; // @[imem_interface.scala 130:21:@3216.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ack = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  wb_select = _RAND_1[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  imem_ibus_valid = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  bmem_ibus_sel = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      ack <= 1'h1;
    end else begin
      if (imem_wbs_sel) begin
        ack <= io_wbs_m2s_stb;
      end
    end
    wb_select <= io_wbs_m2s_sel;
    if (reset) begin
      imem_ibus_valid <= 1'h1;
    end else begin
      imem_ibus_valid <= _T_57;
    end
    if (reset) begin
      bmem_ibus_sel <= 1'h0;
    end else begin
      bmem_ibus_sel <= _T_81;
    end
  end
endmodule
module WBM_DBus( // @[:@3222.2]
  input  [31:0] io_dbus_addr, // @[:@3225.4]
  input  [31:0] io_dbus_wdata, // @[:@3225.4]
  output [31:0] io_dbus_rdata, // @[:@3225.4]
  input         io_dbus_rd_en, // @[:@3225.4]
  input         io_dbus_wr_en, // @[:@3225.4]
  input  [1:0]  io_dbus_st_type, // @[:@3225.4]
  input  [2:0]  io_dbus_ld_type, // @[:@3225.4]
  output        io_dbus_valid, // @[:@3225.4]
  output [15:0] io_wbm_m2s_addr, // @[:@3225.4]
  output [31:0] io_wbm_m2s_data, // @[:@3225.4]
  output        io_wbm_m2s_we, // @[:@3225.4]
  output [3:0]  io_wbm_m2s_sel, // @[:@3225.4]
  output        io_wbm_m2s_stb, // @[:@3225.4]
  input         io_wbm_ack_i, // @[:@3225.4]
  input  [31:0] io_wbm_data_i // @[:@3225.4]
);
  wire  _T_39; // @[wbm_dbus.scala 35:19:@3229.4]
  wire  _T_40; // @[wbm_dbus.scala 38:26:@3234.6]
  wire  _T_41; // @[wbm_dbus.scala 41:26:@3239.8]
  wire [3:0] _GEN_0; // @[wbm_dbus.scala 41:46:@3240.8]
  wire [3:0] _GEN_1; // @[wbm_dbus.scala 38:47:@3235.6]
  wire [3:0] st_sel_vec; // @[wbm_dbus.scala 35:40:@3230.4]
  wire [1:0] ld_align; // @[wbm_dbus.scala 46:30:@3243.4]
  wire  _T_44; // @[wbm_dbus.scala 51:16:@3246.4]
  wire  _T_45; // @[wbm_dbus.scala 54:23:@3251.6]
  wire  _T_46; // @[wbm_dbus.scala 54:54:@3252.6]
  wire  _T_47; // @[wbm_dbus.scala 54:43:@3253.6]
  wire  _T_48; // @[wbm_dbus.scala 55:34:@3255.8]
  wire [3:0] _T_49; // @[wbm_dbus.scala 55:25:@3256.8]
  wire  _T_50; // @[wbm_dbus.scala 57:23:@3260.8]
  wire  _T_51; // @[wbm_dbus.scala 57:54:@3261.8]
  wire  _T_52; // @[wbm_dbus.scala 57:43:@3262.8]
  wire  _T_54; // @[wbm_dbus.scala 58:21:@3264.10]
  wire  _T_56; // @[wbm_dbus.scala 60:27:@3269.12]
  wire  _T_58; // @[wbm_dbus.scala 62:27:@3274.14]
  wire [3:0] _GEN_3; // @[wbm_dbus.scala 62:37:@3275.14]
  wire [3:0] _GEN_4; // @[wbm_dbus.scala 60:37:@3270.12]
  wire [3:0] _GEN_5; // @[wbm_dbus.scala 58:32:@3265.10]
  wire [3:0] _GEN_6; // @[wbm_dbus.scala 57:75:@3263.8]
  wire [3:0] _GEN_7; // @[wbm_dbus.scala 54:76:@3254.6]
  wire [3:0] ld_sel_vec; // @[wbm_dbus.scala 51:37:@3247.4]
  wire  _T_61; // @[wbm_dbus.scala 74:37:@3286.4]
  assign _T_39 = io_dbus_st_type == 2'h1; // @[wbm_dbus.scala 35:19:@3229.4]
  assign _T_40 = io_dbus_st_type == 2'h2; // @[wbm_dbus.scala 38:26:@3234.6]
  assign _T_41 = io_dbus_st_type == 2'h3; // @[wbm_dbus.scala 41:26:@3239.8]
  assign _GEN_0 = _T_41 ? 4'h1 : 4'h0; // @[wbm_dbus.scala 41:46:@3240.8]
  assign _GEN_1 = _T_40 ? 4'h3 : _GEN_0; // @[wbm_dbus.scala 38:47:@3235.6]
  assign st_sel_vec = _T_39 ? 4'hf : _GEN_1; // @[wbm_dbus.scala 35:40:@3230.4]
  assign ld_align = io_dbus_addr[1:0]; // @[wbm_dbus.scala 46:30:@3243.4]
  assign _T_44 = io_dbus_ld_type == 3'h1; // @[wbm_dbus.scala 51:16:@3246.4]
  assign _T_45 = io_dbus_ld_type == 3'h2; // @[wbm_dbus.scala 54:23:@3251.6]
  assign _T_46 = io_dbus_ld_type == 3'h4; // @[wbm_dbus.scala 54:54:@3252.6]
  assign _T_47 = _T_45 | _T_46; // @[wbm_dbus.scala 54:43:@3253.6]
  assign _T_48 = ld_align[1]; // @[wbm_dbus.scala 55:34:@3255.8]
  assign _T_49 = _T_48 ? 4'hc : 4'h3; // @[wbm_dbus.scala 55:25:@3256.8]
  assign _T_50 = io_dbus_ld_type == 3'h3; // @[wbm_dbus.scala 57:23:@3260.8]
  assign _T_51 = io_dbus_ld_type == 3'h5; // @[wbm_dbus.scala 57:54:@3261.8]
  assign _T_52 = _T_50 | _T_51; // @[wbm_dbus.scala 57:43:@3262.8]
  assign _T_54 = ld_align == 2'h3; // @[wbm_dbus.scala 58:21:@3264.10]
  assign _T_56 = ld_align == 2'h2; // @[wbm_dbus.scala 60:27:@3269.12]
  assign _T_58 = ld_align == 2'h1; // @[wbm_dbus.scala 62:27:@3274.14]
  assign _GEN_3 = _T_58 ? 4'h2 : 4'h1; // @[wbm_dbus.scala 62:37:@3275.14]
  assign _GEN_4 = _T_56 ? 4'h4 : _GEN_3; // @[wbm_dbus.scala 60:37:@3270.12]
  assign _GEN_5 = _T_54 ? 4'h8 : _GEN_4; // @[wbm_dbus.scala 58:32:@3265.10]
  assign _GEN_6 = _T_52 ? _GEN_5 : 4'h0; // @[wbm_dbus.scala 57:75:@3263.8]
  assign _GEN_7 = _T_47 ? _T_49 : _GEN_6; // @[wbm_dbus.scala 54:76:@3254.6]
  assign ld_sel_vec = _T_44 ? 4'hf : _GEN_7; // @[wbm_dbus.scala 51:37:@3247.4]
  assign _T_61 = io_dbus_st_type != 2'h0; // @[wbm_dbus.scala 74:37:@3286.4]
  assign io_dbus_rdata = io_wbm_data_i; // @[wbm_dbus.scala 78:19:@3294.4]
  assign io_dbus_valid = io_wbm_ack_i; // @[wbm_dbus.scala 79:19:@3295.4]
  assign io_wbm_m2s_addr = io_dbus_addr[15:0]; // @[wbm_dbus.scala 71:19:@3283.4]
  assign io_wbm_m2s_data = io_dbus_wdata; // @[wbm_dbus.scala 72:19:@3284.4]
  assign io_wbm_m2s_we = io_dbus_wr_en; // @[wbm_dbus.scala 73:19:@3285.4]
  assign io_wbm_m2s_sel = _T_61 ? st_sel_vec : ld_sel_vec; // @[wbm_dbus.scala 74:19:@3288.4]
  assign io_wbm_m2s_stb = io_dbus_rd_en | io_dbus_wr_en; // @[wbm_dbus.scala 75:19:@3292.4]
endmodule
module UARTTx( // @[:@3297.2]
  input        clock, // @[:@3298.4]
  input        reset, // @[:@3299.4]
  output       io_in_ready, // @[:@3300.4]
  input        io_in_valid, // @[:@3300.4]
  input  [7:0] io_in_bits, // @[:@3300.4]
  output       io_out, // @[:@3300.4]
  input  [9:0] io_div // @[:@3300.4]
);
  reg [9:0] prescaler; // @[uart_tx.scala 23:26:@3302.4]
  reg [31:0] _RAND_0;
  wire  pulse; // @[uart_tx.scala 24:30:@3303.4]
  reg [3:0] counter; // @[uart_tx.scala 27:26:@3304.4]
  reg [31:0] _RAND_1;
  reg [8:0] shifter; // @[uart_tx.scala 28:22:@3305.4]
  reg [31:0] _RAND_2;
  reg  out; // @[uart_tx.scala 29:26:@3306.4]
  reg [31:0] _RAND_3;
  wire  busy; // @[uart_tx.scala 32:28:@3308.4]
  wire  _T_33; // @[uart_tx.scala 33:34:@3309.4]
  wire  state1; // @[uart_tx.scala 33:31:@3310.4]
  wire [8:0] _T_37; // @[Cat.scala 30:58:@3314.6]
  wire [8:0] _GEN_0; // @[uart_tx.scala 37:16:@3313.4]
  wire [3:0] _GEN_1; // @[uart_tx.scala 37:16:@3313.4]
  wire [10:0] _T_53; // @[uart_tx.scala 45:37:@3326.6]
  wire [10:0] _T_54; // @[uart_tx.scala 45:37:@3327.6]
  wire [9:0] _T_55; // @[uart_tx.scala 45:37:@3328.6]
  wire [10:0] _T_57; // @[uart_tx.scala 45:55:@3329.6]
  wire [10:0] _T_58; // @[uart_tx.scala 45:55:@3330.6]
  wire [9:0] _T_59; // @[uart_tx.scala 45:55:@3331.6]
  wire [9:0] _T_60; // @[uart_tx.scala 45:21:@3332.6]
  wire [4:0] _T_62; // @[uart_tx.scala 48:26:@3335.8]
  wire [4:0] _T_63; // @[uart_tx.scala 48:26:@3336.8]
  wire [3:0] _T_64; // @[uart_tx.scala 48:26:@3337.8]
  wire [7:0] _T_66; // @[uart_tx.scala 49:38:@3339.8]
  wire [8:0] _T_67; // @[Cat.scala 30:58:@3340.8]
  wire  _T_68; // @[uart_tx.scala 50:25:@3342.8]
  wire [3:0] _GEN_2; // @[uart_tx.scala 47:17:@3334.6]
  wire [8:0] _GEN_3; // @[uart_tx.scala 47:17:@3334.6]
  wire  _GEN_4; // @[uart_tx.scala 47:17:@3334.6]
  wire [9:0] _GEN_5; // @[uart_tx.scala 44:16:@3325.4]
  wire [3:0] _GEN_6; // @[uart_tx.scala 44:16:@3325.4]
  wire  _GEN_8; // @[uart_tx.scala 44:16:@3325.4]
  assign pulse = prescaler == 10'h0; // @[uart_tx.scala 24:30:@3303.4]
  assign busy = counter != 4'h0; // @[uart_tx.scala 32:28:@3308.4]
  assign _T_33 = busy == 1'h0; // @[uart_tx.scala 33:34:@3309.4]
  assign state1 = io_in_valid & _T_33; // @[uart_tx.scala 33:31:@3310.4]
  assign _T_37 = {io_in_bits,1'h0}; // @[Cat.scala 30:58:@3314.6]
  assign _GEN_0 = state1 ? _T_37 : shifter; // @[uart_tx.scala 37:16:@3313.4]
  assign _GEN_1 = state1 ? 4'hb : counter; // @[uart_tx.scala 37:16:@3313.4]
  assign _T_53 = io_div - 10'h1; // @[uart_tx.scala 45:37:@3326.6]
  assign _T_54 = $unsigned(_T_53); // @[uart_tx.scala 45:37:@3327.6]
  assign _T_55 = _T_54[9:0]; // @[uart_tx.scala 45:37:@3328.6]
  assign _T_57 = prescaler - 10'h1; // @[uart_tx.scala 45:55:@3329.6]
  assign _T_58 = $unsigned(_T_57); // @[uart_tx.scala 45:55:@3330.6]
  assign _T_59 = _T_58[9:0]; // @[uart_tx.scala 45:55:@3331.6]
  assign _T_60 = pulse ? _T_55 : _T_59; // @[uart_tx.scala 45:21:@3332.6]
  assign _T_62 = counter - 4'h1; // @[uart_tx.scala 48:26:@3335.8]
  assign _T_63 = $unsigned(_T_62); // @[uart_tx.scala 48:26:@3336.8]
  assign _T_64 = _T_63[3:0]; // @[uart_tx.scala 48:26:@3337.8]
  assign _T_66 = shifter[8:1]; // @[uart_tx.scala 49:38:@3339.8]
  assign _T_67 = {1'h1,_T_66}; // @[Cat.scala 30:58:@3340.8]
  assign _T_68 = shifter[0]; // @[uart_tx.scala 50:25:@3342.8]
  assign _GEN_2 = pulse ? _T_64 : _GEN_1; // @[uart_tx.scala 47:17:@3334.6]
  assign _GEN_3 = pulse ? _T_67 : _GEN_0; // @[uart_tx.scala 47:17:@3334.6]
  assign _GEN_4 = pulse ? _T_68 : out; // @[uart_tx.scala 47:17:@3334.6]
  assign _GEN_5 = busy ? _T_60 : prescaler; // @[uart_tx.scala 44:16:@3325.4]
  assign _GEN_6 = busy ? _GEN_2 : _GEN_1; // @[uart_tx.scala 44:16:@3325.4]
  assign _GEN_8 = busy ? _GEN_4 : out; // @[uart_tx.scala 44:16:@3325.4]
  assign io_in_ready = busy == 1'h0; // @[uart_tx.scala 35:17:@3312.4]
  assign io_out = out; // @[uart_tx.scala 30:17:@3307.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  prescaler = _RAND_0[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  counter = _RAND_1[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  shifter = _RAND_2[8:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  out = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      prescaler <= 10'h0;
    end else begin
      if (busy) begin
        if (pulse) begin
          prescaler <= _T_55;
        end else begin
          prescaler <= _T_59;
        end
      end
    end
    if (reset) begin
      counter <= 4'h0;
    end else begin
      if (busy) begin
        if (pulse) begin
          counter <= _T_64;
        end else begin
          if (state1) begin
            counter <= 4'hb;
          end
        end
      end else begin
        if (state1) begin
          counter <= 4'hb;
        end
      end
    end
    if (busy) begin
      if (pulse) begin
        shifter <= _T_67;
      end else begin
        if (state1) begin
          shifter <= _T_37;
        end
      end
    end else begin
      if (state1) begin
        shifter <= _T_37;
      end
    end
    if (reset) begin
      out <= 1'h1;
    end else begin
      if (busy) begin
        if (pulse) begin
          out <= _T_68;
        end
      end
    end
  end
endmodule
module UARTRx( // @[:@3347.2]
  input        clock, // @[:@3348.4]
  input        reset, // @[:@3349.4]
  input        io_in, // @[:@3350.4]
  output       io_out_valid, // @[:@3350.4]
  output [7:0] io_out_bits, // @[:@3350.4]
  input  [9:0] io_div // @[:@3350.4]
);
  reg [3:0] data_count; // @[uart_rx.scala 23:34:@3352.4]
  reg [31:0] _RAND_0;
  wire  data_last; // @[uart_rx.scala 24:43:@3353.4]
  reg [9:0] prescaler; // @[uart_rx.scala 27:38:@3354.4]
  reg [31:0] _RAND_1;
  wire  pulse; // @[uart_rx.scala 28:42:@3355.4]
  wire [10:0] _T_19; // @[uart_rx.scala 29:50:@3356.4]
  wire [10:0] _T_20; // @[uart_rx.scala 29:50:@3357.4]
  wire [9:0] _T_21; // @[uart_rx.scala 29:50:@3358.4]
  wire [10:0] _T_23; // @[uart_rx.scala 29:68:@3359.4]
  wire [10:0] _T_24; // @[uart_rx.scala 29:68:@3360.4]
  wire [9:0] _T_25; // @[uart_rx.scala 29:68:@3361.4]
  wire [9:0] prescaler_next; // @[uart_rx.scala 29:34:@3362.4]
  reg [8:0] debounce; // @[uart_rx.scala 32:38:@3363.4]
  reg [31:0] _RAND_2;
  wire [9:0] _T_29; // @[uart_rx.scala 33:52:@3364.4]
  wire [9:0] _GEN_28; // @[uart_rx.scala 33:41:@3365.4]
  wire  debounce_max; // @[uart_rx.scala 33:41:@3365.4]
  reg [7:0] shifter; // @[uart_rx.scala 36:27:@3366.4]
  reg [31:0] _RAND_3;
  reg  valid; // @[uart_rx.scala 37:23:@3367.4]
  reg [31:0] _RAND_4;
  reg  state; // @[uart_rx.scala 44:27:@3371.4]
  reg [31:0] _RAND_5;
  wire  _T_35; // @[Conditional.scala 37:30:@3372.4]
  wire  _T_37; // @[uart_rx.scala 48:13:@3374.6]
  wire [9:0] _T_39; // @[uart_rx.scala 50:30:@3376.8]
  wire [8:0] _T_40; // @[uart_rx.scala 50:30:@3377.8]
  wire  _GEN_0; // @[uart_rx.scala 51:29:@3379.8]
  wire [3:0] _GEN_1; // @[uart_rx.scala 51:29:@3379.8]
  wire [9:0] _GEN_2; // @[uart_rx.scala 51:29:@3379.8]
  wire [8:0] _GEN_3; // @[uart_rx.scala 48:21:@3375.6]
  wire  _GEN_4; // @[uart_rx.scala 48:21:@3375.6]
  wire [3:0] _GEN_5; // @[uart_rx.scala 48:21:@3375.6]
  wire [9:0] _GEN_6; // @[uart_rx.scala 48:21:@3375.6]
  wire [4:0] _T_44; // @[uart_rx.scala 62:34:@3391.10]
  wire [4:0] _T_45; // @[uart_rx.scala 62:34:@3392.10]
  wire [3:0] _T_46; // @[uart_rx.scala 62:34:@3393.10]
  wire [6:0] _T_49; // @[uart_rx.scala 70:44:@3401.12]
  wire [7:0] _T_50; // @[Cat.scala 30:58:@3402.12]
  wire  _GEN_7; // @[uart_rx.scala 64:26:@3395.10]
  wire [8:0] _GEN_9; // @[uart_rx.scala 64:26:@3395.10]
  wire [7:0] _GEN_10; // @[uart_rx.scala 64:26:@3395.10]
  wire [3:0] _GEN_11; // @[uart_rx.scala 61:20:@3390.8]
  wire  _GEN_12; // @[uart_rx.scala 61:20:@3390.8]
  wire  _GEN_13; // @[uart_rx.scala 61:20:@3390.8]
  wire [8:0] _GEN_14; // @[uart_rx.scala 61:20:@3390.8]
  wire [7:0] _GEN_15; // @[uart_rx.scala 61:20:@3390.8]
  wire [9:0] _GEN_16; // @[Conditional.scala 39:67:@3388.6]
  wire [3:0] _GEN_17; // @[Conditional.scala 39:67:@3388.6]
  wire  _GEN_18; // @[Conditional.scala 39:67:@3388.6]
  wire  _GEN_19; // @[Conditional.scala 39:67:@3388.6]
  wire [8:0] _GEN_20; // @[Conditional.scala 39:67:@3388.6]
  wire [7:0] _GEN_21; // @[Conditional.scala 39:67:@3388.6]
  wire [8:0] _GEN_22; // @[Conditional.scala 40:58:@3373.4]
  wire  _GEN_23; // @[Conditional.scala 40:58:@3373.4]
  wire [9:0] _GEN_25; // @[Conditional.scala 40:58:@3373.4]
  wire [7:0] _GEN_27; // @[Conditional.scala 40:58:@3373.4]
  assign data_last = data_count == 4'h0; // @[uart_rx.scala 24:43:@3353.4]
  assign pulse = prescaler == 10'h0; // @[uart_rx.scala 28:42:@3355.4]
  assign _T_19 = io_div - 10'h1; // @[uart_rx.scala 29:50:@3356.4]
  assign _T_20 = $unsigned(_T_19); // @[uart_rx.scala 29:50:@3357.4]
  assign _T_21 = _T_20[9:0]; // @[uart_rx.scala 29:50:@3358.4]
  assign _T_23 = prescaler - 10'h1; // @[uart_rx.scala 29:68:@3359.4]
  assign _T_24 = $unsigned(_T_23); // @[uart_rx.scala 29:68:@3360.4]
  assign _T_25 = _T_24[9:0]; // @[uart_rx.scala 29:68:@3361.4]
  assign prescaler_next = pulse ? _T_21 : _T_25; // @[uart_rx.scala 29:34:@3362.4]
  assign _T_29 = io_div / 10'h2; // @[uart_rx.scala 33:52:@3364.4]
  assign _GEN_28 = {{1'd0}, debounce}; // @[uart_rx.scala 33:41:@3365.4]
  assign debounce_max = _GEN_28 == _T_29; // @[uart_rx.scala 33:41:@3365.4]
  assign _T_35 = 1'h0 == state; // @[Conditional.scala 37:30:@3372.4]
  assign _T_37 = io_in == 1'h0; // @[uart_rx.scala 48:13:@3374.6]
  assign _T_39 = debounce + 9'h1; // @[uart_rx.scala 50:30:@3376.8]
  assign _T_40 = debounce + 9'h1; // @[uart_rx.scala 50:30:@3377.8]
  assign _GEN_0 = debounce_max ? 1'h1 : state; // @[uart_rx.scala 51:29:@3379.8]
  assign _GEN_1 = debounce_max ? 4'h8 : data_count; // @[uart_rx.scala 51:29:@3379.8]
  assign _GEN_2 = debounce_max ? prescaler_next : prescaler; // @[uart_rx.scala 51:29:@3379.8]
  assign _GEN_3 = _T_37 ? _T_40 : debounce; // @[uart_rx.scala 48:21:@3375.6]
  assign _GEN_4 = _T_37 ? _GEN_0 : state; // @[uart_rx.scala 48:21:@3375.6]
  assign _GEN_5 = _T_37 ? _GEN_1 : data_count; // @[uart_rx.scala 48:21:@3375.6]
  assign _GEN_6 = _T_37 ? _GEN_2 : prescaler; // @[uart_rx.scala 48:21:@3375.6]
  assign _T_44 = data_count - 4'h1; // @[uart_rx.scala 62:34:@3391.10]
  assign _T_45 = $unsigned(_T_44); // @[uart_rx.scala 62:34:@3392.10]
  assign _T_46 = _T_45[3:0]; // @[uart_rx.scala 62:34:@3393.10]
  assign _T_49 = shifter[7:1]; // @[uart_rx.scala 70:44:@3401.12]
  assign _T_50 = {io_in,_T_49}; // @[Cat.scala 30:58:@3402.12]
  assign _GEN_7 = data_last ? 1'h0 : state; // @[uart_rx.scala 64:26:@3395.10]
  assign _GEN_9 = data_last ? 9'h0 : debounce; // @[uart_rx.scala 64:26:@3395.10]
  assign _GEN_10 = data_last ? shifter : _T_50; // @[uart_rx.scala 64:26:@3395.10]
  assign _GEN_11 = pulse ? _T_46 : data_count; // @[uart_rx.scala 61:20:@3390.8]
  assign _GEN_12 = pulse ? _GEN_7 : state; // @[uart_rx.scala 61:20:@3390.8]
  assign _GEN_13 = pulse ? data_last : 1'h0; // @[uart_rx.scala 61:20:@3390.8]
  assign _GEN_14 = pulse ? _GEN_9 : debounce; // @[uart_rx.scala 61:20:@3390.8]
  assign _GEN_15 = pulse ? _GEN_10 : shifter; // @[uart_rx.scala 61:20:@3390.8]
  assign _GEN_16 = state ? prescaler_next : prescaler; // @[Conditional.scala 39:67:@3388.6]
  assign _GEN_17 = state ? _GEN_11 : data_count; // @[Conditional.scala 39:67:@3388.6]
  assign _GEN_18 = state ? _GEN_12 : state; // @[Conditional.scala 39:67:@3388.6]
  assign _GEN_19 = state ? _GEN_13 : 1'h0; // @[Conditional.scala 39:67:@3388.6]
  assign _GEN_20 = state ? _GEN_14 : debounce; // @[Conditional.scala 39:67:@3388.6]
  assign _GEN_21 = state ? _GEN_15 : shifter; // @[Conditional.scala 39:67:@3388.6]
  assign _GEN_22 = _T_35 ? _GEN_3 : _GEN_20; // @[Conditional.scala 40:58:@3373.4]
  assign _GEN_23 = _T_35 ? _GEN_4 : _GEN_18; // @[Conditional.scala 40:58:@3373.4]
  assign _GEN_25 = _T_35 ? _GEN_6 : _GEN_16; // @[Conditional.scala 40:58:@3373.4]
  assign _GEN_27 = _T_35 ? shifter : _GEN_21; // @[Conditional.scala 40:58:@3373.4]
  assign io_out_valid = valid; // @[uart_rx.scala 39:18:@3369.4]
  assign io_out_bits = shifter; // @[uart_rx.scala 40:18:@3370.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  data_count = _RAND_0[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  prescaler = _RAND_1[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  debounce = _RAND_2[8:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  shifter = _RAND_3[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  valid = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  state = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (_T_35) begin
      if (_T_37) begin
        if (debounce_max) begin
          data_count <= 4'h8;
        end
      end
    end else begin
      if (state) begin
        if (pulse) begin
          data_count <= _T_46;
        end
      end
    end
    if (reset) begin
      prescaler <= 10'h0;
    end else begin
      if (_T_35) begin
        if (_T_37) begin
          if (debounce_max) begin
            if (pulse) begin
              prescaler <= _T_21;
            end else begin
              prescaler <= _T_25;
            end
          end
        end
      end else begin
        if (state) begin
          if (pulse) begin
            prescaler <= _T_21;
          end else begin
            prescaler <= _T_25;
          end
        end
      end
    end
    if (reset) begin
      debounce <= 9'h0;
    end else begin
      if (_T_35) begin
        if (_T_37) begin
          debounce <= _T_40;
        end
      end else begin
        if (state) begin
          if (pulse) begin
            if (data_last) begin
              debounce <= 9'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      shifter <= 8'h0;
    end else begin
      if (!(_T_35)) begin
        if (state) begin
          if (pulse) begin
            if (!(data_last)) begin
              shifter <= _T_50;
            end
          end
        end
      end
    end
    if (_T_35) begin
      valid <= 1'h0;
    end else begin
      if (state) begin
        if (pulse) begin
          valid <= data_last;
        end else begin
          valid <= 1'h0;
        end
      end else begin
        valid <= 1'h0;
      end
    end
    if (reset) begin
      state <= 1'h0;
    end else begin
      if (_T_35) begin
        if (_T_37) begin
          if (debounce_max) begin
            state <= 1'h1;
          end
        end
      end else begin
        if (state) begin
          if (pulse) begin
            if (data_last) begin
              state <= 1'h0;
            end
          end
        end
      end
    end
  end
endmodule
module UART( // @[:@3408.2]
  input         clock, // @[:@3409.4]
  input         reset, // @[:@3410.4]
  input         io_uart_select, // @[:@3411.4]
  output        io_txd, // @[:@3411.4]
  input         io_rxd, // @[:@3411.4]
  output        io_uartInt, // @[:@3411.4]
  input  [15:0] io_wbs_m2s_addr, // @[:@3411.4]
  input  [31:0] io_wbs_m2s_data, // @[:@3411.4]
  input         io_wbs_m2s_we, // @[:@3411.4]
  input         io_wbs_m2s_stb, // @[:@3411.4]
  output        io_wbs_ack_o, // @[:@3411.4]
  output [31:0] io_wbs_data_o // @[:@3411.4]
);
  wire  txm_clock; // @[uart.scala 53:19:@3413.4]
  wire  txm_reset; // @[uart.scala 53:19:@3413.4]
  wire  txm_io_in_ready; // @[uart.scala 53:19:@3413.4]
  wire  txm_io_in_valid; // @[uart.scala 53:19:@3413.4]
  wire [7:0] txm_io_in_bits; // @[uart.scala 53:19:@3413.4]
  wire  txm_io_out; // @[uart.scala 53:19:@3413.4]
  wire [9:0] txm_io_div; // @[uart.scala 53:19:@3413.4]
  wire  rxm_clock; // @[uart.scala 54:19:@3416.4]
  wire  rxm_reset; // @[uart.scala 54:19:@3416.4]
  wire  rxm_io_in; // @[uart.scala 54:19:@3416.4]
  wire  rxm_io_out_valid; // @[uart.scala 54:19:@3416.4]
  wire [7:0] rxm_io_out_bits; // @[uart.scala 54:19:@3416.4]
  wire [9:0] rxm_io_div; // @[uart.scala 54:19:@3416.4]
  reg  txen; // @[uart.scala 57:27:@3419.4]
  reg [31:0] _RAND_0;
  reg [7:0] tx_data_r; // @[uart.scala 60:27:@3421.4]
  reg [31:0] _RAND_1;
  reg [7:0] rx_data_r; // @[uart.scala 61:27:@3422.4]
  reg [31:0] _RAND_2;
  reg [7:0] control_r; // @[uart.scala 62:27:@3423.4]
  reg [31:0] _RAND_3;
  reg [9:0] baud_r; // @[uart.scala 63:27:@3424.4]
  reg [31:0] _RAND_4;
  reg [7:0] status_r; // @[uart.scala 64:27:@3425.4]
  reg [31:0] _RAND_5;
  reg [7:0] int_mask_r; // @[uart.scala 65:27:@3426.4]
  reg [31:0] _RAND_6;
  wire [7:0] addr; // @[uart.scala 85:36:@3436.4]
  wire  _T_63; // @[uart.scala 86:21:@3437.4]
  wire  rd_en; // @[uart.scala 86:36:@3438.4]
  wire  wr_en; // @[uart.scala 87:35:@3439.4]
  wire  _T_70; // @[uart.scala 91:32:@3440.4]
  wire  sel_reg_rx; // @[uart.scala 91:56:@3441.4]
  wire  _T_71; // @[uart.scala 92:32:@3442.4]
  wire  sel_reg_tx; // @[uart.scala 92:56:@3443.4]
  wire  _T_72; // @[uart.scala 93:32:@3444.4]
  wire  sel_reg_baud; // @[uart.scala 93:54:@3445.4]
  wire  _T_73; // @[uart.scala 94:32:@3446.4]
  wire  sel_reg_control; // @[uart.scala 94:57:@3447.4]
  wire  _T_74; // @[uart.scala 95:32:@3448.4]
  wire  sel_reg_status; // @[uart.scala 95:56:@3449.4]
  wire  _T_75; // @[uart.scala 96:32:@3450.4]
  wire  sel_reg_int_mask; // @[uart.scala 96:58:@3451.4]
  reg  ack; // @[uart.scala 99:28:@3452.4]
  reg [31:0] _RAND_7;
  reg [7:0] rd_data; // @[uart.scala 104:28:@3456.4]
  reg [31:0] _RAND_8;
  wire  _T_81; // @[uart.scala 106:14:@3457.4]
  wire  _T_82; // @[uart.scala 108:20:@3462.6]
  wire  _T_83; // @[uart.scala 110:20:@3467.8]
  wire  _T_84; // @[uart.scala 112:20:@3472.10]
  wire [7:0] _GEN_0; // @[uart.scala 112:34:@3473.10]
  wire [7:0] _GEN_1; // @[uart.scala 110:38:@3468.8]
  wire [9:0] _GEN_2; // @[uart.scala 108:36:@3463.6]
  wire [9:0] _GEN_3; // @[uart.scala 106:33:@3458.4]
  wire [7:0] _T_86; // @[uart.scala 120:31:@3480.4]
  wire [7:0] _T_89; // @[uart.scala 125:36:@3485.8]
  wire [7:0] _GEN_4; // @[uart.scala 134:32:@3500.12]
  wire [7:0] _GEN_5; // @[uart.scala 131:31:@3495.10]
  wire [7:0] _GEN_6; // @[uart.scala 131:31:@3495.10]
  wire [9:0] _GEN_7; // @[uart.scala 128:29:@3490.8]
  wire [7:0] _GEN_8; // @[uart.scala 128:29:@3490.8]
  wire [7:0] _GEN_9; // @[uart.scala 128:29:@3490.8]
  wire [7:0] _GEN_10; // @[uart.scala 124:22:@3484.6]
  wire [9:0] _GEN_12; // @[uart.scala 124:22:@3484.6]
  wire [7:0] _GEN_13; // @[uart.scala 124:22:@3484.6]
  wire [7:0] _GEN_14; // @[uart.scala 124:22:@3484.6]
  wire [7:0] _GEN_15; // @[uart.scala 123:15:@3483.4]
  wire  _GEN_16; // @[uart.scala 123:15:@3483.4]
  wire [9:0] _GEN_17; // @[uart.scala 123:15:@3483.4]
  wire [7:0] _GEN_18; // @[uart.scala 123:15:@3483.4]
  wire [7:0] _GEN_19; // @[uart.scala 123:15:@3483.4]
  wire [6:0] _T_94; // @[uart.scala 142:33:@3507.6]
  wire [7:0] _T_96; // @[Cat.scala 30:58:@3508.6]
  wire  _T_97; // @[uart.scala 143:20:@3512.6]
  wire [5:0] _T_99; // @[uart.scala 146:33:@3518.8]
  wire  _T_100; // @[uart.scala 146:65:@3519.8]
  wire [7:0] _T_102; // @[Cat.scala 30:58:@3521.8]
  wire [7:0] _GEN_20; // @[uart.scala 143:38:@3513.6]
  wire [7:0] _GEN_21; // @[uart.scala 140:25:@3505.4]
  wire [7:0] _GEN_22; // @[uart.scala 140:25:@3505.4]
  UARTTx txm ( // @[uart.scala 53:19:@3413.4]
    .clock(txm_clock),
    .reset(txm_reset),
    .io_in_ready(txm_io_in_ready),
    .io_in_valid(txm_io_in_valid),
    .io_in_bits(txm_io_in_bits),
    .io_out(txm_io_out),
    .io_div(txm_io_div)
  );
  UARTRx rxm ( // @[uart.scala 54:19:@3416.4]
    .clock(rxm_clock),
    .reset(rxm_reset),
    .io_in(rxm_io_in),
    .io_out_valid(rxm_io_out_valid),
    .io_out_bits(rxm_io_out_bits),
    .io_div(rxm_io_div)
  );
  assign addr = io_wbs_m2s_addr[7:0]; // @[uart.scala 85:36:@3436.4]
  assign _T_63 = io_wbs_m2s_we == 1'h0; // @[uart.scala 86:21:@3437.4]
  assign rd_en = _T_63 & io_wbs_m2s_stb; // @[uart.scala 86:36:@3438.4]
  assign wr_en = io_wbs_m2s_we & io_wbs_m2s_stb; // @[uart.scala 87:35:@3439.4]
  assign _T_70 = addr == 8'h0; // @[uart.scala 91:32:@3440.4]
  assign sel_reg_rx = _T_70 & io_uart_select; // @[uart.scala 91:56:@3441.4]
  assign _T_71 = addr == 8'h1; // @[uart.scala 92:32:@3442.4]
  assign sel_reg_tx = _T_71 & io_uart_select; // @[uart.scala 92:56:@3443.4]
  assign _T_72 = addr == 8'h2; // @[uart.scala 93:32:@3444.4]
  assign sel_reg_baud = _T_72 & io_uart_select; // @[uart.scala 93:54:@3445.4]
  assign _T_73 = addr == 8'h3; // @[uart.scala 94:32:@3446.4]
  assign sel_reg_control = _T_73 & io_uart_select; // @[uart.scala 94:57:@3447.4]
  assign _T_74 = addr == 8'h4; // @[uart.scala 95:32:@3448.4]
  assign sel_reg_status = _T_74 & io_uart_select; // @[uart.scala 95:56:@3449.4]
  assign _T_75 = addr == 8'h5; // @[uart.scala 96:32:@3450.4]
  assign sel_reg_int_mask = _T_75 & io_uart_select; // @[uart.scala 96:58:@3451.4]
  assign _T_81 = rd_en & sel_reg_control; // @[uart.scala 106:14:@3457.4]
  assign _T_82 = rd_en & sel_reg_baud; // @[uart.scala 108:20:@3462.6]
  assign _T_83 = rd_en & sel_reg_status; // @[uart.scala 110:20:@3467.8]
  assign _T_84 = rd_en & sel_reg_rx; // @[uart.scala 112:20:@3472.10]
  assign _GEN_0 = _T_84 ? rx_data_r : 8'h0; // @[uart.scala 112:34:@3473.10]
  assign _GEN_1 = _T_83 ? status_r : _GEN_0; // @[uart.scala 110:38:@3468.8]
  assign _GEN_2 = _T_82 ? baud_r : {{2'd0}, _GEN_1}; // @[uart.scala 108:36:@3463.6]
  assign _GEN_3 = _T_81 ? {{2'd0}, control_r} : _GEN_2; // @[uart.scala 106:33:@3458.4]
  assign _T_86 = status_r & int_mask_r; // @[uart.scala 120:31:@3480.4]
  assign _T_89 = io_wbs_m2s_data[7:0]; // @[uart.scala 125:36:@3485.8]
  assign _GEN_4 = sel_reg_int_mask ? _T_89 : int_mask_r; // @[uart.scala 134:32:@3500.12]
  assign _GEN_5 = sel_reg_control ? _T_89 : control_r; // @[uart.scala 131:31:@3495.10]
  assign _GEN_6 = sel_reg_control ? int_mask_r : _GEN_4; // @[uart.scala 131:31:@3495.10]
  assign _GEN_7 = sel_reg_baud ? {{2'd0}, _T_89} : baud_r; // @[uart.scala 128:29:@3490.8]
  assign _GEN_8 = sel_reg_baud ? control_r : _GEN_5; // @[uart.scala 128:29:@3490.8]
  assign _GEN_9 = sel_reg_baud ? int_mask_r : _GEN_6; // @[uart.scala 128:29:@3490.8]
  assign _GEN_10 = sel_reg_tx ? _T_89 : tx_data_r; // @[uart.scala 124:22:@3484.6]
  assign _GEN_12 = sel_reg_tx ? baud_r : _GEN_7; // @[uart.scala 124:22:@3484.6]
  assign _GEN_13 = sel_reg_tx ? control_r : _GEN_8; // @[uart.scala 124:22:@3484.6]
  assign _GEN_14 = sel_reg_tx ? int_mask_r : _GEN_9; // @[uart.scala 124:22:@3484.6]
  assign _GEN_15 = wr_en ? _GEN_10 : tx_data_r; // @[uart.scala 123:15:@3483.4]
  assign _GEN_16 = wr_en ? sel_reg_tx : 1'h0; // @[uart.scala 123:15:@3483.4]
  assign _GEN_17 = wr_en ? _GEN_12 : baud_r; // @[uart.scala 123:15:@3483.4]
  assign _GEN_18 = wr_en ? _GEN_13 : control_r; // @[uart.scala 123:15:@3483.4]
  assign _GEN_19 = wr_en ? _GEN_14 : int_mask_r; // @[uart.scala 123:15:@3483.4]
  assign _T_94 = status_r[7:1]; // @[uart.scala 142:33:@3507.6]
  assign _T_96 = {_T_94,1'h1}; // @[Cat.scala 30:58:@3508.6]
  assign _T_97 = wr_en & sel_reg_status; // @[uart.scala 143:20:@3512.6]
  assign _T_99 = status_r[7:2]; // @[uart.scala 146:33:@3518.8]
  assign _T_100 = status_r[0]; // @[uart.scala 146:65:@3519.8]
  assign _T_102 = {_T_99,txm_io_in_ready,_T_100}; // @[Cat.scala 30:58:@3521.8]
  assign _GEN_20 = _T_97 ? _T_89 : _T_102; // @[uart.scala 143:38:@3513.6]
  assign _GEN_21 = rxm_io_out_valid ? rxm_io_out_bits : rx_data_r; // @[uart.scala 140:25:@3505.4]
  assign _GEN_22 = rxm_io_out_valid ? _T_96 : _GEN_20; // @[uart.scala 140:25:@3505.4]
  assign io_txd = txm_io_out; // @[uart.scala 82:19:@3435.4]
  assign io_uartInt = _T_86 != 8'h0; // @[uart.scala 120:18:@3482.4]
  assign io_wbs_ack_o = ack; // @[uart.scala 100:19:@3453.4]
  assign io_wbs_data_o = {{24'd0}, rd_data}; // @[uart.scala 117:18:@3479.4]
  assign txm_clock = clock; // @[:@3414.4]
  assign txm_reset = reset; // @[:@3415.4]
  assign txm_io_in_valid = txen; // @[uart.scala 74:19:@3429.4]
  assign txm_io_in_bits = tx_data_r; // @[uart.scala 75:19:@3430.4]
  assign txm_io_div = baud_r; // @[uart.scala 76:19:@3431.4]
  assign rxm_clock = clock; // @[:@3417.4]
  assign rxm_reset = reset; // @[:@3418.4]
  assign rxm_io_in = io_rxd; // @[uart.scala 81:19:@3434.4]
  assign rxm_io_div = baud_r; // @[uart.scala 78:19:@3433.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  txen = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  tx_data_r = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  rx_data_r = _RAND_2[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  control_r = _RAND_3[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  baud_r = _RAND_4[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  status_r = _RAND_5[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  int_mask_r = _RAND_6[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  ack = _RAND_7[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  rd_data = _RAND_8[7:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      txen <= 1'h0;
    end else begin
      if (wr_en) begin
        txen <= sel_reg_tx;
      end else begin
        txen <= 1'h0;
      end
    end
    if (reset) begin
      tx_data_r <= 8'h4a;
    end else begin
      if (wr_en) begin
        if (sel_reg_tx) begin
          tx_data_r <= _T_89;
        end
      end
    end
    if (reset) begin
      rx_data_r <= 8'h0;
    end else begin
      if (rxm_io_out_valid) begin
        rx_data_r <= rxm_io_out_bits;
      end
    end
    if (reset) begin
      control_r <= 8'h0;
    end else begin
      if (wr_en) begin
        if (!(sel_reg_tx)) begin
          if (!(sel_reg_baud)) begin
            if (sel_reg_control) begin
              control_r <= _T_89;
            end
          end
        end
      end
    end
    if (reset) begin
      baud_r <= 10'h8;
    end else begin
      if (wr_en) begin
        if (!(sel_reg_tx)) begin
          if (sel_reg_baud) begin
            baud_r <= {{2'd0}, _T_89};
          end
        end
      end
    end
    if (reset) begin
      status_r <= 8'h0;
    end else begin
      if (rxm_io_out_valid) begin
        status_r <= _T_96;
      end else begin
        if (_T_97) begin
          status_r <= _T_89;
        end else begin
          status_r <= _T_102;
        end
      end
    end
    if (reset) begin
      int_mask_r <= 8'h1;
    end else begin
      if (wr_en) begin
        if (!(sel_reg_tx)) begin
          if (!(sel_reg_baud)) begin
            if (!(sel_reg_control)) begin
              if (sel_reg_int_mask) begin
                int_mask_r <= _T_89;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      ack <= 1'h0;
    end else begin
      ack <= io_wbs_m2s_stb;
    end
    if (reset) begin
      rd_data <= 8'h0;
    end else begin
      rd_data <= _GEN_3[7:0];
    end
  end
endmodule
module SPI( // @[:@3525.2]
  input         clock, // @[:@3526.4]
  input         reset, // @[:@3527.4]
  input         io_spi_select, // @[:@3528.4]
  output        io_spi_cs, // @[:@3528.4]
  output        io_spi_clk, // @[:@3528.4]
  output        io_spi_mosi, // @[:@3528.4]
  input         io_spi_miso, // @[:@3528.4]
  output        io_spi_intr, // @[:@3528.4]
  input  [15:0] io_wbs_m2s_addr, // @[:@3528.4]
  input  [31:0] io_wbs_m2s_data, // @[:@3528.4]
  input         io_wbs_m2s_we, // @[:@3528.4]
  input         io_wbs_m2s_stb, // @[:@3528.4]
  output        io_wbs_ack_o, // @[:@3528.4]
  output [31:0] io_wbs_data_o // @[:@3528.4]
);
  reg  ack_o; // @[spi.scala 65:25:@3530.4]
  reg [31:0] _RAND_0;
  reg [7:0] rd_data; // @[spi.scala 66:25:@3531.4]
  reg [31:0] _RAND_1;
  reg  sclk_r; // @[spi.scala 69:23:@3533.4]
  reg [31:0] _RAND_2;
  reg  mosi_r; // @[spi.scala 70:23:@3534.4]
  reg [31:0] _RAND_3;
  reg  read_wait_done; // @[spi.scala 75:31:@3541.4]
  reg [31:0] _RAND_4;
  reg [7:0] reg_rxdata; // @[spi.scala 78:28:@3544.4]
  reg [31:0] _RAND_5;
  reg [7:0] reg_txdata; // @[spi.scala 79:28:@3545.4]
  reg [31:0] _RAND_6;
  reg  reg_ssmask; // @[spi.scala 80:28:@3546.4]
  reg [31:0] _RAND_7;
  reg [7:0] rx_shift_data; // @[spi.scala 82:30:@3547.4]
  reg [31:0] _RAND_8;
  reg [7:0] tx_shift_data; // @[spi.scala 83:30:@3548.4]
  reg [31:0] _RAND_9;
  reg  rx_latch_flag; // @[spi.scala 84:30:@3549.4]
  reg [31:0] _RAND_10;
  reg  bit_iroe; // @[spi.scala 87:27:@3550.4]
  reg [31:0] _RAND_11;
  reg  bit_itoe; // @[spi.scala 88:27:@3551.4]
  reg [31:0] _RAND_12;
  reg  bit_itrdy; // @[spi.scala 89:27:@3552.4]
  reg [31:0] _RAND_13;
  reg  bit_irrdy; // @[spi.scala 90:27:@3553.4]
  reg [31:0] _RAND_14;
  reg  bit_ie; // @[spi.scala 91:27:@3554.4]
  reg [31:0] _RAND_15;
  reg  bit_sso; // @[spi.scala 92:27:@3555.4]
  reg [31:0] _RAND_16;
  reg  bit_toe; // @[spi.scala 95:27:@3556.4]
  reg [31:0] _RAND_17;
  reg  bit_roe; // @[spi.scala 96:27:@3557.4]
  reg [31:0] _RAND_18;
  reg  bit_trdy; // @[spi.scala 97:27:@3558.4]
  reg [31:0] _RAND_19;
  reg  bit_rrdy; // @[spi.scala 98:27:@3559.4]
  reg [31:0] _RAND_20;
  reg  bit_tmt; // @[spi.scala 99:27:@3560.4]
  reg [31:0] _RAND_21;
  reg  bit_e; // @[spi.scala 100:27:@3561.4]
  reg [31:0] _RAND_22;
  wire [7:0] addr; // @[spi.scala 106:33:@3562.4]
  wire  _T_104; // @[spi.scala 108:19:@3563.4]
  wire  rd_en; // @[spi.scala 108:34:@3564.4]
  wire  wr_en; // @[spi.scala 109:33:@3567.4]
  wire  _T_115; // @[spi.scala 113:32:@3571.4]
  wire  sel_reg_rx; // @[spi.scala 113:54:@3572.4]
  wire  _T_116; // @[spi.scala 114:32:@3573.4]
  wire  sel_reg_tx; // @[spi.scala 114:54:@3574.4]
  wire  _T_118; // @[spi.scala 116:32:@3577.4]
  wire  sel_reg_control; // @[spi.scala 116:55:@3578.4]
  wire  _T_119; // @[spi.scala 117:32:@3579.4]
  wire  sel_reg_status; // @[spi.scala 117:54:@3580.4]
  wire  _T_120; // @[spi.scala 118:32:@3581.4]
  wire  sel_reg_ssmask; // @[spi.scala 118:55:@3582.4]
  wire [7:0] _GEN_0; // @[spi.scala 121:23:@3583.4]
  wire  _T_121; // @[spi.scala 126:14:@3586.4]
  wire  _T_122; // @[spi.scala 126:28:@3587.4]
  wire [7:0] latch_s_data; // @[:@3542.4 :@3543.4 spi.scala 110:16:@3570.4]
  wire [7:0] _GEN_1; // @[spi.scala 126:41:@3588.4]
  wire  _T_123; // @[spi.scala 131:19:@3591.4]
  wire [7:0] reg_status; // @[Cat.scala 30:58:@3598.4]
  wire [7:0] reg_control; // @[Cat.scala 30:58:@3605.4]
  wire  _T_138; // @[spi.scala 138:14:@3606.4]
  wire  _T_139; // @[spi.scala 139:30:@3608.6]
  wire  _T_140; // @[spi.scala 140:30:@3610.6]
  wire  _T_141; // @[spi.scala 141:30:@3612.6]
  wire  _T_142; // @[spi.scala 142:30:@3614.6]
  wire  _T_143; // @[spi.scala 143:30:@3616.6]
  wire  _T_144; // @[spi.scala 144:30:@3618.6]
  wire  _GEN_2; // @[spi.scala 138:34:@3607.4]
  wire  _GEN_3; // @[spi.scala 138:34:@3607.4]
  wire  _GEN_4; // @[spi.scala 138:34:@3607.4]
  wire  _GEN_5; // @[spi.scala 138:34:@3607.4]
  wire  _GEN_6; // @[spi.scala 138:34:@3607.4]
  wire  _GEN_7; // @[spi.scala 138:34:@3607.4]
  wire  _T_145; // @[spi.scala 147:37:@3621.4]
  wire  _T_146; // @[spi.scala 147:58:@3622.4]
  wire  _T_147; // @[spi.scala 147:47:@3623.4]
  wire  _T_148; // @[spi.scala 147:25:@3624.4]
  wire  _T_149; // @[spi.scala 147:83:@3625.4]
  wire  _T_150; // @[spi.scala 147:70:@3626.4]
  wire  _T_151; // @[spi.scala 147:108:@3627.4]
  wire  _T_155; // @[spi.scala 154:39:@3635.6]
  wire  _T_156; // @[spi.scala 154:30:@3636.6]
  wire  _GEN_8; // @[spi.scala 154:59:@3637.6]
  wire  _GEN_9; // @[spi.scala 152:15:@3630.4]
  wire  _T_160; // @[spi.scala 161:35:@3646.6]
  wire  _T_161; // @[spi.scala 161:30:@3647.6]
  wire  _GEN_10; // @[spi.scala 161:43:@3648.6]
  wire  _GEN_11; // @[spi.scala 159:15:@3641.4]
  reg [4:0] clock_cnt; // @[spi.scala 166:31:@3651.4]
  reg [31:0] _RAND_23;
  reg [5:0] data_cnt; // @[spi.scala 167:31:@3652.4]
  reg [31:0] _RAND_24;
  reg  pending_data; // @[spi.scala 168:31:@3653.4]
  reg [31:0] _RAND_25;
  reg [2:0] n_status; // @[spi.scala 170:31:@3656.4]
  reg [31:0] _RAND_26;
  reg [2:0] p_status; // @[spi.scala 171:31:@3657.4]
  reg [31:0] _RAND_27;
  wire  _T_174; // @[spi.scala 175:27:@3663.6]
  wire  _GEN_12; // @[spi.scala 175:40:@3664.6]
  wire  _GEN_13; // @[spi.scala 173:32:@3659.4]
  wire [7:0] _T_180; // @[spi.scala 181:78:@3670.6]
  wire [7:0] _T_181; // @[spi.scala 181:44:@3671.6]
  wire [7:0] _T_182; // @[spi.scala 181:12:@3672.6]
  wire [7:0] _T_183; // @[spi.scala 180:49:@3673.6]
  wire [7:0] _T_184; // @[spi.scala 180:21:@3674.6]
  wire [7:0] _GEN_14; // @[spi.scala 179:18:@3667.4]
  wire  _T_185; // @[spi.scala 185:16:@3678.4]
  wire  _GEN_15; // @[spi.scala 185:35:@3679.4]
  wire  _T_188; // @[spi.scala 201:21:@3685.4]
  wire  _T_190; // @[spi.scala 201:49:@3686.4]
  wire  _T_191; // @[spi.scala 201:35:@3687.4]
  wire  _T_192; // @[spi.scala 202:18:@3689.6]
  wire  _GEN_16; // @[spi.scala 201:67:@3688.4]
  wire  _T_196; // @[spi.scala 208:59:@3695.4]
  wire  _T_197; // @[spi.scala 208:39:@3696.4]
  wire  _T_199; // @[spi.scala 208:71:@3698.4]
  wire [8:0] _T_203; // @[Cat.scala 30:58:@3706.8]
  wire [8:0] _GEN_18; // @[spi.scala 208:99:@3699.4]
  wire  _T_204; // @[spi.scala 217:20:@3710.4]
  wire  _T_205; // @[spi.scala 217:47:@3711.4]
  wire  _T_206; // @[spi.scala 217:34:@3712.4]
  wire  _GEN_19; // @[spi.scala 219:33:@3717.6]
  wire  _GEN_20; // @[spi.scala 217:62:@3713.4]
  wire  _T_211; // @[spi.scala 223:49:@3721.4]
  wire  _T_212; // @[spi.scala 223:36:@3722.4]
  wire [5:0] _T_215; // @[spi.scala 226:30:@3727.6]
  wire [4:0] _T_216; // @[spi.scala 226:30:@3728.6]
  wire [4:0] _GEN_21; // @[spi.scala 223:63:@3723.4]
  wire [2:0] _GEN_22; // @[spi.scala 235:26:@3739.6]
  wire  _T_229; // @[spi.scala 246:27:@3758.8]
  wire  _T_233; // @[spi.scala 247:53:@3761.10]
  wire  _T_234; // @[spi.scala 247:40:@3762.10]
  wire [2:0] _GEN_24; // @[spi.scala 247:76:@3763.10]
  wire  _T_238; // @[spi.scala 253:53:@3774.12]
  wire  _T_239; // @[spi.scala 253:40:@3775.12]
  wire  _T_242; // @[spi.scala 253:69:@3777.12]
  wire [2:0] _GEN_25; // @[spi.scala 253:105:@3778.12]
  wire  _T_243; // @[spi.scala 258:27:@3786.12]
  wire [2:0] _GEN_27; // @[spi.scala 259:39:@3789.14]
  wire  _T_247; // @[spi.scala 266:27:@3799.14]
  wire  _T_251; // @[spi.scala 267:53:@3802.16]
  wire  _T_252; // @[spi.scala 267:40:@3803.16]
  wire [2:0] _GEN_28; // @[spi.scala 267:77:@3804.16]
  wire [2:0] _GEN_29; // @[spi.scala 266:44:@3800.14]
  wire [2:0] _GEN_30; // @[spi.scala 258:46:@3787.12]
  wire [2:0] _GEN_31; // @[spi.scala 252:41:@3772.10]
  wire [2:0] _GEN_32; // @[spi.scala 246:40:@3759.8]
  wire [2:0] _GEN_33; // @[spi.scala 240:40:@3748.6]
  wire [2:0] _GEN_34; // @[spi.scala 234:32:@3738.4]
  wire  _T_256; // @[spi.scala 276:32:@3816.4]
  wire  _T_259; // @[spi.scala 276:63:@3818.4]
  wire  _T_266; // @[spi.scala 278:73:@3827.6]
  wire  _T_269; // @[spi.scala 278:102:@3829.6]
  wire  _T_274; // @[spi.scala 280:45:@3836.8]
  wire  _T_277; // @[spi.scala 280:76:@3838.8]
  wire  _T_291; // @[spi.scala 282:133:@3851.10]
  wire  _T_292; // @[spi.scala 282:74:@3852.10]
  wire  _T_297; // @[spi.scala 282:174:@3856.10]
  wire [6:0] _T_299; // @[spi.scala 283:28:@3858.12]
  wire [5:0] _T_300; // @[spi.scala 283:28:@3859.12]
  wire [5:0] _GEN_35; // @[spi.scala 282:238:@3857.10]
  wire [5:0] _GEN_36; // @[spi.scala 280:113:@3839.8]
  wire [5:0] _GEN_37; // @[spi.scala 278:138:@3830.6]
  wire [5:0] _GEN_38; // @[spi.scala 276:99:@3819.4]
  reg  wait_one_tick_done; // @[spi.scala 286:37:@3862.4]
  reg [31:0] _RAND_28;
  wire  _T_321; // @[spi.scala 298:72:@3884.6]
  wire [8:0] _T_328; // @[Cat.scala 30:58:@3889.6]
  wire  _T_341; // @[spi.scala 302:80:@3903.10]
  wire [8:0] _T_348; // @[Cat.scala 30:58:@3908.10]
  wire  _GEN_42; // @[spi.scala 301:32:@3901.8]
  wire [8:0] _GEN_43; // @[spi.scala 301:32:@3901.8]
  wire  _GEN_44; // @[spi.scala 300:114:@3900.6]
  wire [8:0] _GEN_45; // @[spi.scala 300:114:@3900.6]
  wire  _GEN_46; // @[spi.scala 297:37:@3882.4]
  wire [8:0] _GEN_47; // @[spi.scala 297:37:@3882.4]
  wire  _GEN_48; // @[spi.scala 310:39:@3920.6]
  wire  _GEN_49; // @[spi.scala 308:36:@3915.4]
  wire  _T_355; // @[spi.scala 314:12:@3923.4]
  wire  _T_356; // @[spi.scala 314:22:@3924.4]
  wire  _T_357; // @[spi.scala 314:31:@3925.4]
  wire  _T_359; // @[spi.scala 316:24:@3930.6]
  wire  _GEN_50; // @[spi.scala 316:43:@3931.6]
  wire  _GEN_51; // @[spi.scala 314:46:@3926.4]
  wire  _T_364; // @[spi.scala 320:40:@3936.4]
  wire  _GEN_52; // @[spi.scala 321:22:@3938.6]
  wire  _GEN_53; // @[spi.scala 321:22:@3938.6]
  wire  _T_367; // @[spi.scala 326:24:@3946.6]
  wire  _GEN_54; // @[spi.scala 326:39:@3947.6]
  wire  _GEN_55; // @[spi.scala 326:39:@3947.6]
  wire  _GEN_56; // @[spi.scala 320:72:@3937.4]
  wire  _GEN_57; // @[spi.scala 320:72:@3937.4]
  wire  _T_370; // @[spi.scala 331:21:@3951.4]
  wire  _T_371; // @[spi.scala 331:34:@3952.4]
  wire  _GEN_58; // @[spi.scala 331:51:@3953.4]
  assign addr = io_wbs_m2s_addr[7:0]; // @[spi.scala 106:33:@3562.4]
  assign _T_104 = io_wbs_m2s_we == 1'h0; // @[spi.scala 108:19:@3563.4]
  assign rd_en = _T_104 & io_wbs_m2s_stb; // @[spi.scala 108:34:@3564.4]
  assign wr_en = io_wbs_m2s_we & io_wbs_m2s_stb; // @[spi.scala 109:33:@3567.4]
  assign _T_115 = addr == 8'h0; // @[spi.scala 113:32:@3571.4]
  assign sel_reg_rx = _T_115 & io_spi_select; // @[spi.scala 113:54:@3572.4]
  assign _T_116 = addr == 8'h1; // @[spi.scala 114:32:@3573.4]
  assign sel_reg_tx = _T_116 & io_spi_select; // @[spi.scala 114:54:@3574.4]
  assign _T_118 = addr == 8'h3; // @[spi.scala 116:32:@3577.4]
  assign sel_reg_control = _T_118 & io_spi_select; // @[spi.scala 116:55:@3578.4]
  assign _T_119 = addr == 8'h4; // @[spi.scala 117:32:@3579.4]
  assign sel_reg_status = _T_119 & io_spi_select; // @[spi.scala 117:54:@3580.4]
  assign _T_120 = addr == 8'h5; // @[spi.scala 118:32:@3581.4]
  assign sel_reg_ssmask = _T_120 & io_spi_select; // @[spi.scala 118:55:@3582.4]
  assign _GEN_0 = rx_latch_flag ? rx_shift_data : reg_rxdata; // @[spi.scala 121:23:@3583.4]
  assign _T_121 = wr_en & sel_reg_tx; // @[spi.scala 126:14:@3586.4]
  assign _T_122 = _T_121 & bit_trdy; // @[spi.scala 126:28:@3587.4]
  assign latch_s_data = io_wbs_m2s_data[7:0]; // @[:@3542.4 :@3543.4 spi.scala 110:16:@3570.4]
  assign _GEN_1 = _T_122 ? latch_s_data : reg_txdata; // @[spi.scala 126:41:@3588.4]
  assign _T_123 = bit_toe | bit_roe; // @[spi.scala 131:19:@3591.4]
  assign reg_status = {bit_e,bit_rrdy,bit_trdy,bit_tmt,bit_toe,bit_roe,2'h0}; // @[Cat.scala 30:58:@3598.4]
  assign reg_control = {bit_sso,1'h0,bit_ie,bit_irrdy,bit_itrdy,1'h0,bit_itoe,bit_iroe}; // @[Cat.scala 30:58:@3605.4]
  assign _T_138 = wr_en & sel_reg_control; // @[spi.scala 138:14:@3606.4]
  assign _T_139 = latch_s_data[0]; // @[spi.scala 139:30:@3608.6]
  assign _T_140 = latch_s_data[1]; // @[spi.scala 140:30:@3610.6]
  assign _T_141 = latch_s_data[3]; // @[spi.scala 141:30:@3612.6]
  assign _T_142 = latch_s_data[4]; // @[spi.scala 142:30:@3614.6]
  assign _T_143 = latch_s_data[5]; // @[spi.scala 143:30:@3616.6]
  assign _T_144 = latch_s_data[7]; // @[spi.scala 144:30:@3618.6]
  assign _GEN_2 = _T_138 ? _T_139 : bit_iroe; // @[spi.scala 138:34:@3607.4]
  assign _GEN_3 = _T_138 ? _T_140 : bit_itoe; // @[spi.scala 138:34:@3607.4]
  assign _GEN_4 = _T_138 ? _T_141 : bit_itrdy; // @[spi.scala 138:34:@3607.4]
  assign _GEN_5 = _T_138 ? _T_142 : bit_irrdy; // @[spi.scala 138:34:@3607.4]
  assign _GEN_6 = _T_138 ? _T_143 : bit_ie; // @[spi.scala 138:34:@3607.4]
  assign _GEN_7 = _T_138 ? _T_144 : bit_sso; // @[spi.scala 138:34:@3607.4]
  assign _T_145 = bit_iroe & bit_roe; // @[spi.scala 147:37:@3621.4]
  assign _T_146 = bit_itoe & bit_toe; // @[spi.scala 147:58:@3622.4]
  assign _T_147 = _T_145 | _T_146; // @[spi.scala 147:47:@3623.4]
  assign _T_148 = bit_ie & _T_147; // @[spi.scala 147:25:@3624.4]
  assign _T_149 = bit_itrdy & bit_trdy; // @[spi.scala 147:83:@3625.4]
  assign _T_150 = _T_148 | _T_149; // @[spi.scala 147:70:@3626.4]
  assign _T_151 = bit_irrdy & bit_rrdy; // @[spi.scala 147:108:@3627.4]
  assign _T_155 = io_wbs_m2s_we | read_wait_done; // @[spi.scala 154:39:@3635.6]
  assign _T_156 = io_wbs_m2s_stb & _T_155; // @[spi.scala 154:30:@3636.6]
  assign _GEN_8 = _T_156 ? 1'h1 : ack_o; // @[spi.scala 154:59:@3637.6]
  assign _GEN_9 = ack_o ? 1'h0 : _GEN_8; // @[spi.scala 152:15:@3630.4]
  assign _T_160 = ~ io_wbs_m2s_we; // @[spi.scala 161:35:@3646.6]
  assign _T_161 = io_wbs_m2s_stb & _T_160; // @[spi.scala 161:30:@3647.6]
  assign _GEN_10 = _T_161 ? 1'h1 : read_wait_done; // @[spi.scala 161:43:@3648.6]
  assign _GEN_11 = ack_o ? 1'h0 : _GEN_10; // @[spi.scala 159:15:@3641.4]
  assign _T_174 = n_status == 3'h1; // @[spi.scala 175:27:@3663.6]
  assign _GEN_12 = _T_174 ? 1'h0 : pending_data; // @[spi.scala 175:40:@3664.6]
  assign _GEN_13 = _T_121 ? 1'h1 : _GEN_12; // @[spi.scala 173:32:@3659.4]
  assign _T_180 = sel_reg_ssmask ? {{7'd0}, reg_ssmask} : 8'h0; // @[spi.scala 181:78:@3670.6]
  assign _T_181 = sel_reg_control ? reg_control : _T_180; // @[spi.scala 181:44:@3671.6]
  assign _T_182 = sel_reg_status ? reg_status : _T_181; // @[spi.scala 181:12:@3672.6]
  assign _T_183 = sel_reg_tx ? reg_txdata : _T_182; // @[spi.scala 180:49:@3673.6]
  assign _T_184 = sel_reg_rx ? reg_rxdata : _T_183; // @[spi.scala 180:21:@3674.6]
  assign _GEN_14 = rd_en ? _T_184 : rd_data; // @[spi.scala 179:18:@3667.4]
  assign _T_185 = wr_en & sel_reg_ssmask; // @[spi.scala 185:16:@3678.4]
  assign _GEN_15 = _T_185 ? _T_139 : reg_ssmask; // @[spi.scala 185:35:@3679.4]
  assign _T_188 = n_status == 3'h3; // @[spi.scala 201:21:@3685.4]
  assign _T_190 = clock_cnt == 5'h3; // @[spi.scala 201:49:@3686.4]
  assign _T_191 = _T_188 & _T_190; // @[spi.scala 201:35:@3687.4]
  assign _T_192 = ~ sclk_r; // @[spi.scala 202:18:@3689.6]
  assign _GEN_16 = _T_191 ? _T_192 : sclk_r; // @[spi.scala 201:67:@3688.4]
  assign _T_196 = 1'h0 == sclk_r; // @[spi.scala 208:59:@3695.4]
  assign _T_197 = _T_190 & _T_196; // @[spi.scala 208:39:@3696.4]
  assign _T_199 = _T_197 & _T_188; // @[spi.scala 208:71:@3698.4]
  assign _T_203 = {rx_shift_data,io_spi_miso}; // @[Cat.scala 30:58:@3706.8]
  assign _GEN_18 = _T_199 ? _T_203 : {{1'd0}, rx_shift_data}; // @[spi.scala 208:99:@3699.4]
  assign _T_204 = p_status == 3'h3; // @[spi.scala 217:20:@3710.4]
  assign _T_205 = n_status != 3'h3; // @[spi.scala 217:47:@3711.4]
  assign _T_206 = _T_204 & _T_205; // @[spi.scala 217:34:@3712.4]
  assign _GEN_19 = rx_latch_flag ? 1'h0 : rx_latch_flag; // @[spi.scala 219:33:@3717.6]
  assign _GEN_20 = _T_206 ? 1'h1 : _GEN_19; // @[spi.scala 217:62:@3713.4]
  assign _T_211 = n_status == 3'h0; // @[spi.scala 223:49:@3721.4]
  assign _T_212 = _T_190 | _T_211; // @[spi.scala 223:36:@3722.4]
  assign _T_215 = clock_cnt + 5'h1; // @[spi.scala 226:30:@3727.6]
  assign _T_216 = clock_cnt + 5'h1; // @[spi.scala 226:30:@3728.6]
  assign _GEN_21 = _T_212 ? 5'h0 : _T_216; // @[spi.scala 223:63:@3723.4]
  assign _GEN_22 = pending_data ? 3'h1 : 3'h0; // @[spi.scala 235:26:@3739.6]
  assign _T_229 = n_status == 3'h2; // @[spi.scala 246:27:@3758.8]
  assign _T_233 = data_cnt == 6'h1; // @[spi.scala 247:53:@3761.10]
  assign _T_234 = _T_190 & _T_233; // @[spi.scala 247:40:@3762.10]
  assign _GEN_24 = _T_234 ? 3'h3 : 3'h2; // @[spi.scala 247:76:@3763.10]
  assign _T_238 = data_cnt == 6'h7; // @[spi.scala 253:53:@3774.12]
  assign _T_239 = _T_190 & _T_238; // @[spi.scala 253:40:@3775.12]
  assign _T_242 = _T_239 & sclk_r; // @[spi.scala 253:69:@3777.12]
  assign _GEN_25 = _T_242 ? 3'h4 : 3'h3; // @[spi.scala 253:105:@3778.12]
  assign _T_243 = n_status == 3'h4; // @[spi.scala 258:27:@3786.12]
  assign _GEN_27 = _T_190 ? 3'h5 : n_status; // @[spi.scala 259:39:@3789.14]
  assign _T_247 = n_status == 3'h5; // @[spi.scala 266:27:@3799.14]
  assign _T_251 = data_cnt == 6'h2; // @[spi.scala 267:53:@3802.16]
  assign _T_252 = _T_190 & _T_251; // @[spi.scala 267:40:@3803.16]
  assign _GEN_28 = _T_252 ? 3'h0 : 3'h5; // @[spi.scala 267:77:@3804.16]
  assign _GEN_29 = _T_247 ? _GEN_28 : 3'h0; // @[spi.scala 266:44:@3800.14]
  assign _GEN_30 = _T_243 ? _GEN_27 : _GEN_29; // @[spi.scala 258:46:@3787.12]
  assign _GEN_31 = _T_188 ? _GEN_25 : _GEN_30; // @[spi.scala 252:41:@3772.10]
  assign _GEN_32 = _T_229 ? _GEN_24 : _GEN_31; // @[spi.scala 246:40:@3759.8]
  assign _GEN_33 = _T_174 ? 3'h2 : _GEN_32; // @[spi.scala 240:40:@3748.6]
  assign _GEN_34 = _T_211 ? _GEN_22 : _GEN_33; // @[spi.scala 234:32:@3738.4]
  assign _T_256 = _T_229 & _T_190; // @[spi.scala 276:32:@3816.4]
  assign _T_259 = _T_256 & _T_233; // @[spi.scala 276:63:@3818.4]
  assign _T_266 = _T_191 & _T_238; // @[spi.scala 278:73:@3827.6]
  assign _T_269 = _T_266 & sclk_r; // @[spi.scala 278:102:@3829.6]
  assign _T_274 = _T_247 & _T_190; // @[spi.scala 280:45:@3836.8]
  assign _T_277 = _T_274 & _T_251; // @[spi.scala 280:76:@3838.8]
  assign _T_291 = _T_191 & sclk_r; // @[spi.scala 282:133:@3851.10]
  assign _T_292 = _T_256 | _T_291; // @[spi.scala 282:74:@3852.10]
  assign _T_297 = _T_292 | _T_274; // @[spi.scala 282:174:@3856.10]
  assign _T_299 = data_cnt + 6'h1; // @[spi.scala 283:28:@3858.12]
  assign _T_300 = data_cnt + 6'h1; // @[spi.scala 283:28:@3859.12]
  assign _GEN_35 = _T_297 ? _T_300 : data_cnt; // @[spi.scala 282:238:@3857.10]
  assign _GEN_36 = _T_277 ? 6'h0 : _GEN_35; // @[spi.scala 280:113:@3839.8]
  assign _GEN_37 = _T_269 ? 6'h0 : _GEN_36; // @[spi.scala 278:138:@3830.6]
  assign _GEN_38 = _T_259 ? 6'h0 : _GEN_37; // @[spi.scala 276:99:@3819.4]
  assign _T_321 = reg_txdata[7]; // @[spi.scala 298:72:@3884.6]
  assign _T_328 = {reg_txdata,1'h0}; // @[Cat.scala 30:58:@3889.6]
  assign _T_341 = tx_shift_data[7]; // @[spi.scala 302:80:@3903.10]
  assign _T_348 = {tx_shift_data,1'h0}; // @[Cat.scala 30:58:@3908.10]
  assign _GEN_42 = wait_one_tick_done ? _T_341 : mosi_r; // @[spi.scala 301:32:@3901.8]
  assign _GEN_43 = wait_one_tick_done ? _T_348 : {{1'd0}, tx_shift_data}; // @[spi.scala 301:32:@3901.8]
  assign _GEN_44 = _T_291 ? _GEN_42 : mosi_r; // @[spi.scala 300:114:@3900.6]
  assign _GEN_45 = _T_291 ? _GEN_43 : {{1'd0}, tx_shift_data}; // @[spi.scala 300:114:@3900.6]
  assign _GEN_46 = _T_229 ? _T_321 : _GEN_44; // @[spi.scala 297:37:@3882.4]
  assign _GEN_47 = _T_229 ? _T_328 : _GEN_45; // @[spi.scala 297:37:@3882.4]
  assign _GEN_48 = _T_121 ? 1'h0 : bit_trdy; // @[spi.scala 310:39:@3920.6]
  assign _GEN_49 = _T_188 ? 1'h1 : _GEN_48; // @[spi.scala 308:36:@3915.4]
  assign _T_355 = bit_trdy == 1'h0; // @[spi.scala 314:12:@3923.4]
  assign _T_356 = _T_355 & wr_en; // @[spi.scala 314:22:@3924.4]
  assign _T_357 = _T_356 & sel_reg_tx; // @[spi.scala 314:31:@3925.4]
  assign _T_359 = wr_en & sel_reg_status; // @[spi.scala 316:24:@3930.6]
  assign _GEN_50 = _T_359 ? 1'h0 : bit_toe; // @[spi.scala 316:43:@3931.6]
  assign _GEN_51 = _T_357 ? 1'h1 : _GEN_50; // @[spi.scala 314:46:@3926.4]
  assign _T_364 = _T_243 & _T_190; // @[spi.scala 320:40:@3936.4]
  assign _GEN_52 = bit_rrdy ? 1'h1 : bit_roe; // @[spi.scala 321:22:@3938.6]
  assign _GEN_53 = bit_rrdy ? bit_rrdy : 1'h1; // @[spi.scala 321:22:@3938.6]
  assign _T_367 = rd_en & sel_reg_rx; // @[spi.scala 326:24:@3946.6]
  assign _GEN_54 = _T_367 ? 1'h0 : bit_rrdy; // @[spi.scala 326:39:@3947.6]
  assign _GEN_55 = _T_367 ? 1'h0 : bit_roe; // @[spi.scala 326:39:@3947.6]
  assign _GEN_56 = _T_364 ? _GEN_52 : _GEN_55; // @[spi.scala 320:72:@3937.4]
  assign _GEN_57 = _T_364 ? _GEN_53 : _GEN_54; // @[spi.scala 320:72:@3937.4]
  assign _T_370 = n_status != 3'h0; // @[spi.scala 331:21:@3951.4]
  assign _T_371 = _T_370 | pending_data; // @[spi.scala 331:34:@3952.4]
  assign _GEN_58 = _T_371 ? 1'h0 : 1'h1; // @[spi.scala 331:51:@3953.4]
  assign io_spi_cs = ~ reg_ssmask; // @[spi.scala 198:13:@3684.4]
  assign io_spi_clk = sclk_r; // @[spi.scala 204:16:@3692.4]
  assign io_spi_mosi = mosi_r; // @[spi.scala 306:15:@3913.4]
  assign io_spi_intr = _T_150 | _T_151; // @[spi.scala 147:14:@3629.4]
  assign io_wbs_ack_o = ack_o; // @[spi.scala 157:15:@3640.4]
  assign io_wbs_data_o = {{24'd0}, rd_data}; // @[spi.scala 183:18:@3677.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ack_o = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  rd_data = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  sclk_r = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  mosi_r = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  read_wait_done = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  reg_rxdata = _RAND_5[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  reg_txdata = _RAND_6[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  reg_ssmask = _RAND_7[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  rx_shift_data = _RAND_8[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  tx_shift_data = _RAND_9[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  rx_latch_flag = _RAND_10[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  bit_iroe = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  bit_itoe = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  bit_itrdy = _RAND_13[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  bit_irrdy = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  bit_ie = _RAND_15[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  bit_sso = _RAND_16[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  bit_toe = _RAND_17[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  bit_roe = _RAND_18[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {1{`RANDOM}};
  bit_trdy = _RAND_19[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_20 = {1{`RANDOM}};
  bit_rrdy = _RAND_20[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_21 = {1{`RANDOM}};
  bit_tmt = _RAND_21[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_22 = {1{`RANDOM}};
  bit_e = _RAND_22[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_23 = {1{`RANDOM}};
  clock_cnt = _RAND_23[4:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_24 = {1{`RANDOM}};
  data_cnt = _RAND_24[5:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_25 = {1{`RANDOM}};
  pending_data = _RAND_25[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_26 = {1{`RANDOM}};
  n_status = _RAND_26[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_27 = {1{`RANDOM}};
  p_status = _RAND_27[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_28 = {1{`RANDOM}};
  wait_one_tick_done = _RAND_28[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      ack_o <= 1'h0;
    end else begin
      if (ack_o) begin
        ack_o <= 1'h0;
      end else begin
        if (_T_156) begin
          ack_o <= 1'h1;
        end
      end
    end
    if (reset) begin
      rd_data <= 8'h0;
    end else begin
      if (rd_en) begin
        if (sel_reg_rx) begin
          rd_data <= reg_rxdata;
        end else begin
          if (sel_reg_tx) begin
            rd_data <= reg_txdata;
          end else begin
            if (sel_reg_status) begin
              rd_data <= reg_status;
            end else begin
              if (sel_reg_control) begin
                rd_data <= reg_control;
              end else begin
                if (sel_reg_ssmask) begin
                  rd_data <= {{7'd0}, reg_ssmask};
                end else begin
                  rd_data <= 8'h0;
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      sclk_r <= 1'h0;
    end else begin
      if (_T_191) begin
        sclk_r <= _T_192;
      end
    end
    if (reset) begin
      mosi_r <= 1'h0;
    end else begin
      if (_T_229) begin
        mosi_r <= _T_321;
      end else begin
        if (_T_291) begin
          if (wait_one_tick_done) begin
            mosi_r <= _T_341;
          end
        end
      end
    end
    if (reset) begin
      read_wait_done <= 1'h0;
    end else begin
      if (ack_o) begin
        read_wait_done <= 1'h0;
      end else begin
        if (_T_161) begin
          read_wait_done <= 1'h1;
        end
      end
    end
    if (reset) begin
      reg_rxdata <= 8'h0;
    end else begin
      if (rx_latch_flag) begin
        reg_rxdata <= rx_shift_data;
      end
    end
    if (reset) begin
      reg_txdata <= 8'h35;
    end else begin
      if (_T_122) begin
        reg_txdata <= latch_s_data;
      end
    end
    if (reset) begin
      reg_ssmask <= 1'h0;
    end else begin
      if (_T_185) begin
        reg_ssmask <= _T_139;
      end
    end
    if (reset) begin
      rx_shift_data <= 8'h0;
    end else begin
      rx_shift_data <= _GEN_18[7:0];
    end
    if (reset) begin
      tx_shift_data <= 8'h0;
    end else begin
      tx_shift_data <= _GEN_47[7:0];
    end
    if (reset) begin
      rx_latch_flag <= 1'h0;
    end else begin
      if (_T_206) begin
        rx_latch_flag <= 1'h1;
      end else begin
        if (rx_latch_flag) begin
          rx_latch_flag <= 1'h0;
        end
      end
    end
    if (reset) begin
      bit_iroe <= 1'h0;
    end else begin
      if (_T_138) begin
        bit_iroe <= _T_139;
      end
    end
    if (reset) begin
      bit_itoe <= 1'h0;
    end else begin
      if (_T_138) begin
        bit_itoe <= _T_140;
      end
    end
    if (reset) begin
      bit_itrdy <= 1'h0;
    end else begin
      if (_T_138) begin
        bit_itrdy <= _T_141;
      end
    end
    if (reset) begin
      bit_irrdy <= 1'h0;
    end else begin
      if (_T_138) begin
        bit_irrdy <= _T_142;
      end
    end
    if (reset) begin
      bit_ie <= 1'h0;
    end else begin
      if (_T_138) begin
        bit_ie <= _T_143;
      end
    end
    if (reset) begin
      bit_sso <= 1'h1;
    end else begin
      if (_T_138) begin
        bit_sso <= _T_144;
      end
    end
    if (reset) begin
      bit_toe <= 1'h0;
    end else begin
      if (_T_357) begin
        bit_toe <= 1'h1;
      end else begin
        if (_T_359) begin
          bit_toe <= 1'h0;
        end
      end
    end
    if (reset) begin
      bit_roe <= 1'h0;
    end else begin
      if (_T_364) begin
        if (bit_rrdy) begin
          bit_roe <= 1'h1;
        end
      end else begin
        if (_T_367) begin
          bit_roe <= 1'h0;
        end
      end
    end
    if (reset) begin
      bit_trdy <= 1'h1;
    end else begin
      if (_T_188) begin
        bit_trdy <= 1'h1;
      end else begin
        if (_T_121) begin
          bit_trdy <= 1'h0;
        end
      end
    end
    if (reset) begin
      bit_rrdy <= 1'h0;
    end else begin
      if (_T_364) begin
        if (!(bit_rrdy)) begin
          bit_rrdy <= 1'h1;
        end
      end else begin
        if (_T_367) begin
          bit_rrdy <= 1'h0;
        end
      end
    end
    if (reset) begin
      bit_tmt <= 1'h1;
    end else begin
      if (_T_371) begin
        bit_tmt <= 1'h0;
      end else begin
        bit_tmt <= 1'h1;
      end
    end
    if (reset) begin
      bit_e <= 1'h0;
    end else begin
      bit_e <= _T_123;
    end
    if (reset) begin
      clock_cnt <= 5'h0;
    end else begin
      if (_T_212) begin
        clock_cnt <= 5'h0;
      end else begin
        clock_cnt <= _T_216;
      end
    end
    if (reset) begin
      data_cnt <= 6'h0;
    end else begin
      if (_T_259) begin
        data_cnt <= 6'h0;
      end else begin
        if (_T_269) begin
          data_cnt <= 6'h0;
        end else begin
          if (_T_277) begin
            data_cnt <= 6'h0;
          end else begin
            if (_T_297) begin
              data_cnt <= _T_300;
            end
          end
        end
      end
    end
    if (reset) begin
      pending_data <= 1'h0;
    end else begin
      if (_T_121) begin
        pending_data <= 1'h1;
      end else begin
        if (_T_174) begin
          pending_data <= 1'h0;
        end
      end
    end
    if (reset) begin
      n_status <= 3'h0;
    end else begin
      if (_T_211) begin
        if (pending_data) begin
          n_status <= 3'h1;
        end else begin
          n_status <= 3'h0;
        end
      end else begin
        if (_T_174) begin
          n_status <= 3'h2;
        end else begin
          if (_T_229) begin
            if (_T_234) begin
              n_status <= 3'h3;
            end else begin
              n_status <= 3'h2;
            end
          end else begin
            if (_T_188) begin
              if (_T_242) begin
                n_status <= 3'h4;
              end else begin
                n_status <= 3'h3;
              end
            end else begin
              if (_T_243) begin
                if (_T_190) begin
                  n_status <= 3'h5;
                end
              end else begin
                if (_T_247) begin
                  if (_T_252) begin
                    n_status <= 3'h0;
                  end else begin
                    n_status <= 3'h5;
                  end
                end else begin
                  n_status <= 3'h0;
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      p_status <= 3'h0;
    end else begin
      p_status <= n_status;
    end
    if (reset) begin
      wait_one_tick_done <= 1'h0;
    end else begin
      wait_one_tick_done <= 1'h1;
    end
  end
endmodule
module Interlink_Module( // @[:@3960.2]
  input         clock, // @[:@3961.4]
  input         reset, // @[:@3962.4]
  input  [31:0] io_bus_adr_i, // @[:@3963.4]
  input  [3:0]  io_bus_sel_i, // @[:@3963.4]
  input         io_bus_we_i, // @[:@3963.4]
  input         io_bus_cyc_i, // @[:@3963.4]
  input         io_bus_stb_i, // @[:@3963.4]
  output        io_bus_ack_o, // @[:@3963.4]
  output [31:0] io_bus_dat_o, // @[:@3963.4]
  output        io_tmr_val_we, // @[:@3963.4]
  input  [31:0] io_tmr_val_do, // @[:@3963.4]
  output        io_tmr_dat_we, // @[:@3963.4]
  input  [31:0] io_tmr_dat_do, // @[:@3963.4]
  output        io_tmr_duty_we, // @[:@3963.4]
  input  [31:0] io_tmr_duty_do, // @[:@3963.4]
  output        io_tmr_cfg_we, // @[:@3963.4]
  input  [31:0] io_tmr_cfg_do, // @[:@3963.4]
  output        io_qei_count_we, // @[:@3963.4]
  input  [31:0] io_qei_count_do, // @[:@3963.4]
  output        io_qei_cfg_we, // @[:@3963.4]
  input  [31:0] io_qei_cfg_do, // @[:@3963.4]
  input  [15:0] io_qei_speed_do, // @[:@3963.4]
  output        io_pid_kp_we, // @[:@3963.4]
  input  [15:0] io_pid_kp_do, // @[:@3963.4]
  output        io_pid_ki_we, // @[:@3963.4]
  input  [15:0] io_pid_ki_do, // @[:@3963.4]
  output        io_pid_kd_we, // @[:@3963.4]
  input  [15:0] io_pid_kd_do, // @[:@3963.4]
  output        io_pid_ref_we, // @[:@3963.4]
  input  [15:0] io_pid_ref_do, // @[:@3963.4]
  output        io_pid_fb_we, // @[:@3963.4]
  input  [15:0] io_pid_fb_do, // @[:@3963.4]
  output        io_pid_cfg_we, // @[:@3963.4]
  input  [15:0] io_pid_cfg_do, // @[:@3963.4]
  input         io_motor_select // @[:@3963.4]
);
  wire  bus_valid; // @[interlink.scala 89:53:@3965.4]
  wire [11:0] reg_offset; // @[interlink.scala 98:35:@3972.4]
  wire  _T_78; // @[interlink.scala 100:50:@3973.4]
  wire  _T_79; // @[interlink.scala 100:81:@3974.4]
  wire  tmr_cfg_sel; // @[interlink.scala 100:66:@3975.4]
  wire  _T_83; // @[interlink.scala 101:81:@3979.4]
  wire  tmr_val_sel; // @[interlink.scala 101:66:@3980.4]
  wire  _T_87; // @[interlink.scala 102:81:@3984.4]
  wire  tmr_dat_sel; // @[interlink.scala 102:66:@3985.4]
  wire  _T_91; // @[interlink.scala 103:81:@3989.4]
  wire  tmr_duty_sel; // @[interlink.scala 103:66:@3990.4]
  wire  _T_94; // @[interlink.scala 105:72:@3993.4]
  wire  _T_95; // @[interlink.scala 105:76:@3994.4]
  wire  _T_121; // @[interlink.scala 112:35:@4020.4]
  wire  _T_122; // @[interlink.scala 112:50:@4021.4]
  wire  tmr_sel; // @[interlink.scala 112:65:@4022.4]
  wire [31:0] _T_123; // @[interlink.scala 114:26:@4023.4]
  wire [31:0] _T_124; // @[interlink.scala 113:57:@4024.4]
  wire [31:0] tmr_do; // @[interlink.scala 113:26:@4025.4]
  wire  _T_128; // @[interlink.scala 118:81:@4028.4]
  wire  qei_count_sel; // @[interlink.scala 118:66:@4029.4]
  wire  _T_138; // @[interlink.scala 122:81:@4039.4]
  wire  qei_cfg_sel; // @[interlink.scala 122:66:@4040.4]
  wire  _T_148; // @[interlink.scala 126:81:@4050.4]
  wire  qei_speed_sel; // @[interlink.scala 126:66:@4051.4]
  wire  _T_155; // @[interlink.scala 130:37:@4059.4]
  wire  qei_sel; // @[interlink.scala 130:52:@4060.4]
  wire [31:0] _T_156; // @[interlink.scala 131:59:@4061.4]
  wire [15:0] _T_236; // @[interlink.scala 187:46:@4163.4]
  wire [31:0] qei_speed_do; // @[interlink.scala 125:27:@4048.4 interlink.scala 187:21:@4164.4]
  wire [31:0] qei_do; // @[interlink.scala 131:26:@4062.4]
  wire  _T_160; // @[interlink.scala 135:81:@4065.4]
  wire  pid_kp_sel; // @[interlink.scala 135:66:@4066.4]
  wire  _T_170; // @[interlink.scala 139:81:@4076.4]
  wire  pid_ki_sel; // @[interlink.scala 139:66:@4077.4]
  wire  _T_180; // @[interlink.scala 143:81:@4087.4]
  wire  pid_kd_sel; // @[interlink.scala 143:66:@4088.4]
  wire  _T_190; // @[interlink.scala 147:81:@4098.4]
  wire  pid_ref_sel; // @[interlink.scala 147:66:@4099.4]
  wire  _T_200; // @[interlink.scala 151:81:@4109.4]
  wire  pid_fb_sel; // @[interlink.scala 151:66:@4110.4]
  wire  _T_210; // @[interlink.scala 155:81:@4120.4]
  wire  pid_cfg_sel; // @[interlink.scala 155:66:@4121.4]
  wire  _T_217; // @[interlink.scala 158:34:@4129.4]
  wire  _T_218; // @[interlink.scala 158:48:@4130.4]
  wire  _T_219; // @[interlink.scala 158:62:@4131.4]
  wire  _T_220; // @[interlink.scala 158:77:@4132.4]
  wire  pid_sel; // @[interlink.scala 158:91:@4133.4]
  wire [15:0] _T_221; // @[interlink.scala 162:46:@4134.4]
  wire [15:0] _T_222; // @[interlink.scala 161:46:@4135.4]
  wire [15:0] _T_223; // @[interlink.scala 160:46:@4136.4]
  wire [15:0] _T_224; // @[interlink.scala 159:53:@4137.4]
  wire [15:0] pid_do; // @[interlink.scala 159:26:@4138.4]
  reg  wb_ack_o; // @[interlink.scala 165:30:@4139.4]
  reg [31:0] _RAND_0;
  reg [31:0] wb_data_o; // @[interlink.scala 166:30:@4140.4]
  reg [31:0] _RAND_1;
  wire [15:0] _T_229; // @[interlink.scala 167:92:@4141.4]
  wire [15:0] _T_231; // @[interlink.scala 167:69:@4142.4]
  wire [31:0] _T_232; // @[interlink.scala 167:48:@4143.4]
  wire [31:0] _T_233; // @[interlink.scala 167:27:@4144.4]
  wire  _T_234; // @[interlink.scala 168:32:@4146.4]
  wire  _T_235; // @[interlink.scala 168:43:@4147.4]
  assign bus_valid = io_bus_stb_i & io_bus_cyc_i; // @[interlink.scala 89:53:@3965.4]
  assign reg_offset = io_bus_adr_i[11:0]; // @[interlink.scala 98:35:@3972.4]
  assign _T_78 = bus_valid & io_motor_select; // @[interlink.scala 100:50:@3973.4]
  assign _T_79 = reg_offset == 12'h0; // @[interlink.scala 100:81:@3974.4]
  assign tmr_cfg_sel = _T_78 & _T_79; // @[interlink.scala 100:66:@3975.4]
  assign _T_83 = reg_offset == 12'h4; // @[interlink.scala 101:81:@3979.4]
  assign tmr_val_sel = _T_78 & _T_83; // @[interlink.scala 101:66:@3980.4]
  assign _T_87 = reg_offset == 12'h8; // @[interlink.scala 102:81:@3984.4]
  assign tmr_dat_sel = _T_78 & _T_87; // @[interlink.scala 102:66:@3985.4]
  assign _T_91 = reg_offset == 12'hc; // @[interlink.scala 103:81:@3989.4]
  assign tmr_duty_sel = _T_78 & _T_91; // @[interlink.scala 103:66:@3990.4]
  assign _T_94 = io_bus_sel_i[0]; // @[interlink.scala 105:72:@3993.4]
  assign _T_95 = _T_94 & io_bus_we_i; // @[interlink.scala 105:76:@3994.4]
  assign _T_121 = tmr_cfg_sel | tmr_val_sel; // @[interlink.scala 112:35:@4020.4]
  assign _T_122 = _T_121 | tmr_dat_sel; // @[interlink.scala 112:50:@4021.4]
  assign tmr_sel = _T_122 | tmr_duty_sel; // @[interlink.scala 112:65:@4022.4]
  assign _T_123 = tmr_duty_sel ? io_tmr_duty_do : io_tmr_dat_do; // @[interlink.scala 114:26:@4023.4]
  assign _T_124 = tmr_val_sel ? io_tmr_val_do : _T_123; // @[interlink.scala 113:57:@4024.4]
  assign tmr_do = tmr_cfg_sel ? io_tmr_cfg_do : _T_124; // @[interlink.scala 113:26:@4025.4]
  assign _T_128 = reg_offset == 12'h100; // @[interlink.scala 118:81:@4028.4]
  assign qei_count_sel = _T_78 & _T_128; // @[interlink.scala 118:66:@4029.4]
  assign _T_138 = reg_offset == 12'h108; // @[interlink.scala 122:81:@4039.4]
  assign qei_cfg_sel = _T_78 & _T_138; // @[interlink.scala 122:66:@4040.4]
  assign _T_148 = reg_offset == 12'h104; // @[interlink.scala 126:81:@4050.4]
  assign qei_speed_sel = _T_78 & _T_148; // @[interlink.scala 126:66:@4051.4]
  assign _T_155 = qei_count_sel | qei_cfg_sel; // @[interlink.scala 130:37:@4059.4]
  assign qei_sel = _T_155 | qei_speed_sel; // @[interlink.scala 130:52:@4060.4]
  assign _T_156 = qei_cfg_sel ? io_qei_cfg_do : io_qei_count_do; // @[interlink.scala 131:59:@4061.4]
  assign _T_236 = $unsigned(io_qei_speed_do); // @[interlink.scala 187:46:@4163.4]
  assign qei_speed_do = {{16'd0}, _T_236}; // @[interlink.scala 125:27:@4048.4 interlink.scala 187:21:@4164.4]
  assign qei_do = qei_speed_sel ? qei_speed_do : _T_156; // @[interlink.scala 131:26:@4062.4]
  assign _T_160 = reg_offset == 12'h200; // @[interlink.scala 135:81:@4065.4]
  assign pid_kp_sel = _T_78 & _T_160; // @[interlink.scala 135:66:@4066.4]
  assign _T_170 = reg_offset == 12'h204; // @[interlink.scala 139:81:@4076.4]
  assign pid_ki_sel = _T_78 & _T_170; // @[interlink.scala 139:66:@4077.4]
  assign _T_180 = reg_offset == 12'h208; // @[interlink.scala 143:81:@4087.4]
  assign pid_kd_sel = _T_78 & _T_180; // @[interlink.scala 143:66:@4088.4]
  assign _T_190 = reg_offset == 12'h20c; // @[interlink.scala 147:81:@4098.4]
  assign pid_ref_sel = _T_78 & _T_190; // @[interlink.scala 147:66:@4099.4]
  assign _T_200 = reg_offset == 12'h210; // @[interlink.scala 151:81:@4109.4]
  assign pid_fb_sel = _T_78 & _T_200; // @[interlink.scala 151:66:@4110.4]
  assign _T_210 = reg_offset == 12'h214; // @[interlink.scala 155:81:@4120.4]
  assign pid_cfg_sel = _T_78 & _T_210; // @[interlink.scala 155:66:@4121.4]
  assign _T_217 = pid_kp_sel | pid_ki_sel; // @[interlink.scala 158:34:@4129.4]
  assign _T_218 = _T_217 | pid_kd_sel; // @[interlink.scala 158:48:@4130.4]
  assign _T_219 = _T_218 | pid_ref_sel; // @[interlink.scala 158:62:@4131.4]
  assign _T_220 = _T_219 | pid_fb_sel; // @[interlink.scala 158:77:@4132.4]
  assign pid_sel = _T_220 | pid_cfg_sel; // @[interlink.scala 158:91:@4133.4]
  assign _T_221 = pid_fb_sel ? $signed(io_pid_fb_do) : $signed(io_pid_cfg_do); // @[interlink.scala 162:46:@4134.4]
  assign _T_222 = pid_ref_sel ? $signed(io_pid_ref_do) : $signed(_T_221); // @[interlink.scala 161:46:@4135.4]
  assign _T_223 = pid_kd_sel ? $signed(io_pid_kd_do) : $signed(_T_222); // @[interlink.scala 160:46:@4136.4]
  assign _T_224 = pid_ki_sel ? $signed(io_pid_ki_do) : $signed(_T_223); // @[interlink.scala 159:53:@4137.4]
  assign pid_do = pid_kp_sel ? $signed(io_pid_kp_do) : $signed(_T_224); // @[interlink.scala 159:26:@4138.4]
  assign _T_229 = $unsigned(pid_do); // @[interlink.scala 167:92:@4141.4]
  assign _T_231 = pid_sel ? _T_229 : 16'h0; // @[interlink.scala 167:69:@4142.4]
  assign _T_232 = qei_sel ? qei_do : {{16'd0}, _T_231}; // @[interlink.scala 167:48:@4143.4]
  assign _T_233 = tmr_sel ? tmr_do : _T_232; // @[interlink.scala 167:27:@4144.4]
  assign _T_234 = tmr_sel | qei_sel; // @[interlink.scala 168:32:@4146.4]
  assign _T_235 = _T_234 | pid_sel; // @[interlink.scala 168:43:@4147.4]
  assign io_bus_ack_o = wb_ack_o; // @[interlink.scala 171:21:@4150.4]
  assign io_bus_dat_o = wb_data_o; // @[interlink.scala 170:21:@4149.4]
  assign io_tmr_val_we = tmr_val_sel ? _T_95 : 1'h0; // @[interlink.scala 174:21:@4151.4]
  assign io_tmr_dat_we = tmr_dat_sel ? _T_95 : 1'h0; // @[interlink.scala 176:21:@4153.4]
  assign io_tmr_duty_we = tmr_duty_sel ? _T_95 : 1'h0; // @[interlink.scala 178:21:@4155.4]
  assign io_tmr_cfg_we = tmr_cfg_sel ? _T_95 : 1'h0; // @[interlink.scala 180:21:@4157.4]
  assign io_qei_count_we = qei_count_sel ? _T_95 : 1'h0; // @[interlink.scala 183:21:@4159.4]
  assign io_qei_cfg_we = qei_cfg_sel ? _T_95 : 1'h0; // @[interlink.scala 185:21:@4161.4]
  assign io_pid_kp_we = pid_kp_sel ? _T_95 : 1'h0; // @[interlink.scala 189:21:@4165.4]
  assign io_pid_ki_we = pid_ki_sel ? _T_95 : 1'h0; // @[interlink.scala 191:21:@4167.4]
  assign io_pid_kd_we = pid_kd_sel ? _T_95 : 1'h0; // @[interlink.scala 193:21:@4169.4]
  assign io_pid_ref_we = pid_ref_sel ? _T_95 : 1'h0; // @[interlink.scala 195:21:@4171.4]
  assign io_pid_fb_we = pid_fb_sel ? _T_95 : 1'h0; // @[interlink.scala 197:21:@4173.4]
  assign io_pid_cfg_we = pid_cfg_sel ? _T_95 : 1'h0; // @[interlink.scala 199:21:@4175.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  wb_ack_o = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  wb_data_o = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      wb_ack_o <= 1'h0;
    end else begin
      wb_ack_o <= _T_235;
    end
    if (reset) begin
      wb_data_o <= 32'h0;
    end else begin
      if (tmr_sel) begin
        if (tmr_cfg_sel) begin
          wb_data_o <= io_tmr_cfg_do;
        end else begin
          if (tmr_val_sel) begin
            wb_data_o <= io_tmr_val_do;
          end else begin
            if (tmr_duty_sel) begin
              wb_data_o <= io_tmr_duty_do;
            end else begin
              wb_data_o <= io_tmr_dat_do;
            end
          end
        end
      end else begin
        if (qei_sel) begin
          if (qei_speed_sel) begin
            wb_data_o <= qei_speed_do;
          end else begin
            if (qei_cfg_sel) begin
              wb_data_o <= io_qei_cfg_do;
            end else begin
              wb_data_o <= io_qei_count_do;
            end
          end
        end else begin
          wb_data_o <= {{16'd0}, _T_231};
        end
      end
    end
  end
endmodule
module PWM( // @[:@4178.2]
  input         clock, // @[:@4179.4]
  input         reset, // @[:@4180.4]
  input         io_reg_val_we, // @[:@4181.4]
  input  [31:0] io_reg_val_di, // @[:@4181.4]
  output [31:0] io_reg_val_do, // @[:@4181.4]
  input         io_reg_cfg_we, // @[:@4181.4]
  input  [31:0] io_reg_cfg_di, // @[:@4181.4]
  output [31:0] io_reg_cfg_do, // @[:@4181.4]
  input         io_reg_dat_we, // @[:@4181.4]
  input  [31:0] io_reg_dat_di, // @[:@4181.4]
  output [31:0] io_reg_dat_do, // @[:@4181.4]
  input         io_reg_duty_we, // @[:@4181.4]
  input  [31:0] io_reg_duty_di, // @[:@4181.4]
  output [31:0] io_reg_duty_do, // @[:@4181.4]
  input  [15:0] io_reg_pid_out, // @[:@4181.4]
  output        io_pwm_h, // @[:@4181.4]
  output        io_pwm_l, // @[:@4181.4]
  output        io_irq_out, // @[:@4181.4]
  output        io_rawirq_out // @[:@4181.4]
);
  reg [31:0] value_cur; // @[pwm.scala 44:32:@4183.4]
  reg [31:0] _RAND_0;
  reg [31:0] value_reload; // @[pwm.scala 45:32:@4184.4]
  reg [31:0] _RAND_1;
  reg [31:0] pwm_duty; // @[pwm.scala 46:32:@4185.4]
  reg [31:0] _RAND_2;
  reg [31:0] reg_duty; // @[pwm.scala 47:32:@4186.4]
  reg [31:0] _RAND_3;
  reg  enable; // @[pwm.scala 54:32:@4190.4]
  reg [31:0] _RAND_4;
  reg  stop_out; // @[pwm.scala 56:32:@4191.4]
  reg [31:0] _RAND_5;
  reg  irq_out; // @[pwm.scala 57:32:@4192.4]
  reg [31:0] _RAND_6;
  reg  lastenable; // @[pwm.scala 60:28:@4193.4]
  reg [31:0] _RAND_7;
  reg  updown; // @[pwm.scala 63:32:@4194.4]
  reg [31:0] _RAND_8;
  reg  irq_ena; // @[pwm.scala 66:32:@4195.4]
  reg [31:0] _RAND_9;
  reg  pid_out_sel; // @[pwm.scala 69:32:@4196.4]
  reg [31:0] _RAND_10;
  reg [3:0] pwm_db; // @[pwm.scala 72:32:@4197.4]
  reg [31:0] _RAND_11;
  wire [31:0] _GEN_0; // @[pwm.scala 76:24:@4199.4]
  wire [15:0] _T_65; // @[pwm.scala 82:40:@4204.8]
  wire [31:0] _GEN_1; // @[pwm.scala 81:22:@4203.6]
  wire [31:0] _GEN_2; // @[pwm.scala 80:18:@4202.4]
  reg [31:0] proc_offset; // @[pwm.scala 88:24:@4211.4]
  reg [31:0] _RAND_12;
  reg  pwm_ld; // @[pwm.scala 89:24:@4212.4]
  reg [31:0] _RAND_13;
  reg  pwm_hd; // @[pwm.scala 90:24:@4213.4]
  reg [31:0] _RAND_14;
  wire [4:0] _GEN_25; // @[pwm.scala 93:30:@4214.4]
  wire [4:0] pwm_db_twice; // @[pwm.scala 93:30:@4214.4]
  wire [31:0] _GEN_26; // @[pwm.scala 95:37:@4215.4]
  wire  _T_70; // @[pwm.scala 95:37:@4215.4]
  wire [32:0] _T_71; // @[pwm.scala 95:84:@4216.4]
  wire [32:0] _T_72; // @[pwm.scala 95:84:@4217.4]
  wire [31:0] _T_73; // @[pwm.scala 95:84:@4218.4]
  wire  _T_74; // @[pwm.scala 95:67:@4219.4]
  wire  _T_75; // @[pwm.scala 95:54:@4220.4]
  wire  _T_76; // @[pwm.scala 96:36:@4221.4]
  wire [31:0] _T_80; // @[pwm.scala 96:26:@4225.4]
  wire [31:0] _GEN_30; // @[pwm.scala 97:48:@4228.4]
  wire [32:0] _T_82; // @[pwm.scala 97:48:@4228.4]
  wire [32:0] _T_83; // @[pwm.scala 97:48:@4229.4]
  wire [31:0] _T_84; // @[pwm.scala 97:48:@4230.4]
  wire  _T_86; // @[pwm.scala 98:34:@4233.4]
  wire [32:0] _T_87; // @[pwm.scala 98:79:@4234.4]
  wire [32:0] _T_88; // @[pwm.scala 98:79:@4235.4]
  wire [31:0] _T_89; // @[pwm.scala 98:79:@4236.4]
  wire  _T_90; // @[pwm.scala 98:63:@4237.4]
  wire  _T_94; // @[pwm.scala 104:34:@4245.4]
  wire  _T_95; // @[pwm.scala 104:32:@4246.4]
  wire [2:0] _T_99; // @[Cat.scala 30:58:@4250.4]
  wire [28:0] _T_101; // @[Cat.scala 30:58:@4252.4]
  wire  _T_103; // @[pwm.scala 109:35:@4256.6]
  wire  _T_104; // @[pwm.scala 110:35:@4258.6]
  wire  _T_105; // @[pwm.scala 111:35:@4260.6]
  wire  _T_106; // @[pwm.scala 112:35:@4262.6]
  wire [3:0] _T_107; // @[pwm.scala 113:36:@4264.6]
  wire [4:0] _T_109; // @[pwm.scala 113:42:@4265.6]
  wire [3:0] _T_110; // @[pwm.scala 113:42:@4266.6]
  wire  _GEN_3; // @[pwm.scala 108:23:@4255.4]
  wire  _GEN_4; // @[pwm.scala 108:23:@4255.4]
  wire  _GEN_5; // @[pwm.scala 108:23:@4255.4]
  wire  _GEN_6; // @[pwm.scala 108:23:@4255.4]
  wire [3:0] _GEN_7; // @[pwm.scala 108:23:@4255.4]
  wire [31:0] _GEN_8; // @[pwm.scala 118:29:@4271.4]
  wire [32:0] _T_114; // @[pwm.scala 124:39:@4275.4]
  wire [31:0] value_cur_plus; // @[pwm.scala 124:39:@4276.4]
  wire [32:0] _T_117; // @[pwm.scala 125:39:@4278.4]
  wire [32:0] _T_118; // @[pwm.scala 125:39:@4279.4]
  wire [31:0] value_cur_minus; // @[pwm.scala 125:39:@4280.4]
  wire  _T_127; // @[pwm.scala 135:23:@4293.8]
  wire  _T_131; // @[pwm.scala 138:25:@4297.10]
  wire  _T_134; // @[pwm.scala 143:33:@4303.12]
  wire [31:0] _GEN_9; // @[pwm.scala 143:58:@4304.12]
  wire [31:0] _GEN_11; // @[pwm.scala 138:38:@4298.10]
  wire  _GEN_12; // @[pwm.scala 138:38:@4298.10]
  wire  _T_142; // @[pwm.scala 158:35:@4321.12]
  wire [31:0] _GEN_13; // @[pwm.scala 158:50:@4322.12]
  wire [31:0] _GEN_15; // @[pwm.scala 153:38:@4316.10]
  wire  _GEN_16; // @[pwm.scala 153:38:@4316.10]
  wire [31:0] _GEN_17; // @[pwm.scala 137:31:@4296.8]
  wire  _GEN_18; // @[pwm.scala 137:31:@4296.8]
  wire  _GEN_19; // @[pwm.scala 132:39:@4290.6]
  wire [31:0] _GEN_20; // @[pwm.scala 132:39:@4290.6]
  wire  _GEN_21; // @[pwm.scala 132:39:@4290.6]
  wire [31:0] _GEN_22; // @[pwm.scala 130:29:@4285.4]
  wire  _GEN_23; // @[pwm.scala 130:29:@4285.4]
  wire  _GEN_24; // @[pwm.scala 130:29:@4285.4]
  assign _GEN_0 = io_reg_duty_we ? io_reg_duty_di : reg_duty; // @[pwm.scala 76:24:@4199.4]
  assign _T_65 = $unsigned(io_reg_pid_out); // @[pwm.scala 82:40:@4204.8]
  assign _GEN_1 = pid_out_sel ? {{16'd0}, _T_65} : reg_duty; // @[pwm.scala 81:22:@4203.6]
  assign _GEN_2 = stop_out ? _GEN_1 : pwm_duty; // @[pwm.scala 80:18:@4202.4]
  assign _GEN_25 = {{1'd0}, pwm_db}; // @[pwm.scala 93:30:@4214.4]
  assign pwm_db_twice = _GEN_25 << 1'h1; // @[pwm.scala 93:30:@4214.4]
  assign _GEN_26 = {{27'd0}, pwm_db_twice}; // @[pwm.scala 95:37:@4215.4]
  assign _T_70 = pwm_duty >= _GEN_26; // @[pwm.scala 95:37:@4215.4]
  assign _T_71 = value_reload - _GEN_26; // @[pwm.scala 95:84:@4216.4]
  assign _T_72 = $unsigned(_T_71); // @[pwm.scala 95:84:@4217.4]
  assign _T_73 = _T_72[31:0]; // @[pwm.scala 95:84:@4218.4]
  assign _T_74 = pwm_duty <= _T_73; // @[pwm.scala 95:67:@4219.4]
  assign _T_75 = _T_70 & _T_74; // @[pwm.scala 95:54:@4220.4]
  assign _T_76 = pwm_duty < _GEN_26; // @[pwm.scala 96:36:@4221.4]
  assign _T_80 = _T_76 ? {{27'd0}, pwm_db_twice} : _T_73; // @[pwm.scala 96:26:@4225.4]
  assign _GEN_30 = {{28'd0}, pwm_db}; // @[pwm.scala 97:48:@4228.4]
  assign _T_82 = proc_offset - _GEN_30; // @[pwm.scala 97:48:@4228.4]
  assign _T_83 = $unsigned(_T_82); // @[pwm.scala 97:48:@4229.4]
  assign _T_84 = _T_83[31:0]; // @[pwm.scala 97:48:@4230.4]
  assign _T_86 = value_cur > proc_offset; // @[pwm.scala 98:34:@4233.4]
  assign _T_87 = value_reload - _GEN_30; // @[pwm.scala 98:79:@4234.4]
  assign _T_88 = $unsigned(_T_87); // @[pwm.scala 98:79:@4235.4]
  assign _T_89 = _T_88[31:0]; // @[pwm.scala 98:79:@4236.4]
  assign _T_90 = value_cur < _T_89; // @[pwm.scala 98:63:@4237.4]
  assign _T_94 = ~ irq_out; // @[pwm.scala 104:34:@4245.4]
  assign _T_95 = stop_out & _T_94; // @[pwm.scala 104:32:@4246.4]
  assign _T_99 = {irq_ena,updown,enable}; // @[Cat.scala 30:58:@4250.4]
  assign _T_101 = {24'h0,pwm_db,pid_out_sel}; // @[Cat.scala 30:58:@4252.4]
  assign _T_103 = io_reg_cfg_di[0]; // @[pwm.scala 109:35:@4256.6]
  assign _T_104 = io_reg_cfg_di[1]; // @[pwm.scala 110:35:@4258.6]
  assign _T_105 = io_reg_cfg_di[2]; // @[pwm.scala 111:35:@4260.6]
  assign _T_106 = io_reg_cfg_di[3]; // @[pwm.scala 112:35:@4262.6]
  assign _T_107 = io_reg_cfg_di[7:4]; // @[pwm.scala 113:36:@4264.6]
  assign _T_109 = _T_107 + 4'h2; // @[pwm.scala 113:42:@4265.6]
  assign _T_110 = _T_107 + 4'h2; // @[pwm.scala 113:42:@4266.6]
  assign _GEN_3 = io_reg_cfg_we ? _T_103 : enable; // @[pwm.scala 108:23:@4255.4]
  assign _GEN_4 = io_reg_cfg_we ? _T_104 : updown; // @[pwm.scala 108:23:@4255.4]
  assign _GEN_5 = io_reg_cfg_we ? _T_105 : irq_ena; // @[pwm.scala 108:23:@4255.4]
  assign _GEN_6 = io_reg_cfg_we ? _T_106 : pid_out_sel; // @[pwm.scala 108:23:@4255.4]
  assign _GEN_7 = io_reg_cfg_we ? _T_110 : pwm_db; // @[pwm.scala 108:23:@4255.4]
  assign _GEN_8 = io_reg_val_we ? io_reg_val_di : value_reload; // @[pwm.scala 118:29:@4271.4]
  assign _T_114 = value_cur + 32'h1; // @[pwm.scala 124:39:@4275.4]
  assign value_cur_plus = value_cur + 32'h1; // @[pwm.scala 124:39:@4276.4]
  assign _T_117 = value_cur - 32'h1; // @[pwm.scala 125:39:@4278.4]
  assign _T_118 = $unsigned(_T_117); // @[pwm.scala 125:39:@4279.4]
  assign value_cur_minus = _T_118[31:0]; // @[pwm.scala 125:39:@4280.4]
  assign _T_127 = irq_ena ? _T_95 : 1'h0; // @[pwm.scala 135:23:@4293.8]
  assign _T_131 = lastenable == 1'h0; // @[pwm.scala 138:25:@4297.10]
  assign _T_134 = value_cur == value_reload; // @[pwm.scala 143:33:@4303.12]
  assign _GEN_9 = _T_134 ? 32'h0 : value_cur_plus; // @[pwm.scala 143:58:@4304.12]
  assign _GEN_11 = _T_131 ? 32'h0 : _GEN_9; // @[pwm.scala 138:38:@4298.10]
  assign _GEN_12 = _T_131 ? 1'h0 : _T_134; // @[pwm.scala 138:38:@4298.10]
  assign _T_142 = value_cur == 32'h0; // @[pwm.scala 158:35:@4321.12]
  assign _GEN_13 = _T_142 ? value_reload : value_cur_minus; // @[pwm.scala 158:50:@4322.12]
  assign _GEN_15 = _T_131 ? value_reload : _GEN_13; // @[pwm.scala 153:38:@4316.10]
  assign _GEN_16 = _T_131 ? 1'h0 : _T_142; // @[pwm.scala 153:38:@4316.10]
  assign _GEN_17 = updown ? _GEN_11 : _GEN_15; // @[pwm.scala 137:31:@4296.8]
  assign _GEN_18 = updown ? _GEN_12 : _GEN_16; // @[pwm.scala 137:31:@4296.8]
  assign _GEN_19 = enable ? _T_127 : irq_out; // @[pwm.scala 132:39:@4290.6]
  assign _GEN_20 = enable ? _GEN_17 : value_cur; // @[pwm.scala 132:39:@4290.6]
  assign _GEN_21 = enable ? _GEN_18 : stop_out; // @[pwm.scala 132:39:@4290.6]
  assign _GEN_22 = io_reg_dat_we ? io_reg_dat_di : _GEN_20; // @[pwm.scala 130:29:@4285.4]
  assign _GEN_23 = io_reg_dat_we ? irq_out : _GEN_19; // @[pwm.scala 130:29:@4285.4]
  assign _GEN_24 = io_reg_dat_we ? stop_out : _GEN_21; // @[pwm.scala 130:29:@4285.4]
  assign io_reg_val_do = value_reload; // @[pwm.scala 117:19:@4269.4]
  assign io_reg_cfg_do = {_T_101,_T_99}; // @[pwm.scala 107:20:@4254.4]
  assign io_reg_dat_do = value_cur; // @[pwm.scala 123:19:@4274.4]
  assign io_reg_duty_do = pwm_duty; // @[pwm.scala 75:23:@4198.4]
  assign io_pwm_h = pwm_hd & enable; // @[pwm.scala 99:20:@4241.4]
  assign io_pwm_l = pwm_ld & enable; // @[pwm.scala 100:20:@4243.4]
  assign io_irq_out = irq_out; // @[pwm.scala 103:20:@4244.4]
  assign io_rawirq_out = stop_out & _T_94; // @[pwm.scala 104:20:@4247.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value_cur = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  value_reload = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  pwm_duty = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  reg_duty = _RAND_3[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  enable = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  stop_out = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  irq_out = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  lastenable = _RAND_7[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  updown = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  irq_ena = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  pid_out_sel = _RAND_10[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  pwm_db = _RAND_11[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  proc_offset = _RAND_12[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  pwm_ld = _RAND_13[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  pwm_hd = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      value_cur <= 32'h0;
    end else begin
      if (io_reg_dat_we) begin
        value_cur <= io_reg_dat_di;
      end else begin
        if (enable) begin
          if (updown) begin
            if (_T_131) begin
              value_cur <= 32'h0;
            end else begin
              if (_T_134) begin
                value_cur <= 32'h0;
              end else begin
                value_cur <= value_cur_plus;
              end
            end
          end else begin
            if (_T_131) begin
              value_cur <= value_reload;
            end else begin
              if (_T_142) begin
                value_cur <= value_reload;
              end else begin
                value_cur <= value_cur_minus;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      value_reload <= 32'hff;
    end else begin
      if (io_reg_val_we) begin
        value_reload <= io_reg_val_di;
      end
    end
    if (reset) begin
      pwm_duty <= 32'h0;
    end else begin
      if (stop_out) begin
        if (pid_out_sel) begin
          pwm_duty <= {{16'd0}, _T_65};
        end else begin
          pwm_duty <= reg_duty;
        end
      end
    end
    if (reset) begin
      reg_duty <= 32'h0;
    end else begin
      if (io_reg_duty_we) begin
        reg_duty <= io_reg_duty_di;
      end
    end
    if (reset) begin
      enable <= 1'h0;
    end else begin
      if (io_reg_cfg_we) begin
        enable <= _T_103;
      end
    end
    if (reset) begin
      stop_out <= 1'h0;
    end else begin
      if (!(io_reg_dat_we)) begin
        if (enable) begin
          if (updown) begin
            if (_T_131) begin
              stop_out <= 1'h0;
            end else begin
              stop_out <= _T_134;
            end
          end else begin
            if (_T_131) begin
              stop_out <= 1'h0;
            end else begin
              stop_out <= _T_142;
            end
          end
        end
      end
    end
    if (reset) begin
      irq_out <= 1'h0;
    end else begin
      if (!(io_reg_dat_we)) begin
        if (enable) begin
          if (irq_ena) begin
            irq_out <= _T_95;
          end else begin
            irq_out <= 1'h0;
          end
        end
      end
    end
    lastenable <= enable;
    if (reset) begin
      updown <= 1'h0;
    end else begin
      if (io_reg_cfg_we) begin
        updown <= _T_104;
      end
    end
    if (reset) begin
      irq_ena <= 1'h0;
    end else begin
      if (io_reg_cfg_we) begin
        irq_ena <= _T_105;
      end
    end
    if (reset) begin
      pid_out_sel <= 1'h0;
    end else begin
      if (io_reg_cfg_we) begin
        pid_out_sel <= _T_106;
      end
    end
    if (reset) begin
      pwm_db <= 4'h2;
    end else begin
      if (io_reg_cfg_we) begin
        pwm_db <= _T_110;
      end
    end
    if (_T_75) begin
      proc_offset <= pwm_duty;
    end else begin
      if (_T_76) begin
        proc_offset <= {{27'd0}, pwm_db_twice};
      end else begin
        proc_offset <= _T_73;
      end
    end
    pwm_ld <= _T_86 & _T_90;
    pwm_hd <= value_cur < _T_84;
  end
endmodule
module Quad_Encoder( // @[:@4334.2]
  input         clock, // @[:@4335.4]
  input         reset, // @[:@4336.4]
  input         io_quad_a, // @[:@4337.4]
  input         io_quad_b, // @[:@4337.4]
  input         io_raw_irq, // @[:@4337.4]
  input         io_reg_count_we, // @[:@4337.4]
  input  [31:0] io_reg_count_di, // @[:@4337.4]
  output [31:0] io_reg_count_do, // @[:@4337.4]
  input         io_reg_cfg_we, // @[:@4337.4]
  input  [31:0] io_reg_cfg_di, // @[:@4337.4]
  output [31:0] io_reg_cfg_do, // @[:@4337.4]
  output [15:0] io_reg_speed_do, // @[:@4337.4]
  output        io_fb_period // @[:@4337.4]
);
  reg [2:0] quad_a_delayed; // @[qei.scala 35:33:@4339.4]
  reg [31:0] _RAND_0;
  reg [2:0] quad_b_delayed; // @[qei.scala 36:33:@4340.4]
  reg [31:0] _RAND_1;
  reg [31:0] count_reg; // @[qei.scala 37:33:@4341.4]
  reg [31:0] _RAND_2;
  reg [15:0] count_reg_2; // @[qei.scala 38:33:@4342.4]
  reg [31:0] _RAND_3;
  reg [15:0] period_count; // @[qei.scala 39:33:@4343.4]
  reg [31:0] _RAND_4;
  reg  speed_enable; // @[qei.scala 41:33:@4344.4]
  reg [31:0] _RAND_5;
  reg  count_sel_2x; // @[qei.scala 42:33:@4345.4]
  reg [31:0] _RAND_6;
  reg [15:0] qei_output; // @[qei.scala 44:33:@4347.4]
  reg [31:0] _RAND_7;
  reg [15:0] qei_speed_count; // @[qei.scala 45:33:@4348.4]
  reg [31:0] _RAND_8;
  reg [15:0] qei_period_count; // @[qei.scala 46:33:@4349.4]
  reg [31:0] _RAND_9;
  reg  period_sel; // @[qei.scala 47:33:@4350.4]
  reg [31:0] _RAND_10;
  wire  _T_51; // @[qei.scala 51:44:@4352.4]
  wire  _T_52; // @[qei.scala 51:63:@4353.4]
  wire [2:0] _T_54; // @[Cat.scala 30:58:@4355.4]
  wire  _T_55; // @[qei.scala 52:44:@4357.4]
  wire  _T_56; // @[qei.scala 52:63:@4358.4]
  wire [2:0] _T_58; // @[Cat.scala 30:58:@4360.4]
  wire  _T_61; // @[qei.scala 54:75:@4363.4]
  wire  count_2x; // @[qei.scala 54:60:@4364.4]
  wire  _T_68; // @[qei.scala 55:78:@4371.4]
  wire  _T_69; // @[qei.scala 55:111:@4372.4]
  wire  count_4x; // @[qei.scala 55:96:@4373.4]
  wire  count_direction; // @[qei.scala 56:60:@4378.4]
  wire  count_pulses; // @[qei.scala 57:29:@4381.4]
  wire [32:0] _T_76; // @[qei.scala 64:36:@4384.8]
  wire [31:0] _T_77; // @[qei.scala 64:36:@4385.8]
  wire [32:0] _T_79; // @[qei.scala 66:36:@4389.8]
  wire [32:0] _T_80; // @[qei.scala 66:36:@4390.8]
  wire [31:0] _T_81; // @[qei.scala 66:36:@4391.8]
  wire [31:0] _GEN_0; // @[qei.scala 63:27:@4383.6]
  wire [31:0] _GEN_1; // @[qei.scala 62:22:@4382.4]
  wire  _T_82; // @[qei.scala 71:20:@4395.4]
  wire [16:0] _T_85; // @[qei.scala 76:38:@4402.8]
  wire [15:0] _T_86; // @[qei.scala 76:38:@4403.8]
  wire [15:0] _GEN_2; // @[qei.scala 72:23:@4397.6]
  wire [15:0] _GEN_3; // @[qei.scala 72:23:@4397.6]
  wire [15:0] _GEN_4; // @[qei.scala 71:37:@4396.4]
  wire [15:0] _GEN_5; // @[qei.scala 71:37:@4396.4]
  wire  _T_89; // @[qei.scala 85:29:@4413.8]
  wire [16:0] _T_92; // @[qei.scala 89:40:@4419.10]
  wire [15:0] _T_93; // @[qei.scala 89:40:@4420.10]
  wire [15:0] _GEN_6; // @[qei.scala 85:40:@4414.8]
  wire [15:0] _GEN_7; // @[qei.scala 85:40:@4414.8]
  wire [15:0] _GEN_8; // @[qei.scala 82:24:@4408.6]
  wire [15:0] _GEN_9; // @[qei.scala 82:24:@4408.6]
  wire [15:0] _GEN_10; // @[qei.scala 81:20:@4407.4]
  wire [15:0] _GEN_11; // @[qei.scala 81:20:@4407.4]
  wire [15:0] _T_94; // @[qei.scala 94:30:@4424.4]
  wire [1:0] _T_96; // @[Cat.scala 30:58:@4426.4]
  wire [29:0] _T_97; // @[Cat.scala 30:58:@4427.4]
  wire  _T_101; // @[qei.scala 106:40:@4439.8]
  wire  _T_102; // @[qei.scala 107:40:@4441.8]
  wire  _T_103; // @[qei.scala 108:40:@4443.8]
  wire  _GEN_12; // @[qei.scala 105:28:@4438.6]
  wire  _GEN_13; // @[qei.scala 105:28:@4438.6]
  wire  _GEN_14; // @[qei.scala 105:28:@4438.6]
  wire [31:0] _GEN_15; // @[qei.scala 103:25:@4434.4]
  wire  _GEN_16; // @[qei.scala 103:25:@4434.4]
  wire  _GEN_17; // @[qei.scala 103:25:@4434.4]
  wire  _GEN_18; // @[qei.scala 103:25:@4434.4]
  assign _T_51 = quad_a_delayed[1]; // @[qei.scala 51:44:@4352.4]
  assign _T_52 = quad_a_delayed[0]; // @[qei.scala 51:63:@4353.4]
  assign _T_54 = {_T_51,_T_52,io_quad_a}; // @[Cat.scala 30:58:@4355.4]
  assign _T_55 = quad_b_delayed[1]; // @[qei.scala 52:44:@4357.4]
  assign _T_56 = quad_b_delayed[0]; // @[qei.scala 52:63:@4358.4]
  assign _T_58 = {_T_55,_T_56,io_quad_b}; // @[Cat.scala 30:58:@4360.4]
  assign _T_61 = quad_a_delayed[2]; // @[qei.scala 54:75:@4363.4]
  assign count_2x = _T_51 ^ _T_61; // @[qei.scala 54:60:@4364.4]
  assign _T_68 = count_2x ^ _T_55; // @[qei.scala 55:78:@4371.4]
  assign _T_69 = quad_b_delayed[2]; // @[qei.scala 55:111:@4372.4]
  assign count_4x = _T_68 ^ _T_69; // @[qei.scala 55:96:@4373.4]
  assign count_direction = _T_51 ^ _T_69; // @[qei.scala 56:60:@4378.4]
  assign count_pulses = count_sel_2x ? count_2x : count_4x; // @[qei.scala 57:29:@4381.4]
  assign _T_76 = count_reg + 32'h1; // @[qei.scala 64:36:@4384.8]
  assign _T_77 = count_reg + 32'h1; // @[qei.scala 64:36:@4385.8]
  assign _T_79 = count_reg - 32'h1; // @[qei.scala 66:36:@4389.8]
  assign _T_80 = $unsigned(_T_79); // @[qei.scala 66:36:@4390.8]
  assign _T_81 = _T_80[31:0]; // @[qei.scala 66:36:@4391.8]
  assign _GEN_0 = count_direction ? _T_77 : _T_81; // @[qei.scala 63:27:@4383.6]
  assign _GEN_1 = count_pulses ? _GEN_0 : count_reg; // @[qei.scala 62:22:@4382.4]
  assign _T_82 = io_raw_irq | count_pulses; // @[qei.scala 71:20:@4395.4]
  assign _T_85 = count_reg_2 + 16'h1; // @[qei.scala 76:38:@4402.8]
  assign _T_86 = count_reg_2 + 16'h1; // @[qei.scala 76:38:@4403.8]
  assign _GEN_2 = io_raw_irq ? count_reg_2 : qei_speed_count; // @[qei.scala 72:23:@4397.6]
  assign _GEN_3 = io_raw_irq ? 16'h0 : _T_86; // @[qei.scala 72:23:@4397.6]
  assign _GEN_4 = _T_82 ? _GEN_2 : qei_speed_count; // @[qei.scala 71:37:@4396.4]
  assign _GEN_5 = _T_82 ? _GEN_3 : count_reg_2; // @[qei.scala 71:37:@4396.4]
  assign _T_89 = period_count == 16'hff; // @[qei.scala 85:29:@4413.8]
  assign _T_92 = period_count + 16'h1; // @[qei.scala 89:40:@4419.10]
  assign _T_93 = period_count + 16'h1; // @[qei.scala 89:40:@4420.10]
  assign _GEN_6 = _T_89 ? period_count : qei_period_count; // @[qei.scala 85:40:@4414.8]
  assign _GEN_7 = _T_89 ? 16'h0 : _T_93; // @[qei.scala 85:40:@4414.8]
  assign _GEN_8 = count_pulses ? period_count : _GEN_6; // @[qei.scala 82:24:@4408.6]
  assign _GEN_9 = count_pulses ? 16'h0 : _GEN_7; // @[qei.scala 82:24:@4408.6]
  assign _GEN_10 = period_sel ? _GEN_8 : qei_period_count; // @[qei.scala 81:20:@4407.4]
  assign _GEN_11 = period_sel ? _GEN_9 : period_count; // @[qei.scala 81:20:@4407.4]
  assign _T_94 = period_sel ? qei_period_count : qei_speed_count; // @[qei.scala 94:30:@4424.4]
  assign _T_96 = {speed_enable,count_sel_2x}; // @[Cat.scala 30:58:@4426.4]
  assign _T_97 = {29'h0,period_sel}; // @[Cat.scala 30:58:@4427.4]
  assign _T_101 = io_reg_cfg_di[0]; // @[qei.scala 106:40:@4439.8]
  assign _T_102 = io_reg_cfg_di[1]; // @[qei.scala 107:40:@4441.8]
  assign _T_103 = io_reg_cfg_di[2]; // @[qei.scala 108:40:@4443.8]
  assign _GEN_12 = io_reg_cfg_we ? _T_101 : count_sel_2x; // @[qei.scala 105:28:@4438.6]
  assign _GEN_13 = io_reg_cfg_we ? _T_102 : speed_enable; // @[qei.scala 105:28:@4438.6]
  assign _GEN_14 = io_reg_cfg_we ? _T_103 : period_sel; // @[qei.scala 105:28:@4438.6]
  assign _GEN_15 = io_reg_count_we ? io_reg_count_di : _GEN_1; // @[qei.scala 103:25:@4434.4]
  assign _GEN_16 = io_reg_count_we ? count_sel_2x : _GEN_12; // @[qei.scala 103:25:@4434.4]
  assign _GEN_17 = io_reg_count_we ? speed_enable : _GEN_13; // @[qei.scala 103:25:@4434.4]
  assign _GEN_18 = io_reg_count_we ? period_sel : _GEN_14; // @[qei.scala 103:25:@4434.4]
  assign io_reg_count_do = count_reg; // @[qei.scala 49:23:@4351.4]
  assign io_reg_cfg_do = {_T_97,_T_96}; // @[qei.scala 97:24:@4429.4]
  assign io_reg_speed_do = $signed(qei_output); // @[qei.scala 100:24:@4432.4]
  assign io_fb_period = period_sel; // @[qei.scala 101:24:@4433.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  quad_a_delayed = _RAND_0[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  quad_b_delayed = _RAND_1[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  count_reg = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  count_reg_2 = _RAND_3[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  period_count = _RAND_4[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  speed_enable = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  count_sel_2x = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  qei_output = _RAND_7[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  qei_speed_count = _RAND_8[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  qei_period_count = _RAND_9[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  period_sel = _RAND_10[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      quad_a_delayed <= 3'h0;
    end else begin
      quad_a_delayed <= _T_54;
    end
    if (reset) begin
      quad_b_delayed <= 3'h0;
    end else begin
      quad_b_delayed <= _T_58;
    end
    if (reset) begin
      count_reg <= 32'h0;
    end else begin
      if (io_reg_count_we) begin
        count_reg <= io_reg_count_di;
      end else begin
        if (count_pulses) begin
          if (count_direction) begin
            count_reg <= _T_77;
          end else begin
            count_reg <= _T_81;
          end
        end
      end
    end
    if (reset) begin
      count_reg_2 <= 16'h0;
    end else begin
      if (_T_82) begin
        if (io_raw_irq) begin
          count_reg_2 <= 16'h0;
        end else begin
          count_reg_2 <= _T_86;
        end
      end
    end
    if (reset) begin
      period_count <= 16'h0;
    end else begin
      if (period_sel) begin
        if (count_pulses) begin
          period_count <= 16'h0;
        end else begin
          if (_T_89) begin
            period_count <= 16'h0;
          end else begin
            period_count <= _T_93;
          end
        end
      end
    end
    if (reset) begin
      speed_enable <= 1'h1;
    end else begin
      if (!(io_reg_count_we)) begin
        if (io_reg_cfg_we) begin
          speed_enable <= _T_102;
        end
      end
    end
    if (reset) begin
      count_sel_2x <= 1'h1;
    end else begin
      if (!(io_reg_count_we)) begin
        if (io_reg_cfg_we) begin
          count_sel_2x <= _T_101;
        end
      end
    end
    if (reset) begin
      qei_output <= 16'h0;
    end else begin
      if (period_sel) begin
        qei_output <= qei_period_count;
      end else begin
        qei_output <= qei_speed_count;
      end
    end
    if (reset) begin
      qei_speed_count <= 16'h0;
    end else begin
      if (_T_82) begin
        if (io_raw_irq) begin
          qei_speed_count <= count_reg_2;
        end
      end
    end
    if (reset) begin
      qei_period_count <= 16'h1fff;
    end else begin
      if (period_sel) begin
        if (count_pulses) begin
          qei_period_count <= period_count;
        end else begin
          if (_T_89) begin
            qei_period_count <= period_count;
          end
        end
      end
    end
    if (reset) begin
      period_sel <= 1'h0;
    end else begin
      if (!(io_reg_count_we)) begin
        if (io_reg_cfg_we) begin
          period_sel <= _T_103;
        end
      end
    end
  end
endmodule
module vedic_2x2( // @[:@4447.2]
  input  [1:0] io_a, // @[:@4450.4]
  input  [1:0] io_b, // @[:@4450.4]
  output [3:0] io_c // @[:@4450.4]
);
  wire  _T_11; // @[multiplier.scala 25:21:@4452.4]
  wire  _T_12; // @[multiplier.scala 25:31:@4453.4]
  wire  result0; // @[multiplier.scala 25:25:@4454.4]
  wire  _T_13; // @[multiplier.scala 26:20:@4455.4]
  wire  a1b0; // @[multiplier.scala 26:24:@4457.4]
  wire  _T_16; // @[multiplier.scala 27:30:@4459.4]
  wire  a0b1; // @[multiplier.scala 27:24:@4460.4]
  wire  a1b1; // @[multiplier.scala 28:24:@4463.4]
  wire  result1; // @[multiplier.scala 31:22:@4464.4]
  wire  carry1; // @[multiplier.scala 32:23:@4465.4]
  wire  result2; // @[multiplier.scala 34:22:@4466.4]
  wire  result3; // @[multiplier.scala 35:22:@4467.4]
  wire [1:0] _T_19; // @[Cat.scala 30:58:@4468.4]
  wire [1:0] _T_20; // @[Cat.scala 30:58:@4469.4]
  assign _T_11 = io_a[0]; // @[multiplier.scala 25:21:@4452.4]
  assign _T_12 = io_b[0]; // @[multiplier.scala 25:31:@4453.4]
  assign result0 = _T_11 & _T_12; // @[multiplier.scala 25:25:@4454.4]
  assign _T_13 = io_a[1]; // @[multiplier.scala 26:20:@4455.4]
  assign a1b0 = _T_13 & _T_12; // @[multiplier.scala 26:24:@4457.4]
  assign _T_16 = io_b[1]; // @[multiplier.scala 27:30:@4459.4]
  assign a0b1 = _T_11 & _T_16; // @[multiplier.scala 27:24:@4460.4]
  assign a1b1 = _T_13 & _T_16; // @[multiplier.scala 28:24:@4463.4]
  assign result1 = a1b0 ^ a0b1; // @[multiplier.scala 31:22:@4464.4]
  assign carry1 = a1b0 & a0b1; // @[multiplier.scala 32:23:@4465.4]
  assign result2 = a1b1 ^ carry1; // @[multiplier.scala 34:22:@4466.4]
  assign result3 = a1b1 & carry1; // @[multiplier.scala 35:22:@4467.4]
  assign _T_19 = {result1,result0}; // @[Cat.scala 30:58:@4468.4]
  assign _T_20 = {result3,result2}; // @[Cat.scala 30:58:@4469.4]
  assign io_c = {_T_20,_T_19}; // @[multiplier.scala 37:15:@4471.4]
endmodule
module vedic_4x4( // @[:@4551.2]
  input  [3:0] io_a, // @[:@4554.4]
  input  [3:0] io_b, // @[:@4554.4]
  output [7:0] io_c // @[:@4554.4]
);
  wire [1:0] pp_1_io_a; // @[multiplier.scala 59:25:@4563.4]
  wire [1:0] pp_1_io_b; // @[multiplier.scala 59:25:@4563.4]
  wire [3:0] pp_1_io_c; // @[multiplier.scala 59:25:@4563.4]
  wire [1:0] pp_2_io_a; // @[multiplier.scala 64:25:@4571.4]
  wire [1:0] pp_2_io_b; // @[multiplier.scala 64:25:@4571.4]
  wire [3:0] pp_2_io_c; // @[multiplier.scala 64:25:@4571.4]
  wire [1:0] pp_3_io_a; // @[multiplier.scala 68:25:@4579.4]
  wire [1:0] pp_3_io_b; // @[multiplier.scala 68:25:@4579.4]
  wire [3:0] pp_3_io_c; // @[multiplier.scala 68:25:@4579.4]
  wire [1:0] pp_4_io_a; // @[multiplier.scala 73:25:@4587.4]
  wire [1:0] pp_4_io_b; // @[multiplier.scala 73:25:@4587.4]
  wire [3:0] pp_4_io_c; // @[multiplier.scala 73:25:@4587.4]
  wire [3:0] pp_hl; // @[multiplier.scala 50:24:@4557.4 multiplier.scala 67:18:@4578.4]
  wire [3:0] pp_ll; // @[multiplier.scala 49:24:@4556.4 multiplier.scala 62:18:@4570.4]
  wire [1:0] _T_28; // @[multiplier.scala 79:55:@4596.4]
  wire [3:0] _T_29; // @[Cat.scala 30:58:@4597.4]
  wire [4:0] _T_30; // @[multiplier.scala 79:31:@4598.4]
  wire [3:0] psum_1; // @[multiplier.scala 79:31:@4599.4]
  wire [3:0] pp_hh; // @[multiplier.scala 52:24:@4559.4 multiplier.scala 76:17:@4594.4]
  wire [5:0] _T_34; // @[Cat.scala 30:58:@4602.4]
  wire [3:0] pp_lh; // @[multiplier.scala 51:24:@4558.4 multiplier.scala 71:18:@4586.4]
  wire [5:0] _T_37; // @[Cat.scala 30:58:@4604.4]
  wire [6:0] _T_38; // @[multiplier.scala 80:56:@4605.4]
  wire [5:0] psum_2; // @[multiplier.scala 80:56:@4606.4]
  wire [5:0] _T_42; // @[Cat.scala 30:58:@4609.4]
  wire [6:0] _T_43; // @[multiplier.scala 81:57:@4610.4]
  wire [5:0] psum_3; // @[multiplier.scala 81:57:@4611.4]
  wire [1:0] result1; // @[multiplier.scala 83:22:@4613.4]
  vedic_2x2 pp_1 ( // @[multiplier.scala 59:25:@4563.4]
    .io_a(pp_1_io_a),
    .io_b(pp_1_io_b),
    .io_c(pp_1_io_c)
  );
  vedic_2x2 pp_2 ( // @[multiplier.scala 64:25:@4571.4]
    .io_a(pp_2_io_a),
    .io_b(pp_2_io_b),
    .io_c(pp_2_io_c)
  );
  vedic_2x2 pp_3 ( // @[multiplier.scala 68:25:@4579.4]
    .io_a(pp_3_io_a),
    .io_b(pp_3_io_b),
    .io_c(pp_3_io_c)
  );
  vedic_2x2 pp_4 ( // @[multiplier.scala 73:25:@4587.4]
    .io_a(pp_4_io_a),
    .io_b(pp_4_io_b),
    .io_c(pp_4_io_c)
  );
  assign pp_hl = pp_2_io_c; // @[multiplier.scala 50:24:@4557.4 multiplier.scala 67:18:@4578.4]
  assign pp_ll = pp_1_io_c; // @[multiplier.scala 49:24:@4556.4 multiplier.scala 62:18:@4570.4]
  assign _T_28 = pp_ll[3:2]; // @[multiplier.scala 79:55:@4596.4]
  assign _T_29 = {2'h0,_T_28}; // @[Cat.scala 30:58:@4597.4]
  assign _T_30 = pp_hl + _T_29; // @[multiplier.scala 79:31:@4598.4]
  assign psum_1 = pp_hl + _T_29; // @[multiplier.scala 79:31:@4599.4]
  assign pp_hh = pp_4_io_c; // @[multiplier.scala 52:24:@4559.4 multiplier.scala 76:17:@4594.4]
  assign _T_34 = {pp_hh,2'h0}; // @[Cat.scala 30:58:@4602.4]
  assign pp_lh = pp_3_io_c; // @[multiplier.scala 51:24:@4558.4 multiplier.scala 71:18:@4586.4]
  assign _T_37 = {2'h0,pp_lh}; // @[Cat.scala 30:58:@4604.4]
  assign _T_38 = _T_34 + _T_37; // @[multiplier.scala 80:56:@4605.4]
  assign psum_2 = _T_34 + _T_37; // @[multiplier.scala 80:56:@4606.4]
  assign _T_42 = {2'h0,psum_1}; // @[Cat.scala 30:58:@4609.4]
  assign _T_43 = _T_42 + psum_2; // @[multiplier.scala 81:57:@4610.4]
  assign psum_3 = _T_42 + psum_2; // @[multiplier.scala 81:57:@4611.4]
  assign result1 = pp_ll[1:0]; // @[multiplier.scala 83:22:@4613.4]
  assign io_c = {psum_3,result1}; // @[multiplier.scala 86:15:@4616.4]
  assign pp_1_io_a = io_a[1:0]; // @[multiplier.scala 60:17:@4567.4]
  assign pp_1_io_b = io_b[1:0]; // @[multiplier.scala 61:17:@4569.4]
  assign pp_2_io_a = io_a[3:2]; // @[multiplier.scala 65:17:@4575.4]
  assign pp_2_io_b = io_b[1:0]; // @[multiplier.scala 66:17:@4577.4]
  assign pp_3_io_a = io_a[1:0]; // @[multiplier.scala 69:17:@4583.4]
  assign pp_3_io_b = io_b[3:2]; // @[multiplier.scala 70:17:@4585.4]
  assign pp_4_io_a = io_a[3:2]; // @[multiplier.scala 74:17:@4591.4]
  assign pp_4_io_b = io_b[3:2]; // @[multiplier.scala 75:17:@4593.4]
endmodule
module vedic_8x8( // @[:@5131.2]
  input  [7:0]  io_a, // @[:@5134.4]
  input  [7:0]  io_b, // @[:@5134.4]
  output [15:0] io_c // @[:@5134.4]
);
  wire [3:0] pp_1_io_a; // @[multiplier.scala 166:24:@5144.4]
  wire [3:0] pp_1_io_b; // @[multiplier.scala 166:24:@5144.4]
  wire [7:0] pp_1_io_c; // @[multiplier.scala 166:24:@5144.4]
  wire [3:0] pp_2_io_a; // @[multiplier.scala 171:24:@5152.4]
  wire [3:0] pp_2_io_b; // @[multiplier.scala 171:24:@5152.4]
  wire [7:0] pp_2_io_c; // @[multiplier.scala 171:24:@5152.4]
  wire [3:0] pp_3_io_a; // @[multiplier.scala 176:24:@5160.4]
  wire [3:0] pp_3_io_b; // @[multiplier.scala 176:24:@5160.4]
  wire [7:0] pp_3_io_c; // @[multiplier.scala 176:24:@5160.4]
  wire [3:0] pp_4_io_a; // @[multiplier.scala 181:24:@5168.4]
  wire [3:0] pp_4_io_b; // @[multiplier.scala 181:24:@5168.4]
  wire [7:0] pp_4_io_c; // @[multiplier.scala 181:24:@5168.4]
  wire [15:0] pp_hl; // @[multiplier.scala 155:23:@5137.4 multiplier.scala 174:17:@5159.4]
  wire [7:0] _T_26; // @[multiplier.scala 188:26:@5176.4]
  wire [15:0] pp_ll; // @[multiplier.scala 154:23:@5136.4 multiplier.scala 169:17:@5151.4]
  wire [3:0] _T_28; // @[multiplier.scala 188:56:@5177.4]
  wire [7:0] _T_29; // @[Cat.scala 30:58:@5178.4]
  wire [8:0] _T_30; // @[multiplier.scala 188:32:@5179.4]
  wire [7:0] psum_1; // @[multiplier.scala 188:32:@5180.4]
  wire [15:0] pp_hh; // @[multiplier.scala 157:23:@5139.4 multiplier.scala 184:17:@5175.4]
  wire [7:0] _T_32; // @[multiplier.scala 189:30:@5182.4]
  wire [11:0] _T_34; // @[Cat.scala 30:58:@5183.4]
  wire [15:0] pp_lh; // @[multiplier.scala 156:23:@5138.4 multiplier.scala 179:17:@5167.4]
  wire [7:0] _T_36; // @[multiplier.scala 189:81:@5184.4]
  wire [11:0] _T_37; // @[Cat.scala 30:58:@5185.4]
  wire [12:0] _T_38; // @[multiplier.scala 189:57:@5186.4]
  wire [11:0] psum_2; // @[multiplier.scala 189:57:@5187.4]
  wire [11:0] _T_42; // @[Cat.scala 30:58:@5190.4]
  wire [12:0] _T_43; // @[multiplier.scala 190:58:@5191.4]
  wire [11:0] psum_3; // @[multiplier.scala 190:58:@5192.4]
  wire [3:0] result1; // @[multiplier.scala 192:22:@5194.4]
  vedic_4x4 pp_1 ( // @[multiplier.scala 166:24:@5144.4]
    .io_a(pp_1_io_a),
    .io_b(pp_1_io_b),
    .io_c(pp_1_io_c)
  );
  vedic_4x4 pp_2 ( // @[multiplier.scala 171:24:@5152.4]
    .io_a(pp_2_io_a),
    .io_b(pp_2_io_b),
    .io_c(pp_2_io_c)
  );
  vedic_4x4 pp_3 ( // @[multiplier.scala 176:24:@5160.4]
    .io_a(pp_3_io_a),
    .io_b(pp_3_io_b),
    .io_c(pp_3_io_c)
  );
  vedic_4x4 pp_4 ( // @[multiplier.scala 181:24:@5168.4]
    .io_a(pp_4_io_a),
    .io_b(pp_4_io_b),
    .io_c(pp_4_io_c)
  );
  assign pp_hl = {{8'd0}, pp_2_io_c}; // @[multiplier.scala 155:23:@5137.4 multiplier.scala 174:17:@5159.4]
  assign _T_26 = pp_hl[7:0]; // @[multiplier.scala 188:26:@5176.4]
  assign pp_ll = {{8'd0}, pp_1_io_c}; // @[multiplier.scala 154:23:@5136.4 multiplier.scala 169:17:@5151.4]
  assign _T_28 = pp_ll[7:4]; // @[multiplier.scala 188:56:@5177.4]
  assign _T_29 = {4'h0,_T_28}; // @[Cat.scala 30:58:@5178.4]
  assign _T_30 = _T_26 + _T_29; // @[multiplier.scala 188:32:@5179.4]
  assign psum_1 = _T_26 + _T_29; // @[multiplier.scala 188:32:@5180.4]
  assign pp_hh = {{8'd0}, pp_4_io_c}; // @[multiplier.scala 157:23:@5139.4 multiplier.scala 184:17:@5175.4]
  assign _T_32 = pp_hh[7:0]; // @[multiplier.scala 189:30:@5182.4]
  assign _T_34 = {_T_32,4'h0}; // @[Cat.scala 30:58:@5183.4]
  assign pp_lh = {{8'd0}, pp_3_io_c}; // @[multiplier.scala 156:23:@5138.4 multiplier.scala 179:17:@5167.4]
  assign _T_36 = pp_lh[7:0]; // @[multiplier.scala 189:81:@5184.4]
  assign _T_37 = {4'h0,_T_36}; // @[Cat.scala 30:58:@5185.4]
  assign _T_38 = _T_34 + _T_37; // @[multiplier.scala 189:57:@5186.4]
  assign psum_2 = _T_34 + _T_37; // @[multiplier.scala 189:57:@5187.4]
  assign _T_42 = {4'h0,psum_1}; // @[Cat.scala 30:58:@5190.4]
  assign _T_43 = _T_42 + psum_2; // @[multiplier.scala 190:58:@5191.4]
  assign psum_3 = _T_42 + psum_2; // @[multiplier.scala 190:58:@5192.4]
  assign result1 = pp_ll[3:0]; // @[multiplier.scala 192:22:@5194.4]
  assign io_c = {psum_3,result1}; // @[multiplier.scala 196:15:@5197.4]
  assign pp_1_io_a = io_a[3:0]; // @[multiplier.scala 167:16:@5148.4]
  assign pp_1_io_b = io_b[3:0]; // @[multiplier.scala 168:16:@5150.4]
  assign pp_2_io_a = io_a[7:4]; // @[multiplier.scala 172:16:@5156.4]
  assign pp_2_io_b = io_b[3:0]; // @[multiplier.scala 173:16:@5158.4]
  assign pp_3_io_a = io_a[3:0]; // @[multiplier.scala 177:16:@5164.4]
  assign pp_3_io_b = io_b[7:4]; // @[multiplier.scala 178:16:@5166.4]
  assign pp_4_io_a = io_a[7:4]; // @[multiplier.scala 182:16:@5172.4]
  assign pp_4_io_b = io_b[7:4]; // @[multiplier.scala 183:16:@5174.4]
endmodule
module vedic_16x16( // @[:@6874.2]
  input  [15:0] io_a, // @[:@6877.4]
  input  [15:0] io_b, // @[:@6877.4]
  output [31:0] io_c // @[:@6877.4]
);
  wire [7:0] pp_1_io_a; // @[multiplier.scala 221:32:@6895.4]
  wire [7:0] pp_1_io_b; // @[multiplier.scala 221:32:@6895.4]
  wire [15:0] pp_1_io_c; // @[multiplier.scala 221:32:@6895.4]
  wire [7:0] pp_2_io_a; // @[multiplier.scala 226:32:@6903.4]
  wire [7:0] pp_2_io_b; // @[multiplier.scala 226:32:@6903.4]
  wire [15:0] pp_2_io_c; // @[multiplier.scala 226:32:@6903.4]
  wire [7:0] pp_3_io_a; // @[multiplier.scala 231:32:@6911.4]
  wire [7:0] pp_3_io_b; // @[multiplier.scala 231:32:@6911.4]
  wire [15:0] pp_3_io_c; // @[multiplier.scala 231:32:@6911.4]
  wire [3:0] pp_4_io_a; // @[multiplier.scala 236:32:@6919.4]
  wire [3:0] pp_4_io_b; // @[multiplier.scala 236:32:@6919.4]
  wire [7:0] pp_4_io_c; // @[multiplier.scala 236:32:@6919.4]
  wire [15:0] _T_18; // @[multiplier.scala 217:25:@6886.4]
  wire [15:0] _T_19; // @[multiplier.scala 217:25:@6887.4]
  wire [15:0] _T_20; // @[multiplier.scala 217:38:@6888.4]
  wire [16:0] _T_22; // @[multiplier.scala 217:41:@6889.4]
  wire [15:0] in1_complement; // @[multiplier.scala 217:41:@6890.4]
  wire  _T_23; // @[multiplier.scala 218:32:@6891.4]
  wire [15:0] _T_25; // @[multiplier.scala 218:64:@6893.4]
  wire [15:0] input1; // @[multiplier.scala 218:27:@6894.4]
  wire [7:0] _T_28; // @[multiplier.scala 227:33:@6906.4]
  wire [7:0] _T_31; // @[multiplier.scala 233:31:@6916.4]
  wire [15:0] pp_hl; // @[multiplier.scala 209:31:@6880.4 multiplier.scala 229:25:@6910.4]
  wire [15:0] pp_ll; // @[multiplier.scala 208:31:@6879.4 multiplier.scala 224:25:@6902.4]
  wire [7:0] _T_36; // @[multiplier.scala 242:53:@6928.4]
  wire [15:0] _T_37; // @[Cat.scala 30:58:@6929.4]
  wire [16:0] _T_38; // @[multiplier.scala 242:29:@6930.4]
  wire [15:0] psum_1; // @[multiplier.scala 242:29:@6931.4]
  wire [15:0] pp_hh; // @[multiplier.scala 211:31:@6882.4 multiplier.scala 239:25:@6926.4]
  wire [23:0] _T_42; // @[Cat.scala 30:58:@6934.4]
  wire [15:0] pp_lh; // @[multiplier.scala 210:31:@6881.4 multiplier.scala 234:25:@6918.4]
  wire [23:0] _T_45; // @[Cat.scala 30:58:@6936.4]
  wire [24:0] _T_46; // @[multiplier.scala 243:54:@6937.4]
  wire [23:0] psum_2; // @[multiplier.scala 243:54:@6938.4]
  wire [23:0] _T_50; // @[Cat.scala 30:58:@6941.4]
  wire [24:0] _T_51; // @[multiplier.scala 244:56:@6942.4]
  wire [23:0] psum_3; // @[multiplier.scala 244:56:@6943.4]
  wire [7:0] result1; // @[multiplier.scala 246:29:@6945.4]
  wire [31:0] result; // @[Cat.scala 30:58:@6947.4]
  wire [31:0] _T_53; // @[multiplier.scala 249:28:@6948.4]
  wire [31:0] _T_54; // @[multiplier.scala 249:43:@6949.4]
  wire [32:0] _T_56; // @[multiplier.scala 249:46:@6950.4]
  wire [31:0] _T_57; // @[multiplier.scala 249:46:@6951.4]
  wire [31:0] result_complement; // @[multiplier.scala 249:46:@6952.4]
  wire [31:0] _T_59; // @[multiplier.scala 251:70:@6954.4]
  vedic_8x8 pp_1 ( // @[multiplier.scala 221:32:@6895.4]
    .io_a(pp_1_io_a),
    .io_b(pp_1_io_b),
    .io_c(pp_1_io_c)
  );
  vedic_8x8 pp_2 ( // @[multiplier.scala 226:32:@6903.4]
    .io_a(pp_2_io_a),
    .io_b(pp_2_io_b),
    .io_c(pp_2_io_c)
  );
  vedic_8x8 pp_3 ( // @[multiplier.scala 231:32:@6911.4]
    .io_a(pp_3_io_a),
    .io_b(pp_3_io_b),
    .io_c(pp_3_io_c)
  );
  vedic_4x4 pp_4 ( // @[multiplier.scala 236:32:@6919.4]
    .io_a(pp_4_io_a),
    .io_b(pp_4_io_b),
    .io_c(pp_4_io_c)
  );
  assign _T_18 = ~ io_a; // @[multiplier.scala 217:25:@6886.4]
  assign _T_19 = $signed(_T_18); // @[multiplier.scala 217:25:@6887.4]
  assign _T_20 = $unsigned(_T_19); // @[multiplier.scala 217:38:@6888.4]
  assign _T_22 = _T_20 + 16'h1; // @[multiplier.scala 217:41:@6889.4]
  assign in1_complement = _T_20 + 16'h1; // @[multiplier.scala 217:41:@6890.4]
  assign _T_23 = io_a[15]; // @[multiplier.scala 218:32:@6891.4]
  assign _T_25 = $unsigned(io_a); // @[multiplier.scala 218:64:@6893.4]
  assign input1 = _T_23 ? in1_complement : _T_25; // @[multiplier.scala 218:27:@6894.4]
  assign _T_28 = input1[15:8]; // @[multiplier.scala 227:33:@6906.4]
  assign _T_31 = io_b[15:8]; // @[multiplier.scala 233:31:@6916.4]
  assign pp_hl = pp_2_io_c; // @[multiplier.scala 209:31:@6880.4 multiplier.scala 229:25:@6910.4]
  assign pp_ll = pp_1_io_c; // @[multiplier.scala 208:31:@6879.4 multiplier.scala 224:25:@6902.4]
  assign _T_36 = pp_ll[15:8]; // @[multiplier.scala 242:53:@6928.4]
  assign _T_37 = {8'h0,_T_36}; // @[Cat.scala 30:58:@6929.4]
  assign _T_38 = pp_hl + _T_37; // @[multiplier.scala 242:29:@6930.4]
  assign psum_1 = pp_hl + _T_37; // @[multiplier.scala 242:29:@6931.4]
  assign pp_hh = {{8'd0}, pp_4_io_c}; // @[multiplier.scala 211:31:@6882.4 multiplier.scala 239:25:@6926.4]
  assign _T_42 = {pp_hh,8'h0}; // @[Cat.scala 30:58:@6934.4]
  assign pp_lh = pp_3_io_c; // @[multiplier.scala 210:31:@6881.4 multiplier.scala 234:25:@6918.4]
  assign _T_45 = {8'h0,pp_lh}; // @[Cat.scala 30:58:@6936.4]
  assign _T_46 = _T_42 + _T_45; // @[multiplier.scala 243:54:@6937.4]
  assign psum_2 = _T_42 + _T_45; // @[multiplier.scala 243:54:@6938.4]
  assign _T_50 = {8'h0,psum_1}; // @[Cat.scala 30:58:@6941.4]
  assign _T_51 = _T_50 + psum_2; // @[multiplier.scala 244:56:@6942.4]
  assign psum_3 = _T_50 + psum_2; // @[multiplier.scala 244:56:@6943.4]
  assign result1 = pp_ll[7:0]; // @[multiplier.scala 246:29:@6945.4]
  assign result = {psum_3,result1}; // @[Cat.scala 30:58:@6947.4]
  assign _T_53 = ~ result; // @[multiplier.scala 249:28:@6948.4]
  assign _T_54 = $signed(_T_53); // @[multiplier.scala 249:43:@6949.4]
  assign _T_56 = $signed(_T_54) + $signed(32'sh1); // @[multiplier.scala 249:46:@6950.4]
  assign _T_57 = $signed(_T_54) + $signed(32'sh1); // @[multiplier.scala 249:46:@6951.4]
  assign result_complement = $signed(_T_57); // @[multiplier.scala 249:46:@6952.4]
  assign _T_59 = $signed(result); // @[multiplier.scala 251:70:@6954.4]
  assign io_c = _T_23 ? $signed(result_complement) : $signed(_T_59); // @[multiplier.scala 252:22:@6956.4]
  assign pp_1_io_a = input1[7:0]; // @[multiplier.scala 222:24:@6899.4]
  assign pp_1_io_b = io_b[7:0]; // @[multiplier.scala 223:24:@6901.4]
  assign pp_2_io_a = input1[15:8]; // @[multiplier.scala 227:24:@6907.4]
  assign pp_2_io_b = io_b[7:0]; // @[multiplier.scala 228:24:@6909.4]
  assign pp_3_io_a = input1[7:0]; // @[multiplier.scala 232:24:@6915.4]
  assign pp_3_io_b = io_b[15:8]; // @[multiplier.scala 233:24:@6917.4]
  assign pp_4_io_a = _T_28[3:0]; // @[multiplier.scala 237:24:@6923.4]
  assign pp_4_io_b = _T_31[3:0]; // @[multiplier.scala 238:24:@6925.4]
endmodule
module PID_Controller( // @[:@11980.2]
  input         clock, // @[:@11981.4]
  input         reset, // @[:@11982.4]
  input         io_fb_period, // @[:@11983.4]
  input         io_raw_irq, // @[:@11983.4]
  input         io_reg_kp_we, // @[:@11983.4]
  input  [15:0] io_reg_kp_di, // @[:@11983.4]
  output [15:0] io_reg_kp_do, // @[:@11983.4]
  input         io_reg_ki_we, // @[:@11983.4]
  input  [15:0] io_reg_ki_di, // @[:@11983.4]
  output [15:0] io_reg_ki_do, // @[:@11983.4]
  input         io_reg_kd_we, // @[:@11983.4]
  input  [15:0] io_reg_kd_di, // @[:@11983.4]
  output [15:0] io_reg_kd_do, // @[:@11983.4]
  input         io_reg_ref_we, // @[:@11983.4]
  input  [15:0] io_reg_ref_di, // @[:@11983.4]
  output [15:0] io_reg_ref_do, // @[:@11983.4]
  input         io_reg_fb_we, // @[:@11983.4]
  input  [15:0] io_reg_fb_di, // @[:@11983.4]
  output [15:0] io_reg_fb_do, // @[:@11983.4]
  input         io_reg_cfg_we, // @[:@11983.4]
  input  [15:0] io_reg_cfg_di, // @[:@11983.4]
  output [15:0] io_reg_cfg_do, // @[:@11983.4]
  input  [15:0] io_speed_fb_in, // @[:@11983.4]
  output [15:0] io_pid_out // @[:@11983.4]
);
  wire [15:0] mul_kp_io_a; // @[pid.scala 110:25:@12033.4]
  wire [15:0] mul_kp_io_b; // @[pid.scala 110:25:@12033.4]
  wire [31:0] mul_kp_io_c; // @[pid.scala 110:25:@12033.4]
  wire [15:0] mul_ki_io_a; // @[pid.scala 116:25:@12041.4]
  wire [15:0] mul_ki_io_b; // @[pid.scala 116:25:@12041.4]
  wire [31:0] mul_ki_io_c; // @[pid.scala 116:25:@12041.4]
  wire [15:0] mul_kd_io_a; // @[pid.scala 122:25:@12049.4]
  wire [15:0] mul_kd_io_b; // @[pid.scala 122:25:@12049.4]
  wire [31:0] mul_kd_io_c; // @[pid.scala 122:25:@12049.4]
  reg [15:0] kp; // @[pid.scala 56:26:@11985.4]
  reg [31:0] _RAND_0;
  reg [15:0] ki; // @[pid.scala 57:26:@11986.4]
  reg [31:0] _RAND_1;
  reg [15:0] kd; // @[pid.scala 58:26:@11987.4]
  reg [31:0] _RAND_2;
  reg [15:0] ref$; // @[pid.scala 59:26:@11988.4]
  reg [31:0] _RAND_3;
  reg [15:0] feedback; // @[pid.scala 60:26:@11989.4]
  reg [31:0] _RAND_4;
  reg [15:0] sigma_old; // @[pid.scala 61:26:@11990.4]
  reg [31:0] _RAND_5;
  reg  fb_sel; // @[pid.scala 62:26:@11991.4]
  reg [31:0] _RAND_6;
  reg [15:0] e_prev1; // @[pid.scala 64:26:@11992.4]
  reg [31:0] _RAND_7;
  reg [15:0] e_prev2; // @[pid.scala 65:26:@11993.4]
  reg [31:0] _RAND_8;
  reg [15:0] reg_pid_out; // @[pid.scala 66:28:@11994.4]
  reg [31:0] _RAND_9;
  wire [15:0] _GEN_0; // @[pid.scala 70:22:@11996.4]
  wire [15:0] _GEN_1; // @[pid.scala 75:22:@12000.4]
  wire [15:0] _GEN_2; // @[pid.scala 80:22:@12004.4]
  wire [15:0] _GEN_3; // @[pid.scala 86:23:@12008.4]
  wire [15:0] _GEN_4; // @[pid.scala 93:24:@12013.6]
  wire [15:0] _GEN_5; // @[pid.scala 92:16:@12012.4]
  wire [31:0] _T_70; // @[Cat.scala 30:58:@12020.4]
  wire [31:0] _T_71; // @[pid.scala 100:49:@12021.4]
  wire  _T_72; // @[pid.scala 102:28:@12024.6]
  wire  _GEN_6; // @[pid.scala 101:23:@12023.4]
  wire [16:0] _T_73; // @[pid.scala 106:27:@12027.4]
  wire [15:0] _T_74; // @[pid.scala 106:27:@12028.4]
  wire [16:0] _T_75; // @[pid.scala 107:27:@12030.4]
  wire [15:0] _T_76; // @[pid.scala 107:27:@12031.4]
  wire [15:0] sigma_new; // @[pid.scala 107:27:@12032.4]
  wire [15:0] _T_78; // @[pid.scala 113:30:@12039.4]
  wire [15:0] prop_out; // @[pid.scala 113:43:@12040.4]
  wire [15:0] _T_80; // @[pid.scala 119:33:@12047.4]
  wire [15:0] integral_out; // @[pid.scala 119:46:@12048.4]
  wire [15:0] _T_82; // @[pid.scala 125:35:@12055.4]
  wire [15:0] derivative_out; // @[pid.scala 125:48:@12056.4]
  wire [16:0] _T_83; // @[pid.scala 128:28:@12057.4]
  wire [15:0] _T_84; // @[pid.scala 128:28:@12058.4]
  wire [15:0] pi_sum; // @[pid.scala 128:28:@12059.4]
  wire  _T_85; // @[pid.scala 129:34:@12060.4]
  wire  _T_86; // @[pid.scala 129:54:@12061.4]
  wire  _T_87; // @[pid.scala 129:39:@12062.4]
  wire  _T_88; // @[pid.scala 129:69:@12063.4]
  wire  _T_90; // @[pid.scala 129:62:@12064.4]
  wire  _T_91; // @[pid.scala 129:59:@12065.4]
  wire  _T_94; // @[pid.scala 130:26:@12067.4]
  wire  _T_97; // @[pid.scala 130:43:@12069.4]
  wire  _T_98; // @[pid.scala 130:40:@12070.4]
  wire  _T_100; // @[pid.scala 130:61:@12072.4]
  wire  pi_sum_overflow; // @[pid.scala 129:75:@12073.4]
  wire [16:0] _T_101; // @[pid.scala 135:29:@12076.8]
  wire [15:0] _T_102; // @[pid.scala 135:29:@12077.8]
  wire [15:0] _T_103; // @[pid.scala 135:29:@12078.8]
  wire [16:0] _T_104; // @[pid.scala 137:24:@12082.8]
  wire [15:0] _T_105; // @[pid.scala 137:24:@12083.8]
  wire [15:0] _T_106; // @[pid.scala 137:24:@12084.8]
  wire [15:0] _GEN_7; // @[pid.scala 134:23:@12075.6]
  wire [16:0] _T_107; // @[pid.scala 141:27:@12089.6]
  wire [15:0] _T_108; // @[pid.scala 141:27:@12090.6]
  wire [15:0] _T_109; // @[pid.scala 141:27:@12091.6]
  wire [15:0] _GEN_8; // @[pid.scala 132:20:@12074.4]
  wire [15:0] _GEN_9; // @[pid.scala 132:20:@12074.4]
  wire [15:0] _GEN_10; // @[pid.scala 132:20:@12074.4]
  wire [15:0] _GEN_11; // @[pid.scala 132:20:@12074.4]
  wire  _T_110; // @[pid.scala 144:54:@12094.4]
  wire  _T_111; // @[pid.scala 144:40:@12095.4]
  wire [15:0] _GEN_12; // @[pid.scala 100:17:@12022.4]
  vedic_16x16 mul_kp ( // @[pid.scala 110:25:@12033.4]
    .io_a(mul_kp_io_a),
    .io_b(mul_kp_io_b),
    .io_c(mul_kp_io_c)
  );
  vedic_16x16 mul_ki ( // @[pid.scala 116:25:@12041.4]
    .io_a(mul_ki_io_a),
    .io_b(mul_ki_io_b),
    .io_c(mul_ki_io_c)
  );
  vedic_16x16 mul_kd ( // @[pid.scala 122:25:@12049.4]
    .io_a(mul_kd_io_a),
    .io_b(mul_kd_io_b),
    .io_c(mul_kd_io_c)
  );
  assign _GEN_0 = io_reg_kp_we ? $signed(io_reg_kp_di) : $signed(kp); // @[pid.scala 70:22:@11996.4]
  assign _GEN_1 = io_reg_ki_we ? $signed(io_reg_ki_di) : $signed(ki); // @[pid.scala 75:22:@12000.4]
  assign _GEN_2 = io_reg_kd_we ? $signed(io_reg_kd_di) : $signed(kd); // @[pid.scala 80:22:@12004.4]
  assign _GEN_3 = io_reg_ref_we ? $signed(io_reg_ref_di) : $signed(ref$); // @[pid.scala 86:23:@12008.4]
  assign _GEN_4 = io_reg_fb_we ? $signed(io_reg_fb_di) : $signed(feedback); // @[pid.scala 93:24:@12013.6]
  assign _GEN_5 = fb_sel ? $signed(_GEN_4) : $signed(io_speed_fb_in); // @[pid.scala 92:16:@12012.4]
  assign _T_70 = {31'h0,fb_sel}; // @[Cat.scala 30:58:@12020.4]
  assign _T_71 = $signed(_T_70); // @[pid.scala 100:49:@12021.4]
  assign _T_72 = io_reg_cfg_di[0]; // @[pid.scala 102:28:@12024.6]
  assign _GEN_6 = io_reg_cfg_we ? _T_72 : fb_sel; // @[pid.scala 101:23:@12023.4]
  assign _T_73 = $signed(e_prev1) - $signed(e_prev2); // @[pid.scala 106:27:@12027.4]
  assign _T_74 = $signed(e_prev1) - $signed(e_prev2); // @[pid.scala 106:27:@12028.4]
  assign _T_75 = $signed(e_prev1) + $signed(sigma_old); // @[pid.scala 107:27:@12030.4]
  assign _T_76 = $signed(e_prev1) + $signed(sigma_old); // @[pid.scala 107:27:@12031.4]
  assign sigma_new = $signed(_T_76); // @[pid.scala 107:27:@12032.4]
  assign _T_78 = mul_kp_io_c[15:0]; // @[pid.scala 113:30:@12039.4]
  assign prop_out = $signed(_T_78); // @[pid.scala 113:43:@12040.4]
  assign _T_80 = mul_ki_io_c[15:0]; // @[pid.scala 119:33:@12047.4]
  assign integral_out = $signed(_T_80); // @[pid.scala 119:46:@12048.4]
  assign _T_82 = mul_kd_io_c[15:0]; // @[pid.scala 125:35:@12055.4]
  assign derivative_out = $signed(_T_82); // @[pid.scala 125:48:@12056.4]
  assign _T_83 = $signed(prop_out) + $signed(integral_out); // @[pid.scala 128:28:@12057.4]
  assign _T_84 = $signed(prop_out) + $signed(integral_out); // @[pid.scala 128:28:@12058.4]
  assign pi_sum = $signed(_T_84); // @[pid.scala 128:28:@12059.4]
  assign _T_85 = prop_out[15]; // @[pid.scala 129:34:@12060.4]
  assign _T_86 = integral_out[15]; // @[pid.scala 129:54:@12061.4]
  assign _T_87 = _T_85 & _T_86; // @[pid.scala 129:39:@12062.4]
  assign _T_88 = pi_sum[15]; // @[pid.scala 129:69:@12063.4]
  assign _T_90 = _T_88 == 1'h0; // @[pid.scala 129:62:@12064.4]
  assign _T_91 = _T_87 & _T_90; // @[pid.scala 129:59:@12065.4]
  assign _T_94 = _T_85 == 1'h0; // @[pid.scala 130:26:@12067.4]
  assign _T_97 = _T_86 == 1'h0; // @[pid.scala 130:43:@12069.4]
  assign _T_98 = _T_94 & _T_97; // @[pid.scala 130:40:@12070.4]
  assign _T_100 = _T_98 & _T_88; // @[pid.scala 130:61:@12072.4]
  assign pi_sum_overflow = _T_91 | _T_100; // @[pid.scala 129:75:@12073.4]
  assign _T_101 = $signed(feedback) - $signed(ref$); // @[pid.scala 135:29:@12076.8]
  assign _T_102 = $signed(feedback) - $signed(ref$); // @[pid.scala 135:29:@12077.8]
  assign _T_103 = $signed(_T_102); // @[pid.scala 135:29:@12078.8]
  assign _T_104 = $signed(ref$) - $signed(feedback); // @[pid.scala 137:24:@12082.8]
  assign _T_105 = $signed(ref$) - $signed(feedback); // @[pid.scala 137:24:@12083.8]
  assign _T_106 = $signed(_T_105); // @[pid.scala 137:24:@12084.8]
  assign _GEN_7 = io_fb_period ? $signed(_T_103) : $signed(_T_106); // @[pid.scala 134:23:@12075.6]
  assign _T_107 = $signed(pi_sum) + $signed(derivative_out); // @[pid.scala 141:27:@12089.6]
  assign _T_108 = $signed(pi_sum) + $signed(derivative_out); // @[pid.scala 141:27:@12090.6]
  assign _T_109 = $signed(_T_108); // @[pid.scala 141:27:@12091.6]
  assign _GEN_8 = io_raw_irq ? $signed(_GEN_7) : $signed(e_prev1); // @[pid.scala 132:20:@12074.4]
  assign _GEN_9 = io_raw_irq ? $signed(e_prev1) : $signed(e_prev2); // @[pid.scala 132:20:@12074.4]
  assign _GEN_10 = io_raw_irq ? $signed(sigma_new) : $signed(sigma_old); // @[pid.scala 132:20:@12074.4]
  assign _GEN_11 = io_raw_irq ? $signed(_T_109) : $signed(reg_pid_out); // @[pid.scala 132:20:@12074.4]
  assign _T_110 = reg_pid_out[15]; // @[pid.scala 144:54:@12094.4]
  assign _T_111 = pi_sum_overflow | _T_110; // @[pid.scala 144:40:@12095.4]
  assign io_reg_kp_do = kp; // @[pid.scala 69:17:@11995.4]
  assign io_reg_ki_do = ki; // @[pid.scala 74:17:@11999.4]
  assign io_reg_kd_do = kd; // @[pid.scala 79:17:@12003.4]
  assign io_reg_ref_do = ref$; // @[pid.scala 85:17:@12007.4]
  assign io_reg_fb_do = feedback; // @[pid.scala 90:17:@12011.4]
  assign _GEN_12 = _T_71[15:0]; // @[pid.scala 100:17:@12022.4]
  assign io_reg_cfg_do = $signed(_GEN_12); // @[pid.scala 100:17:@12022.4]
  assign io_pid_out = _T_111 ? $signed(16'sh0) : $signed(reg_pid_out); // @[pid.scala 144:17:@12097.4]
  assign mul_kp_io_a = e_prev1; // @[pid.scala 111:17:@12036.4]
  assign mul_kp_io_b = $unsigned(kp); // @[pid.scala 112:17:@12038.4]
  assign mul_ki_io_a = $signed(_T_76); // @[pid.scala 117:17:@12044.4]
  assign mul_ki_io_b = $unsigned(ki); // @[pid.scala 118:17:@12046.4]
  assign mul_kd_io_a = $signed(_T_74); // @[pid.scala 123:17:@12052.4]
  assign mul_kd_io_b = $unsigned(kd); // @[pid.scala 124:17:@12054.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  kp = _RAND_0[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  ki = _RAND_1[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  kd = _RAND_2[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  ref$ = _RAND_3[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  feedback = _RAND_4[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  sigma_old = _RAND_5[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  fb_sel = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  e_prev1 = _RAND_7[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  e_prev2 = _RAND_8[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  reg_pid_out = _RAND_9[15:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      kp <= 16'sh1;
    end else begin
      if (io_reg_kp_we) begin
        kp <= io_reg_kp_di;
      end
    end
    if (reset) begin
      ki <= 16'sh0;
    end else begin
      if (io_reg_ki_we) begin
        ki <= io_reg_ki_di;
      end
    end
    if (reset) begin
      kd <= 16'sh0;
    end else begin
      if (io_reg_kd_we) begin
        kd <= io_reg_kd_di;
      end
    end
    if (reset) begin
      ref$ <= 16'sh14;
    end else begin
      if (io_reg_ref_we) begin
        ref$ <= io_reg_ref_di;
      end
    end
    if (reset) begin
      feedback <= 16'sh0;
    end else begin
      if (fb_sel) begin
        if (io_reg_fb_we) begin
          feedback <= io_reg_fb_di;
        end
      end else begin
        feedback <= io_speed_fb_in;
      end
    end
    if (reset) begin
      sigma_old <= 16'sh0;
    end else begin
      if (io_raw_irq) begin
        sigma_old <= sigma_new;
      end
    end
    if (reset) begin
      fb_sel <= 1'h0;
    end else begin
      if (io_reg_cfg_we) begin
        fb_sel <= _T_72;
      end
    end
    if (reset) begin
      e_prev1 <= 16'sh0;
    end else begin
      if (io_raw_irq) begin
        if (io_fb_period) begin
          e_prev1 <= _T_103;
        end else begin
          e_prev1 <= _T_106;
        end
      end
    end
    if (reset) begin
      e_prev2 <= 16'sh0;
    end else begin
      if (io_raw_irq) begin
        e_prev2 <= e_prev1;
      end
    end
    if (reset) begin
      reg_pid_out <= 16'sh0;
    end else begin
      if (io_raw_irq) begin
        reg_pid_out <= _T_109;
      end
    end
  end
endmodule
module Motor_Top( // @[:@12099.2]
  input         clock, // @[:@12100.4]
  input         reset, // @[:@12101.4]
  input  [15:0] io_wbs_m2s_addr, // @[:@12102.4]
  input  [31:0] io_wbs_m2s_data, // @[:@12102.4]
  input         io_wbs_m2s_we, // @[:@12102.4]
  input  [3:0]  io_wbs_m2s_sel, // @[:@12102.4]
  input         io_wbs_m2s_stb, // @[:@12102.4]
  output        io_wbs_ack_o, // @[:@12102.4]
  output [31:0] io_wbs_data_o, // @[:@12102.4]
  input         io_motor_gpio_qei_ch_a, // @[:@12102.4]
  input         io_motor_gpio_qei_ch_b, // @[:@12102.4]
  output        io_motor_gpio_pwm_high, // @[:@12102.4]
  output        io_motor_gpio_pwm_low, // @[:@12102.4]
  input         io_motor_select, // @[:@12102.4]
  output        io_motor_irq // @[:@12102.4]
);
  wire  interlink_clock; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_reset; // @[motor_top.scala 41:26:@12104.4]
  wire [31:0] interlink_io_bus_adr_i; // @[motor_top.scala 41:26:@12104.4]
  wire [3:0] interlink_io_bus_sel_i; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_bus_we_i; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_bus_cyc_i; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_bus_stb_i; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_bus_ack_o; // @[motor_top.scala 41:26:@12104.4]
  wire [31:0] interlink_io_bus_dat_o; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_tmr_val_we; // @[motor_top.scala 41:26:@12104.4]
  wire [31:0] interlink_io_tmr_val_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_tmr_dat_we; // @[motor_top.scala 41:26:@12104.4]
  wire [31:0] interlink_io_tmr_dat_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_tmr_duty_we; // @[motor_top.scala 41:26:@12104.4]
  wire [31:0] interlink_io_tmr_duty_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_tmr_cfg_we; // @[motor_top.scala 41:26:@12104.4]
  wire [31:0] interlink_io_tmr_cfg_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_qei_count_we; // @[motor_top.scala 41:26:@12104.4]
  wire [31:0] interlink_io_qei_count_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_qei_cfg_we; // @[motor_top.scala 41:26:@12104.4]
  wire [31:0] interlink_io_qei_cfg_do; // @[motor_top.scala 41:26:@12104.4]
  wire [15:0] interlink_io_qei_speed_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_pid_kp_we; // @[motor_top.scala 41:26:@12104.4]
  wire [15:0] interlink_io_pid_kp_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_pid_ki_we; // @[motor_top.scala 41:26:@12104.4]
  wire [15:0] interlink_io_pid_ki_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_pid_kd_we; // @[motor_top.scala 41:26:@12104.4]
  wire [15:0] interlink_io_pid_kd_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_pid_ref_we; // @[motor_top.scala 41:26:@12104.4]
  wire [15:0] interlink_io_pid_ref_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_pid_fb_we; // @[motor_top.scala 41:26:@12104.4]
  wire [15:0] interlink_io_pid_fb_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_pid_cfg_we; // @[motor_top.scala 41:26:@12104.4]
  wire [15:0] interlink_io_pid_cfg_do; // @[motor_top.scala 41:26:@12104.4]
  wire  interlink_io_motor_select; // @[motor_top.scala 41:26:@12104.4]
  wire  pwm_clock; // @[motor_top.scala 57:37:@12115.4]
  wire  pwm_reset; // @[motor_top.scala 57:37:@12115.4]
  wire  pwm_io_reg_val_we; // @[motor_top.scala 57:37:@12115.4]
  wire [31:0] pwm_io_reg_val_di; // @[motor_top.scala 57:37:@12115.4]
  wire [31:0] pwm_io_reg_val_do; // @[motor_top.scala 57:37:@12115.4]
  wire  pwm_io_reg_cfg_we; // @[motor_top.scala 57:37:@12115.4]
  wire [31:0] pwm_io_reg_cfg_di; // @[motor_top.scala 57:37:@12115.4]
  wire [31:0] pwm_io_reg_cfg_do; // @[motor_top.scala 57:37:@12115.4]
  wire  pwm_io_reg_dat_we; // @[motor_top.scala 57:37:@12115.4]
  wire [31:0] pwm_io_reg_dat_di; // @[motor_top.scala 57:37:@12115.4]
  wire [31:0] pwm_io_reg_dat_do; // @[motor_top.scala 57:37:@12115.4]
  wire  pwm_io_reg_duty_we; // @[motor_top.scala 57:37:@12115.4]
  wire [31:0] pwm_io_reg_duty_di; // @[motor_top.scala 57:37:@12115.4]
  wire [31:0] pwm_io_reg_duty_do; // @[motor_top.scala 57:37:@12115.4]
  wire [15:0] pwm_io_reg_pid_out; // @[motor_top.scala 57:37:@12115.4]
  wire  pwm_io_pwm_h; // @[motor_top.scala 57:37:@12115.4]
  wire  pwm_io_pwm_l; // @[motor_top.scala 57:37:@12115.4]
  wire  pwm_io_irq_out; // @[motor_top.scala 57:37:@12115.4]
  wire  pwm_io_rawirq_out; // @[motor_top.scala 57:37:@12115.4]
  wire  qei_clock; // @[motor_top.scala 86:37:@12135.4]
  wire  qei_reset; // @[motor_top.scala 86:37:@12135.4]
  wire  qei_io_quad_a; // @[motor_top.scala 86:37:@12135.4]
  wire  qei_io_quad_b; // @[motor_top.scala 86:37:@12135.4]
  wire  qei_io_raw_irq; // @[motor_top.scala 86:37:@12135.4]
  wire  qei_io_reg_count_we; // @[motor_top.scala 86:37:@12135.4]
  wire [31:0] qei_io_reg_count_di; // @[motor_top.scala 86:37:@12135.4]
  wire [31:0] qei_io_reg_count_do; // @[motor_top.scala 86:37:@12135.4]
  wire  qei_io_reg_cfg_we; // @[motor_top.scala 86:37:@12135.4]
  wire [31:0] qei_io_reg_cfg_di; // @[motor_top.scala 86:37:@12135.4]
  wire [31:0] qei_io_reg_cfg_do; // @[motor_top.scala 86:37:@12135.4]
  wire [15:0] qei_io_reg_speed_do; // @[motor_top.scala 86:37:@12135.4]
  wire  qei_io_fb_period; // @[motor_top.scala 86:37:@12135.4]
  wire  pid_clock; // @[motor_top.scala 102:37:@12148.4]
  wire  pid_reset; // @[motor_top.scala 102:37:@12148.4]
  wire  pid_io_fb_period; // @[motor_top.scala 102:37:@12148.4]
  wire  pid_io_raw_irq; // @[motor_top.scala 102:37:@12148.4]
  wire  pid_io_reg_kp_we; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_kp_di; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_kp_do; // @[motor_top.scala 102:37:@12148.4]
  wire  pid_io_reg_ki_we; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_ki_di; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_ki_do; // @[motor_top.scala 102:37:@12148.4]
  wire  pid_io_reg_kd_we; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_kd_di; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_kd_do; // @[motor_top.scala 102:37:@12148.4]
  wire  pid_io_reg_ref_we; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_ref_di; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_ref_do; // @[motor_top.scala 102:37:@12148.4]
  wire  pid_io_reg_fb_we; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_fb_di; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_fb_do; // @[motor_top.scala 102:37:@12148.4]
  wire  pid_io_reg_cfg_we; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_cfg_di; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_reg_cfg_do; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_speed_fb_in; // @[motor_top.scala 102:37:@12148.4]
  wire [15:0] pid_io_pid_out; // @[motor_top.scala 102:37:@12148.4]
  wire [7:0] _T_48; // @[motor_top.scala 107:41:@12154.4]
  wire [7:0] _T_49; // @[motor_top.scala 107:53:@12155.4]
  wire [15:0] _T_54; // @[motor_top.scala 119:41:@12169.4]
  Interlink_Module interlink ( // @[motor_top.scala 41:26:@12104.4]
    .clock(interlink_clock),
    .reset(interlink_reset),
    .io_bus_adr_i(interlink_io_bus_adr_i),
    .io_bus_sel_i(interlink_io_bus_sel_i),
    .io_bus_we_i(interlink_io_bus_we_i),
    .io_bus_cyc_i(interlink_io_bus_cyc_i),
    .io_bus_stb_i(interlink_io_bus_stb_i),
    .io_bus_ack_o(interlink_io_bus_ack_o),
    .io_bus_dat_o(interlink_io_bus_dat_o),
    .io_tmr_val_we(interlink_io_tmr_val_we),
    .io_tmr_val_do(interlink_io_tmr_val_do),
    .io_tmr_dat_we(interlink_io_tmr_dat_we),
    .io_tmr_dat_do(interlink_io_tmr_dat_do),
    .io_tmr_duty_we(interlink_io_tmr_duty_we),
    .io_tmr_duty_do(interlink_io_tmr_duty_do),
    .io_tmr_cfg_we(interlink_io_tmr_cfg_we),
    .io_tmr_cfg_do(interlink_io_tmr_cfg_do),
    .io_qei_count_we(interlink_io_qei_count_we),
    .io_qei_count_do(interlink_io_qei_count_do),
    .io_qei_cfg_we(interlink_io_qei_cfg_we),
    .io_qei_cfg_do(interlink_io_qei_cfg_do),
    .io_qei_speed_do(interlink_io_qei_speed_do),
    .io_pid_kp_we(interlink_io_pid_kp_we),
    .io_pid_kp_do(interlink_io_pid_kp_do),
    .io_pid_ki_we(interlink_io_pid_ki_we),
    .io_pid_ki_do(interlink_io_pid_ki_do),
    .io_pid_kd_we(interlink_io_pid_kd_we),
    .io_pid_kd_do(interlink_io_pid_kd_do),
    .io_pid_ref_we(interlink_io_pid_ref_we),
    .io_pid_ref_do(interlink_io_pid_ref_do),
    .io_pid_fb_we(interlink_io_pid_fb_we),
    .io_pid_fb_do(interlink_io_pid_fb_do),
    .io_pid_cfg_we(interlink_io_pid_cfg_we),
    .io_pid_cfg_do(interlink_io_pid_cfg_do),
    .io_motor_select(interlink_io_motor_select)
  );
  PWM pwm ( // @[motor_top.scala 57:37:@12115.4]
    .clock(pwm_clock),
    .reset(pwm_reset),
    .io_reg_val_we(pwm_io_reg_val_we),
    .io_reg_val_di(pwm_io_reg_val_di),
    .io_reg_val_do(pwm_io_reg_val_do),
    .io_reg_cfg_we(pwm_io_reg_cfg_we),
    .io_reg_cfg_di(pwm_io_reg_cfg_di),
    .io_reg_cfg_do(pwm_io_reg_cfg_do),
    .io_reg_dat_we(pwm_io_reg_dat_we),
    .io_reg_dat_di(pwm_io_reg_dat_di),
    .io_reg_dat_do(pwm_io_reg_dat_do),
    .io_reg_duty_we(pwm_io_reg_duty_we),
    .io_reg_duty_di(pwm_io_reg_duty_di),
    .io_reg_duty_do(pwm_io_reg_duty_do),
    .io_reg_pid_out(pwm_io_reg_pid_out),
    .io_pwm_h(pwm_io_pwm_h),
    .io_pwm_l(pwm_io_pwm_l),
    .io_irq_out(pwm_io_irq_out),
    .io_rawirq_out(pwm_io_rawirq_out)
  );
  Quad_Encoder qei ( // @[motor_top.scala 86:37:@12135.4]
    .clock(qei_clock),
    .reset(qei_reset),
    .io_quad_a(qei_io_quad_a),
    .io_quad_b(qei_io_quad_b),
    .io_raw_irq(qei_io_raw_irq),
    .io_reg_count_we(qei_io_reg_count_we),
    .io_reg_count_di(qei_io_reg_count_di),
    .io_reg_count_do(qei_io_reg_count_do),
    .io_reg_cfg_we(qei_io_reg_cfg_we),
    .io_reg_cfg_di(qei_io_reg_cfg_di),
    .io_reg_cfg_do(qei_io_reg_cfg_do),
    .io_reg_speed_do(qei_io_reg_speed_do),
    .io_fb_period(qei_io_fb_period)
  );
  PID_Controller pid ( // @[motor_top.scala 102:37:@12148.4]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_fb_period(pid_io_fb_period),
    .io_raw_irq(pid_io_raw_irq),
    .io_reg_kp_we(pid_io_reg_kp_we),
    .io_reg_kp_di(pid_io_reg_kp_di),
    .io_reg_kp_do(pid_io_reg_kp_do),
    .io_reg_ki_we(pid_io_reg_ki_we),
    .io_reg_ki_di(pid_io_reg_ki_di),
    .io_reg_ki_do(pid_io_reg_ki_do),
    .io_reg_kd_we(pid_io_reg_kd_we),
    .io_reg_kd_di(pid_io_reg_kd_di),
    .io_reg_kd_do(pid_io_reg_kd_do),
    .io_reg_ref_we(pid_io_reg_ref_we),
    .io_reg_ref_di(pid_io_reg_ref_di),
    .io_reg_ref_do(pid_io_reg_ref_do),
    .io_reg_fb_we(pid_io_reg_fb_we),
    .io_reg_fb_di(pid_io_reg_fb_di),
    .io_reg_fb_do(pid_io_reg_fb_do),
    .io_reg_cfg_we(pid_io_reg_cfg_we),
    .io_reg_cfg_di(pid_io_reg_cfg_di),
    .io_reg_cfg_do(pid_io_reg_cfg_do),
    .io_speed_fb_in(pid_io_speed_fb_in),
    .io_pid_out(pid_io_pid_out)
  );
  assign _T_48 = io_wbs_m2s_data[7:0]; // @[motor_top.scala 107:41:@12154.4]
  assign _T_49 = $signed(_T_48); // @[motor_top.scala 107:53:@12155.4]
  assign _T_54 = io_wbs_m2s_data[15:0]; // @[motor_top.scala 119:41:@12169.4]
  assign io_wbs_ack_o = interlink_io_bus_ack_o; // @[motor_top.scala 54:29:@12114.4]
  assign io_wbs_data_o = interlink_io_bus_dat_o; // @[motor_top.scala 53:29:@12113.4]
  assign io_motor_gpio_pwm_high = pwm_io_pwm_h; // @[motor_top.scala 81:29:@12133.4]
  assign io_motor_gpio_pwm_low = pwm_io_pwm_l; // @[motor_top.scala 82:29:@12134.4]
  assign io_motor_irq = pwm_io_irq_out; // @[motor_top.scala 78:29:@12132.4]
  assign interlink_clock = clock; // @[:@12105.4]
  assign interlink_reset = reset; // @[:@12106.4]
  assign interlink_io_bus_adr_i = {{16'd0}, io_wbs_m2s_addr}; // @[motor_top.scala 50:29:@12110.4]
  assign interlink_io_bus_sel_i = io_wbs_m2s_sel; // @[motor_top.scala 51:29:@12111.4]
  assign interlink_io_bus_we_i = io_wbs_m2s_we; // @[motor_top.scala 52:29:@12112.4]
  assign interlink_io_bus_cyc_i = 1'h1; // @[motor_top.scala 49:29:@12109.4]
  assign interlink_io_bus_stb_i = io_wbs_m2s_stb; // @[motor_top.scala 48:29:@12108.4]
  assign interlink_io_tmr_val_do = pwm_io_reg_val_do; // @[motor_top.scala 61:29:@12120.4]
  assign interlink_io_tmr_dat_do = pwm_io_reg_dat_do; // @[motor_top.scala 69:29:@12126.4]
  assign interlink_io_tmr_duty_do = pwm_io_reg_duty_do; // @[motor_top.scala 72:29:@12129.4]
  assign interlink_io_tmr_cfg_do = pwm_io_reg_cfg_do; // @[motor_top.scala 65:29:@12123.4]
  assign interlink_io_qei_count_do = qei_io_reg_count_do; // @[motor_top.scala 93:29:@12143.4]
  assign interlink_io_qei_cfg_do = qei_io_reg_cfg_do; // @[motor_top.scala 97:29:@12146.4]
  assign interlink_io_qei_speed_do = qei_io_reg_speed_do; // @[motor_top.scala 99:29:@12147.4]
  assign interlink_io_pid_kp_do = pid_io_reg_kp_do; // @[motor_top.scala 108:29:@12157.4]
  assign interlink_io_pid_ki_do = pid_io_reg_ki_do; // @[motor_top.scala 112:29:@12162.4]
  assign interlink_io_pid_kd_do = pid_io_reg_kd_do; // @[motor_top.scala 116:29:@12167.4]
  assign interlink_io_pid_ref_do = pid_io_reg_ref_do; // @[motor_top.scala 120:29:@12172.4]
  assign interlink_io_pid_fb_do = pid_io_reg_fb_do; // @[motor_top.scala 124:29:@12177.4]
  assign interlink_io_pid_cfg_do = pid_io_reg_cfg_do; // @[motor_top.scala 128:29:@12182.4]
  assign interlink_io_motor_select = io_motor_select; // @[motor_top.scala 45:29:@12107.4]
  assign pwm_clock = clock; // @[:@12116.4]
  assign pwm_reset = reset; // @[:@12117.4]
  assign pwm_io_reg_val_we = interlink_io_tmr_val_we; // @[motor_top.scala 59:29:@12118.4]
  assign pwm_io_reg_val_di = io_wbs_m2s_data; // @[motor_top.scala 60:29:@12119.4]
  assign pwm_io_reg_cfg_we = interlink_io_tmr_cfg_we; // @[motor_top.scala 63:29:@12121.4]
  assign pwm_io_reg_cfg_di = io_wbs_m2s_data; // @[motor_top.scala 64:29:@12122.4]
  assign pwm_io_reg_dat_we = interlink_io_tmr_dat_we; // @[motor_top.scala 67:29:@12124.4]
  assign pwm_io_reg_dat_di = io_wbs_m2s_data; // @[motor_top.scala 68:29:@12125.4]
  assign pwm_io_reg_duty_we = interlink_io_tmr_duty_we; // @[motor_top.scala 70:29:@12127.4]
  assign pwm_io_reg_duty_di = io_wbs_m2s_data; // @[motor_top.scala 71:29:@12128.4]
  assign pwm_io_reg_pid_out = pid_io_pid_out; // @[motor_top.scala 77:29:@12131.4]
  assign qei_clock = clock; // @[:@12136.4]
  assign qei_reset = reset; // @[:@12137.4]
  assign qei_io_quad_a = io_motor_gpio_qei_ch_a; // @[motor_top.scala 87:29:@12138.4]
  assign qei_io_quad_b = io_motor_gpio_qei_ch_b; // @[motor_top.scala 88:29:@12139.4]
  assign qei_io_raw_irq = pwm_io_rawirq_out; // @[motor_top.scala 89:29:@12140.4]
  assign qei_io_reg_count_we = interlink_io_qei_count_we; // @[motor_top.scala 91:29:@12141.4]
  assign qei_io_reg_count_di = io_wbs_m2s_data; // @[motor_top.scala 92:29:@12142.4]
  assign qei_io_reg_cfg_we = interlink_io_qei_cfg_we; // @[motor_top.scala 95:29:@12144.4]
  assign qei_io_reg_cfg_di = io_wbs_m2s_data; // @[motor_top.scala 96:29:@12145.4]
  assign pid_clock = clock; // @[:@12149.4]
  assign pid_reset = reset; // @[:@12150.4]
  assign pid_io_fb_period = qei_io_fb_period; // @[motor_top.scala 103:29:@12151.4]
  assign pid_io_raw_irq = pwm_io_rawirq_out; // @[motor_top.scala 131:29:@12184.4]
  assign pid_io_reg_kp_we = interlink_io_pid_kp_we; // @[motor_top.scala 106:29:@12153.4]
  assign pid_io_reg_kp_di = {{8{_T_49[7]}},_T_49}; // @[motor_top.scala 107:29:@12156.4]
  assign pid_io_reg_ki_we = interlink_io_pid_ki_we; // @[motor_top.scala 110:29:@12158.4]
  assign pid_io_reg_ki_di = {{8{_T_49[7]}},_T_49}; // @[motor_top.scala 111:29:@12161.4]
  assign pid_io_reg_kd_we = interlink_io_pid_kd_we; // @[motor_top.scala 114:29:@12163.4]
  assign pid_io_reg_kd_di = {{8{_T_49[7]}},_T_49}; // @[motor_top.scala 115:29:@12166.4]
  assign pid_io_reg_ref_we = interlink_io_pid_ref_we; // @[motor_top.scala 118:29:@12168.4]
  assign pid_io_reg_ref_di = $signed(_T_54); // @[motor_top.scala 119:29:@12171.4]
  assign pid_io_reg_fb_we = interlink_io_pid_fb_we; // @[motor_top.scala 122:29:@12173.4]
  assign pid_io_reg_fb_di = $signed(_T_54); // @[motor_top.scala 123:29:@12176.4]
  assign pid_io_reg_cfg_we = interlink_io_pid_cfg_we; // @[motor_top.scala 126:29:@12178.4]
  assign pid_io_reg_cfg_di = $signed(_T_54); // @[motor_top.scala 127:29:@12181.4]
  assign pid_io_speed_fb_in = qei_io_reg_speed_do; // @[motor_top.scala 104:29:@12152.4]
endmodule
module WB_InterConnect( // @[:@28638.2]
  input         clock, // @[:@28639.4]
  input         reset, // @[:@28640.4]
  input  [31:0] io_dbus_addr, // @[:@28641.4]
  input  [31:0] io_dbus_wdata, // @[:@28641.4]
  output [31:0] io_dbus_rdata, // @[:@28641.4]
  input         io_dbus_rd_en, // @[:@28641.4]
  input         io_dbus_wr_en, // @[:@28641.4]
  input  [1:0]  io_dbus_st_type, // @[:@28641.4]
  input  [2:0]  io_dbus_ld_type, // @[:@28641.4]
  output        io_dbus_valid, // @[:@28641.4]
  input  [31:0] io_ibus_addr, // @[:@28641.4]
  output [31:0] io_ibus_inst, // @[:@28641.4]
  output        io_ibus_valid, // @[:@28641.4]
  output        io_uart_tx, // @[:@28641.4]
  input         io_uart_rx, // @[:@28641.4]
  output        io_uart_irq, // @[:@28641.4]
  output        io_spi_cs, // @[:@28641.4]
  output        io_spi_clk, // @[:@28641.4]
  output        io_spi_mosi, // @[:@28641.4]
  input         io_spi_miso, // @[:@28641.4]
  output        io_spi_irq, // @[:@28641.4]
  input         io_m1_io_qei_ch_a, // @[:@28641.4]
  input         io_m1_io_qei_ch_b, // @[:@28641.4]
  output        io_m1_io_pwm_high, // @[:@28641.4]
  output        io_m1_io_pwm_low, // @[:@28641.4]
  input         io_m2_io_qei_ch_a, // @[:@28641.4]
  input         io_m2_io_qei_ch_b, // @[:@28641.4]
  output        io_m2_io_pwm_high, // @[:@28641.4]
  output        io_m2_io_pwm_low, // @[:@28641.4]
  input         io_m3_io_qei_ch_a, // @[:@28641.4]
  input         io_m3_io_qei_ch_b, // @[:@28641.4]
  output        io_m3_io_pwm_high, // @[:@28641.4]
  output        io_m3_io_pwm_low, // @[:@28641.4]
  output        io_m1_irq, // @[:@28641.4]
  output        io_m2_irq, // @[:@28641.4]
  output        io_m3_irq // @[:@28641.4]
);
  wire  dmem_clock; // @[wb_interconnect.scala 65:24:@28643.4]
  wire  dmem_reset; // @[wb_interconnect.scala 65:24:@28643.4]
  wire [15:0] dmem_io_wbs_m2s_addr; // @[wb_interconnect.scala 65:24:@28643.4]
  wire [31:0] dmem_io_wbs_m2s_data; // @[wb_interconnect.scala 65:24:@28643.4]
  wire  dmem_io_wbs_m2s_we; // @[wb_interconnect.scala 65:24:@28643.4]
  wire [3:0] dmem_io_wbs_m2s_sel; // @[wb_interconnect.scala 65:24:@28643.4]
  wire  dmem_io_wbs_m2s_stb; // @[wb_interconnect.scala 65:24:@28643.4]
  wire  dmem_io_wbs_ack_o; // @[wb_interconnect.scala 65:24:@28643.4]
  wire [31:0] dmem_io_wbs_data_o; // @[wb_interconnect.scala 65:24:@28643.4]
  wire  imem_clock; // @[wb_interconnect.scala 66:24:@28646.4]
  wire  imem_reset; // @[wb_interconnect.scala 66:24:@28646.4]
  wire [31:0] imem_io_ibus_addr; // @[wb_interconnect.scala 66:24:@28646.4]
  wire [31:0] imem_io_ibus_inst; // @[wb_interconnect.scala 66:24:@28646.4]
  wire  imem_io_ibus_valid; // @[wb_interconnect.scala 66:24:@28646.4]
  wire [15:0] imem_io_wbs_m2s_addr; // @[wb_interconnect.scala 66:24:@28646.4]
  wire [31:0] imem_io_wbs_m2s_data; // @[wb_interconnect.scala 66:24:@28646.4]
  wire  imem_io_wbs_m2s_we; // @[wb_interconnect.scala 66:24:@28646.4]
  wire [3:0] imem_io_wbs_m2s_sel; // @[wb_interconnect.scala 66:24:@28646.4]
  wire  imem_io_wbs_m2s_stb; // @[wb_interconnect.scala 66:24:@28646.4]
  wire  imem_io_wbs_ack_o; // @[wb_interconnect.scala 66:24:@28646.4]
  wire [31:0] imem_io_wbs_data_o; // @[wb_interconnect.scala 66:24:@28646.4]
  wire [31:0] wbm_dbus_io_dbus_addr; // @[wb_interconnect.scala 67:24:@28649.4]
  wire [31:0] wbm_dbus_io_dbus_wdata; // @[wb_interconnect.scala 67:24:@28649.4]
  wire [31:0] wbm_dbus_io_dbus_rdata; // @[wb_interconnect.scala 67:24:@28649.4]
  wire  wbm_dbus_io_dbus_rd_en; // @[wb_interconnect.scala 67:24:@28649.4]
  wire  wbm_dbus_io_dbus_wr_en; // @[wb_interconnect.scala 67:24:@28649.4]
  wire [1:0] wbm_dbus_io_dbus_st_type; // @[wb_interconnect.scala 67:24:@28649.4]
  wire [2:0] wbm_dbus_io_dbus_ld_type; // @[wb_interconnect.scala 67:24:@28649.4]
  wire  wbm_dbus_io_dbus_valid; // @[wb_interconnect.scala 67:24:@28649.4]
  wire [15:0] wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 67:24:@28649.4]
  wire [31:0] wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 67:24:@28649.4]
  wire  wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 67:24:@28649.4]
  wire [3:0] wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 67:24:@28649.4]
  wire  wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 67:24:@28649.4]
  wire  wbm_dbus_io_wbm_ack_i; // @[wb_interconnect.scala 67:24:@28649.4]
  wire [31:0] wbm_dbus_io_wbm_data_i; // @[wb_interconnect.scala 67:24:@28649.4]
  wire  uart_clock; // @[wb_interconnect.scala 68:24:@28652.4]
  wire  uart_reset; // @[wb_interconnect.scala 68:24:@28652.4]
  wire  uart_io_uart_select; // @[wb_interconnect.scala 68:24:@28652.4]
  wire  uart_io_txd; // @[wb_interconnect.scala 68:24:@28652.4]
  wire  uart_io_rxd; // @[wb_interconnect.scala 68:24:@28652.4]
  wire  uart_io_uartInt; // @[wb_interconnect.scala 68:24:@28652.4]
  wire [15:0] uart_io_wbs_m2s_addr; // @[wb_interconnect.scala 68:24:@28652.4]
  wire [31:0] uart_io_wbs_m2s_data; // @[wb_interconnect.scala 68:24:@28652.4]
  wire  uart_io_wbs_m2s_we; // @[wb_interconnect.scala 68:24:@28652.4]
  wire  uart_io_wbs_m2s_stb; // @[wb_interconnect.scala 68:24:@28652.4]
  wire  uart_io_wbs_ack_o; // @[wb_interconnect.scala 68:24:@28652.4]
  wire [31:0] uart_io_wbs_data_o; // @[wb_interconnect.scala 68:24:@28652.4]
  wire  spi_clock; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  spi_reset; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  spi_io_spi_select; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  spi_io_spi_cs; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  spi_io_spi_clk; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  spi_io_spi_mosi; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  spi_io_spi_miso; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  spi_io_spi_intr; // @[wb_interconnect.scala 69:24:@28655.4]
  wire [15:0] spi_io_wbs_m2s_addr; // @[wb_interconnect.scala 69:24:@28655.4]
  wire [31:0] spi_io_wbs_m2s_data; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  spi_io_wbs_m2s_we; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  spi_io_wbs_m2s_stb; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  spi_io_wbs_ack_o; // @[wb_interconnect.scala 69:24:@28655.4]
  wire [31:0] spi_io_wbs_data_o; // @[wb_interconnect.scala 69:24:@28655.4]
  wire  m1_clock; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m1_reset; // @[wb_interconnect.scala 70:24:@28658.4]
  wire [15:0] m1_io_wbs_m2s_addr; // @[wb_interconnect.scala 70:24:@28658.4]
  wire [31:0] m1_io_wbs_m2s_data; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m1_io_wbs_m2s_we; // @[wb_interconnect.scala 70:24:@28658.4]
  wire [3:0] m1_io_wbs_m2s_sel; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m1_io_wbs_m2s_stb; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m1_io_wbs_ack_o; // @[wb_interconnect.scala 70:24:@28658.4]
  wire [31:0] m1_io_wbs_data_o; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m1_io_motor_gpio_qei_ch_a; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m1_io_motor_gpio_qei_ch_b; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m1_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m1_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m1_io_motor_select; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m1_io_motor_irq; // @[wb_interconnect.scala 70:24:@28658.4]
  wire  m2_clock; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m2_reset; // @[wb_interconnect.scala 71:24:@28661.4]
  wire [15:0] m2_io_wbs_m2s_addr; // @[wb_interconnect.scala 71:24:@28661.4]
  wire [31:0] m2_io_wbs_m2s_data; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m2_io_wbs_m2s_we; // @[wb_interconnect.scala 71:24:@28661.4]
  wire [3:0] m2_io_wbs_m2s_sel; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m2_io_wbs_m2s_stb; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m2_io_wbs_ack_o; // @[wb_interconnect.scala 71:24:@28661.4]
  wire [31:0] m2_io_wbs_data_o; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m2_io_motor_gpio_qei_ch_a; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m2_io_motor_gpio_qei_ch_b; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m2_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m2_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m2_io_motor_select; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m2_io_motor_irq; // @[wb_interconnect.scala 71:24:@28661.4]
  wire  m3_clock; // @[wb_interconnect.scala 72:24:@28664.4]
  wire  m3_reset; // @[wb_interconnect.scala 72:24:@28664.4]
  wire [15:0] m3_io_wbs_m2s_addr; // @[wb_interconnect.scala 72:24:@28664.4]
  wire [31:0] m3_io_wbs_m2s_data; // @[wb_interconnect.scala 72:24:@28664.4]
  wire  m3_io_wbs_m2s_we; // @[wb_interconnect.scala 72:24:@28664.4]
  wire [3:0] m3_io_wbs_m2s_sel; // @[wb_interconnect.scala 72:24:@28664.4]
  wire  m3_io_wbs_m2s_stb; // @[wb_interconnect.scala 72:24:@28664.4]
  wire  m3_io_wbs_ack_o; // @[wb_interconnect.scala 72:24:@28664.4]
  wire [31:0] m3_io_wbs_data_o; // @[wb_interconnect.scala 72:24:@28664.4]
  wire  m3_io_motor_gpio_qei_ch_a; // @[wb_interconnect.scala 72:24:@28664.4]
  wire  m3_io_motor_gpio_qei_ch_b; // @[wb_interconnect.scala 72:24:@28664.4]
  wire  m3_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 72:24:@28664.4]
  wire  m3_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 72:24:@28664.4]
  wire  m3_io_motor_select; // @[wb_interconnect.scala 72:24:@28664.4]
  wire  m3_io_motor_irq; // @[wb_interconnect.scala 72:24:@28664.4]
  wire [3:0] address; // @[wb_interconnect.scala 79:50:@28678.4]
  wire  imem_addr_match; // @[wb_interconnect.scala 80:35:@28679.4]
  wire  dmem_addr_match; // @[wb_interconnect.scala 81:35:@28680.4]
  wire  uart_addr_match; // @[wb_interconnect.scala 82:35:@28681.4]
  wire  spi_addr_match; // @[wb_interconnect.scala 83:35:@28682.4]
  wire  m1_addr_match; // @[wb_interconnect.scala 84:35:@28683.4]
  reg  imem_sel; // @[wb_interconnect.scala 107:22:@28728.4]
  reg [31:0] _RAND_0;
  reg  dmem_sel; // @[wb_interconnect.scala 108:22:@28729.4]
  reg [31:0] _RAND_1;
  reg  uart_sel; // @[wb_interconnect.scala 109:22:@28730.4]
  reg [31:0] _RAND_2;
  reg  spi_sel; // @[wb_interconnect.scala 110:22:@28731.4]
  reg [31:0] _RAND_3;
  reg  m1_sel; // @[wb_interconnect.scala 111:22:@28732.4]
  reg [31:0] _RAND_4;
  reg  m2_sel; // @[wb_interconnect.scala 112:22:@28733.4]
  reg [31:0] _RAND_5;
  reg  m3_sel; // @[wb_interconnect.scala 113:22:@28734.4]
  reg [31:0] _RAND_6;
  wire [31:0] _T_88; // @[wb_interconnect.scala 129:45:@28749.4]
  wire [31:0] _T_89; // @[wb_interconnect.scala 128:43:@28750.4]
  wire [31:0] _T_90; // @[wb_interconnect.scala 127:41:@28751.4]
  wire [31:0] _T_91; // @[wb_interconnect.scala 126:39:@28752.4]
  wire [31:0] _T_92; // @[wb_interconnect.scala 125:37:@28753.4]
  wire [31:0] _T_93; // @[wb_interconnect.scala 124:35:@28754.4]
  wire  _T_96; // @[wb_interconnect.scala 136:45:@28757.4]
  wire  _T_97; // @[wb_interconnect.scala 135:43:@28758.4]
  wire  _T_98; // @[wb_interconnect.scala 134:41:@28759.4]
  wire  _T_99; // @[wb_interconnect.scala 133:39:@28760.4]
  wire  _T_100; // @[wb_interconnect.scala 132:37:@28761.4]
  wire  _T_101; // @[wb_interconnect.scala 131:35:@28762.4]
  DMem_Interface dmem ( // @[wb_interconnect.scala 65:24:@28643.4]
    .clock(dmem_clock),
    .reset(dmem_reset),
    .io_wbs_m2s_addr(dmem_io_wbs_m2s_addr),
    .io_wbs_m2s_data(dmem_io_wbs_m2s_data),
    .io_wbs_m2s_we(dmem_io_wbs_m2s_we),
    .io_wbs_m2s_sel(dmem_io_wbs_m2s_sel),
    .io_wbs_m2s_stb(dmem_io_wbs_m2s_stb),
    .io_wbs_ack_o(dmem_io_wbs_ack_o),
    .io_wbs_data_o(dmem_io_wbs_data_o)
  );
  IMem_Interface imem ( // @[wb_interconnect.scala 66:24:@28646.4]
    .clock(imem_clock),
    .reset(imem_reset),
    .io_ibus_addr(imem_io_ibus_addr),
    .io_ibus_inst(imem_io_ibus_inst),
    .io_ibus_valid(imem_io_ibus_valid),
    .io_wbs_m2s_addr(imem_io_wbs_m2s_addr),
    .io_wbs_m2s_data(imem_io_wbs_m2s_data),
    .io_wbs_m2s_we(imem_io_wbs_m2s_we),
    .io_wbs_m2s_sel(imem_io_wbs_m2s_sel),
    .io_wbs_m2s_stb(imem_io_wbs_m2s_stb),
    .io_wbs_ack_o(imem_io_wbs_ack_o),
    .io_wbs_data_o(imem_io_wbs_data_o)
  );
  WBM_DBus wbm_dbus ( // @[wb_interconnect.scala 67:24:@28649.4]
    .io_dbus_addr(wbm_dbus_io_dbus_addr),
    .io_dbus_wdata(wbm_dbus_io_dbus_wdata),
    .io_dbus_rdata(wbm_dbus_io_dbus_rdata),
    .io_dbus_rd_en(wbm_dbus_io_dbus_rd_en),
    .io_dbus_wr_en(wbm_dbus_io_dbus_wr_en),
    .io_dbus_st_type(wbm_dbus_io_dbus_st_type),
    .io_dbus_ld_type(wbm_dbus_io_dbus_ld_type),
    .io_dbus_valid(wbm_dbus_io_dbus_valid),
    .io_wbm_m2s_addr(wbm_dbus_io_wbm_m2s_addr),
    .io_wbm_m2s_data(wbm_dbus_io_wbm_m2s_data),
    .io_wbm_m2s_we(wbm_dbus_io_wbm_m2s_we),
    .io_wbm_m2s_sel(wbm_dbus_io_wbm_m2s_sel),
    .io_wbm_m2s_stb(wbm_dbus_io_wbm_m2s_stb),
    .io_wbm_ack_i(wbm_dbus_io_wbm_ack_i),
    .io_wbm_data_i(wbm_dbus_io_wbm_data_i)
  );
  UART uart ( // @[wb_interconnect.scala 68:24:@28652.4]
    .clock(uart_clock),
    .reset(uart_reset),
    .io_uart_select(uart_io_uart_select),
    .io_txd(uart_io_txd),
    .io_rxd(uart_io_rxd),
    .io_uartInt(uart_io_uartInt),
    .io_wbs_m2s_addr(uart_io_wbs_m2s_addr),
    .io_wbs_m2s_data(uart_io_wbs_m2s_data),
    .io_wbs_m2s_we(uart_io_wbs_m2s_we),
    .io_wbs_m2s_stb(uart_io_wbs_m2s_stb),
    .io_wbs_ack_o(uart_io_wbs_ack_o),
    .io_wbs_data_o(uart_io_wbs_data_o)
  );
  SPI spi ( // @[wb_interconnect.scala 69:24:@28655.4]
    .clock(spi_clock),
    .reset(spi_reset),
    .io_spi_select(spi_io_spi_select),
    .io_spi_cs(spi_io_spi_cs),
    .io_spi_clk(spi_io_spi_clk),
    .io_spi_mosi(spi_io_spi_mosi),
    .io_spi_miso(spi_io_spi_miso),
    .io_spi_intr(spi_io_spi_intr),
    .io_wbs_m2s_addr(spi_io_wbs_m2s_addr),
    .io_wbs_m2s_data(spi_io_wbs_m2s_data),
    .io_wbs_m2s_we(spi_io_wbs_m2s_we),
    .io_wbs_m2s_stb(spi_io_wbs_m2s_stb),
    .io_wbs_ack_o(spi_io_wbs_ack_o),
    .io_wbs_data_o(spi_io_wbs_data_o)
  );
  Motor_Top m1 ( // @[wb_interconnect.scala 70:24:@28658.4]
    .clock(m1_clock),
    .reset(m1_reset),
    .io_wbs_m2s_addr(m1_io_wbs_m2s_addr),
    .io_wbs_m2s_data(m1_io_wbs_m2s_data),
    .io_wbs_m2s_we(m1_io_wbs_m2s_we),
    .io_wbs_m2s_sel(m1_io_wbs_m2s_sel),
    .io_wbs_m2s_stb(m1_io_wbs_m2s_stb),
    .io_wbs_ack_o(m1_io_wbs_ack_o),
    .io_wbs_data_o(m1_io_wbs_data_o),
    .io_motor_gpio_qei_ch_a(m1_io_motor_gpio_qei_ch_a),
    .io_motor_gpio_qei_ch_b(m1_io_motor_gpio_qei_ch_b),
    .io_motor_gpio_pwm_high(m1_io_motor_gpio_pwm_high),
    .io_motor_gpio_pwm_low(m1_io_motor_gpio_pwm_low),
    .io_motor_select(m1_io_motor_select),
    .io_motor_irq(m1_io_motor_irq)
  );
  Motor_Top m2 ( // @[wb_interconnect.scala 71:24:@28661.4]
    .clock(m2_clock),
    .reset(m2_reset),
    .io_wbs_m2s_addr(m2_io_wbs_m2s_addr),
    .io_wbs_m2s_data(m2_io_wbs_m2s_data),
    .io_wbs_m2s_we(m2_io_wbs_m2s_we),
    .io_wbs_m2s_sel(m2_io_wbs_m2s_sel),
    .io_wbs_m2s_stb(m2_io_wbs_m2s_stb),
    .io_wbs_ack_o(m2_io_wbs_ack_o),
    .io_wbs_data_o(m2_io_wbs_data_o),
    .io_motor_gpio_qei_ch_a(m2_io_motor_gpio_qei_ch_a),
    .io_motor_gpio_qei_ch_b(m2_io_motor_gpio_qei_ch_b),
    .io_motor_gpio_pwm_high(m2_io_motor_gpio_pwm_high),
    .io_motor_gpio_pwm_low(m2_io_motor_gpio_pwm_low),
    .io_motor_select(m2_io_motor_select),
    .io_motor_irq(m2_io_motor_irq)
  );
  Motor_Top m3 ( // @[wb_interconnect.scala 72:24:@28664.4]
    .clock(m3_clock),
    .reset(m3_reset),
    .io_wbs_m2s_addr(m3_io_wbs_m2s_addr),
    .io_wbs_m2s_data(m3_io_wbs_m2s_data),
    .io_wbs_m2s_we(m3_io_wbs_m2s_we),
    .io_wbs_m2s_sel(m3_io_wbs_m2s_sel),
    .io_wbs_m2s_stb(m3_io_wbs_m2s_stb),
    .io_wbs_ack_o(m3_io_wbs_ack_o),
    .io_wbs_data_o(m3_io_wbs_data_o),
    .io_motor_gpio_qei_ch_a(m3_io_motor_gpio_qei_ch_a),
    .io_motor_gpio_qei_ch_b(m3_io_motor_gpio_qei_ch_b),
    .io_motor_gpio_pwm_high(m3_io_motor_gpio_pwm_high),
    .io_motor_gpio_pwm_low(m3_io_motor_gpio_pwm_low),
    .io_motor_select(m3_io_motor_select),
    .io_motor_irq(m3_io_motor_irq)
  );
  assign address = wbm_dbus_io_wbm_m2s_addr[15:12]; // @[wb_interconnect.scala 79:50:@28678.4]
  assign imem_addr_match = address == 4'h0; // @[wb_interconnect.scala 80:35:@28679.4]
  assign dmem_addr_match = address == 4'h1; // @[wb_interconnect.scala 81:35:@28680.4]
  assign uart_addr_match = address == 4'h2; // @[wb_interconnect.scala 82:35:@28681.4]
  assign spi_addr_match = address == 4'h3; // @[wb_interconnect.scala 83:35:@28682.4]
  assign m1_addr_match = address == 4'h4; // @[wb_interconnect.scala 84:35:@28683.4]
  assign _T_88 = m3_sel ? m3_io_wbs_data_o : 32'h0; // @[wb_interconnect.scala 129:45:@28749.4]
  assign _T_89 = m2_sel ? m2_io_wbs_data_o : _T_88; // @[wb_interconnect.scala 128:43:@28750.4]
  assign _T_90 = m1_sel ? m1_io_wbs_data_o : _T_89; // @[wb_interconnect.scala 127:41:@28751.4]
  assign _T_91 = spi_sel ? spi_io_wbs_data_o : _T_90; // @[wb_interconnect.scala 126:39:@28752.4]
  assign _T_92 = uart_sel ? uart_io_wbs_data_o : _T_91; // @[wb_interconnect.scala 125:37:@28753.4]
  assign _T_93 = imem_sel ? imem_io_wbs_data_o : _T_92; // @[wb_interconnect.scala 124:35:@28754.4]
  assign _T_96 = m3_sel ? m3_io_wbs_ack_o : 1'h0; // @[wb_interconnect.scala 136:45:@28757.4]
  assign _T_97 = m2_sel ? m2_io_wbs_ack_o : _T_96; // @[wb_interconnect.scala 135:43:@28758.4]
  assign _T_98 = m1_sel ? m1_io_wbs_ack_o : _T_97; // @[wb_interconnect.scala 134:41:@28759.4]
  assign _T_99 = spi_sel ? spi_io_wbs_ack_o : _T_98; // @[wb_interconnect.scala 133:39:@28760.4]
  assign _T_100 = uart_sel ? uart_io_wbs_ack_o : _T_99; // @[wb_interconnect.scala 132:37:@28761.4]
  assign _T_101 = imem_sel ? imem_io_wbs_ack_o : _T_100; // @[wb_interconnect.scala 131:35:@28762.4]
  assign io_dbus_rdata = wbm_dbus_io_dbus_rdata; // @[wb_interconnect.scala 75:20:@28672.4]
  assign io_dbus_valid = wbm_dbus_io_dbus_valid; // @[wb_interconnect.scala 75:20:@28667.4]
  assign io_ibus_inst = imem_io_ibus_inst; // @[wb_interconnect.scala 76:20:@28676.4]
  assign io_ibus_valid = imem_io_ibus_valid; // @[wb_interconnect.scala 76:20:@28675.4]
  assign io_uart_tx = uart_io_txd; // @[wb_interconnect.scala 142:24:@28767.4]
  assign io_uart_irq = uart_io_uartInt; // @[wb_interconnect.scala 143:24:@28768.4]
  assign io_spi_cs = spi_io_spi_cs; // @[wb_interconnect.scala 148:24:@28771.4]
  assign io_spi_clk = spi_io_spi_clk; // @[wb_interconnect.scala 149:24:@28772.4]
  assign io_spi_mosi = spi_io_spi_mosi; // @[wb_interconnect.scala 150:24:@28773.4]
  assign io_spi_irq = spi_io_spi_intr; // @[wb_interconnect.scala 151:24:@28774.4]
  assign io_m1_io_pwm_high = m1_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 154:24:@28776.4]
  assign io_m1_io_pwm_low = m1_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 154:24:@28775.4]
  assign io_m2_io_pwm_high = m2_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 158:24:@28782.4]
  assign io_m2_io_pwm_low = m2_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 158:24:@28781.4]
  assign io_m3_io_pwm_high = m3_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 162:24:@28788.4]
  assign io_m3_io_pwm_low = m3_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 162:24:@28787.4]
  assign io_m1_irq = m1_io_motor_irq; // @[wb_interconnect.scala 156:24:@28780.4]
  assign io_m2_irq = m2_io_motor_irq; // @[wb_interconnect.scala 160:24:@28786.4]
  assign io_m3_irq = m3_io_motor_irq; // @[wb_interconnect.scala 164:24:@28792.4]
  assign dmem_clock = clock; // @[:@28644.4]
  assign dmem_reset = reset; // @[:@28645.4]
  assign dmem_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 89:20:@28691.4]
  assign dmem_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 89:20:@28690.4]
  assign dmem_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 89:20:@28689.4]
  assign dmem_io_wbs_m2s_sel = wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 89:20:@28688.4]
  assign dmem_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 89:20:@28687.4]
  assign imem_clock = clock; // @[:@28647.4]
  assign imem_reset = reset; // @[:@28648.4]
  assign imem_io_ibus_addr = io_ibus_addr; // @[wb_interconnect.scala 76:20:@28677.4]
  assign imem_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 93:20:@28697.4]
  assign imem_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 93:20:@28696.4]
  assign imem_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 93:20:@28695.4]
  assign imem_io_wbs_m2s_sel = wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 93:20:@28694.4]
  assign imem_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 93:20:@28693.4]
  assign wbm_dbus_io_dbus_addr = io_dbus_addr; // @[wb_interconnect.scala 75:20:@28674.4]
  assign wbm_dbus_io_dbus_wdata = io_dbus_wdata; // @[wb_interconnect.scala 75:20:@28673.4]
  assign wbm_dbus_io_dbus_rd_en = io_dbus_rd_en; // @[wb_interconnect.scala 75:20:@28671.4]
  assign wbm_dbus_io_dbus_wr_en = io_dbus_wr_en; // @[wb_interconnect.scala 75:20:@28670.4]
  assign wbm_dbus_io_dbus_st_type = io_dbus_st_type; // @[wb_interconnect.scala 75:20:@28669.4]
  assign wbm_dbus_io_dbus_ld_type = io_dbus_ld_type; // @[wb_interconnect.scala 75:20:@28668.4]
  assign wbm_dbus_io_wbm_ack_i = dmem_sel ? dmem_io_wbs_ack_o : _T_101; // @[wb_interconnect.scala 130:26:@28764.4]
  assign wbm_dbus_io_wbm_data_i = dmem_sel ? dmem_io_wbs_data_o : _T_93; // @[wb_interconnect.scala 123:26:@28756.4]
  assign uart_clock = clock; // @[:@28653.4]
  assign uart_reset = reset; // @[:@28654.4]
  assign uart_io_uart_select = address == 4'h2; // @[wb_interconnect.scala 140:24:@28765.4]
  assign uart_io_rxd = io_uart_rx; // @[wb_interconnect.scala 141:24:@28766.4]
  assign uart_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 96:20:@28703.4]
  assign uart_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 96:20:@28702.4]
  assign uart_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 96:20:@28701.4]
  assign uart_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 96:20:@28699.4]
  assign spi_clock = clock; // @[:@28656.4]
  assign spi_reset = reset; // @[:@28657.4]
  assign spi_io_spi_select = address == 4'h3; // @[wb_interconnect.scala 146:24:@28769.4]
  assign spi_io_spi_miso = io_spi_miso; // @[wb_interconnect.scala 147:24:@28770.4]
  assign spi_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 99:19:@28709.4]
  assign spi_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 99:19:@28708.4]
  assign spi_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 99:19:@28707.4]
  assign spi_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 99:19:@28705.4]
  assign m1_clock = clock; // @[:@28659.4]
  assign m1_reset = reset; // @[:@28660.4]
  assign m1_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 102:17:@28715.4]
  assign m1_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 102:17:@28714.4]
  assign m1_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 102:17:@28713.4]
  assign m1_io_wbs_m2s_sel = wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 102:17:@28712.4]
  assign m1_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 102:17:@28711.4]
  assign m1_io_motor_gpio_qei_ch_a = io_m1_io_qei_ch_a; // @[wb_interconnect.scala 154:24:@28778.4]
  assign m1_io_motor_gpio_qei_ch_b = io_m1_io_qei_ch_b; // @[wb_interconnect.scala 154:24:@28777.4]
  assign m1_io_motor_select = address == 4'h4; // @[wb_interconnect.scala 155:24:@28779.4]
  assign m2_clock = clock; // @[:@28662.4]
  assign m2_reset = reset; // @[:@28663.4]
  assign m2_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 103:17:@28721.4]
  assign m2_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 103:17:@28720.4]
  assign m2_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 103:17:@28719.4]
  assign m2_io_wbs_m2s_sel = wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 103:17:@28718.4]
  assign m2_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 103:17:@28717.4]
  assign m2_io_motor_gpio_qei_ch_a = io_m2_io_qei_ch_a; // @[wb_interconnect.scala 158:24:@28784.4]
  assign m2_io_motor_gpio_qei_ch_b = io_m2_io_qei_ch_b; // @[wb_interconnect.scala 158:24:@28783.4]
  assign m2_io_motor_select = address == 4'h4; // @[wb_interconnect.scala 159:24:@28785.4]
  assign m3_clock = clock; // @[:@28665.4]
  assign m3_reset = reset; // @[:@28666.4]
  assign m3_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 104:17:@28727.4]
  assign m3_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 104:17:@28726.4]
  assign m3_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 104:17:@28725.4]
  assign m3_io_wbs_m2s_sel = wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 104:17:@28724.4]
  assign m3_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 104:17:@28723.4]
  assign m3_io_motor_gpio_qei_ch_a = io_m3_io_qei_ch_a; // @[wb_interconnect.scala 162:24:@28790.4]
  assign m3_io_motor_gpio_qei_ch_b = io_m3_io_qei_ch_b; // @[wb_interconnect.scala 162:24:@28789.4]
  assign m3_io_motor_select = address == 4'h4; // @[wb_interconnect.scala 163:24:@28791.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  imem_sel = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  dmem_sel = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  uart_sel = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  spi_sel = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  m1_sel = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  m2_sel = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  m3_sel = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    imem_sel <= imem_addr_match & imem_io_wbs_m2s_stb;
    dmem_sel <= dmem_addr_match & dmem_io_wbs_m2s_stb;
    uart_sel <= uart_addr_match & uart_io_wbs_m2s_stb;
    spi_sel <= spi_addr_match & spi_io_wbs_m2s_stb;
    m1_sel <= m1_addr_match & m1_io_wbs_m2s_stb;
    m2_sel <= m1_addr_match & m2_io_wbs_m2s_stb;
    m3_sel <= m1_addr_match & m3_io_wbs_m2s_stb;
  end
endmodule
module SoC_Tile( // @[:@28794.2]
  input   clock, // @[:@28795.4]
  input   reset, // @[:@28796.4]
  output  io_uart_tx, // @[:@28797.4]
  input   io_uart_rx, // @[:@28797.4]
  output  io_spi_cs, // @[:@28797.4]
  output  io_spi_clk, // @[:@28797.4]
  output  io_spi_mosi, // @[:@28797.4]
  input   io_spi_miso, // @[:@28797.4]
  input   io_m1_io_qei_ch_a, // @[:@28797.4]
  input   io_m1_io_qei_ch_b, // @[:@28797.4]
  output  io_m1_io_pwm_high, // @[:@28797.4]
  output  io_m1_io_pwm_low, // @[:@28797.4]
  input   io_m2_io_qei_ch_a, // @[:@28797.4]
  input   io_m2_io_qei_ch_b, // @[:@28797.4]
  output  io_m2_io_pwm_high, // @[:@28797.4]
  output  io_m2_io_pwm_low, // @[:@28797.4]
  input   io_m3_io_qei_ch_a, // @[:@28797.4]
  input   io_m3_io_qei_ch_b, // @[:@28797.4]
  output  io_m3_io_pwm_high, // @[:@28797.4]
  output  io_m3_io_pwm_low // @[:@28797.4]
);
  wire  core_clock; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  core_reset; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  core_io_irq_uart_irq; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  core_io_irq_spi_irq; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  core_io_irq_m1_irq; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  core_io_irq_m2_irq; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  core_io_irq_m3_irq; // @[SoC_Tile.scala 48:32:@28799.4]
  wire [31:0] core_io_ibus_addr; // @[SoC_Tile.scala 48:32:@28799.4]
  wire [31:0] core_io_ibus_inst; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  core_io_ibus_valid; // @[SoC_Tile.scala 48:32:@28799.4]
  wire [31:0] core_io_dbus_addr; // @[SoC_Tile.scala 48:32:@28799.4]
  wire [31:0] core_io_dbus_wdata; // @[SoC_Tile.scala 48:32:@28799.4]
  wire [31:0] core_io_dbus_rdata; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  core_io_dbus_rd_en; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  core_io_dbus_wr_en; // @[SoC_Tile.scala 48:32:@28799.4]
  wire [1:0] core_io_dbus_st_type; // @[SoC_Tile.scala 48:32:@28799.4]
  wire [2:0] core_io_dbus_ld_type; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  core_io_dbus_valid; // @[SoC_Tile.scala 48:32:@28799.4]
  wire  wb_inter_connect_clock; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_reset; // @[SoC_Tile.scala 49:32:@28802.4]
  wire [31:0] wb_inter_connect_io_dbus_addr; // @[SoC_Tile.scala 49:32:@28802.4]
  wire [31:0] wb_inter_connect_io_dbus_wdata; // @[SoC_Tile.scala 49:32:@28802.4]
  wire [31:0] wb_inter_connect_io_dbus_rdata; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_dbus_rd_en; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_dbus_wr_en; // @[SoC_Tile.scala 49:32:@28802.4]
  wire [1:0] wb_inter_connect_io_dbus_st_type; // @[SoC_Tile.scala 49:32:@28802.4]
  wire [2:0] wb_inter_connect_io_dbus_ld_type; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_dbus_valid; // @[SoC_Tile.scala 49:32:@28802.4]
  wire [31:0] wb_inter_connect_io_ibus_addr; // @[SoC_Tile.scala 49:32:@28802.4]
  wire [31:0] wb_inter_connect_io_ibus_inst; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_ibus_valid; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_uart_tx; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_uart_rx; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_uart_irq; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_spi_cs; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_spi_clk; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_spi_mosi; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_spi_miso; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_spi_irq; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m1_io_qei_ch_a; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m1_io_qei_ch_b; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m1_io_pwm_high; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m1_io_pwm_low; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m2_io_qei_ch_a; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m2_io_qei_ch_b; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m2_io_pwm_high; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m2_io_pwm_low; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m3_io_qei_ch_a; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m3_io_qei_ch_b; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m3_io_pwm_high; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m3_io_pwm_low; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m1_irq; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m2_irq; // @[SoC_Tile.scala 49:32:@28802.4]
  wire  wb_inter_connect_io_m3_irq; // @[SoC_Tile.scala 49:32:@28802.4]
  Core core ( // @[SoC_Tile.scala 48:32:@28799.4]
    .clock(core_clock),
    .reset(core_reset),
    .io_irq_uart_irq(core_io_irq_uart_irq),
    .io_irq_spi_irq(core_io_irq_spi_irq),
    .io_irq_m1_irq(core_io_irq_m1_irq),
    .io_irq_m2_irq(core_io_irq_m2_irq),
    .io_irq_m3_irq(core_io_irq_m3_irq),
    .io_ibus_addr(core_io_ibus_addr),
    .io_ibus_inst(core_io_ibus_inst),
    .io_ibus_valid(core_io_ibus_valid),
    .io_dbus_addr(core_io_dbus_addr),
    .io_dbus_wdata(core_io_dbus_wdata),
    .io_dbus_rdata(core_io_dbus_rdata),
    .io_dbus_rd_en(core_io_dbus_rd_en),
    .io_dbus_wr_en(core_io_dbus_wr_en),
    .io_dbus_st_type(core_io_dbus_st_type),
    .io_dbus_ld_type(core_io_dbus_ld_type),
    .io_dbus_valid(core_io_dbus_valid)
  );
  WB_InterConnect wb_inter_connect ( // @[SoC_Tile.scala 49:32:@28802.4]
    .clock(wb_inter_connect_clock),
    .reset(wb_inter_connect_reset),
    .io_dbus_addr(wb_inter_connect_io_dbus_addr),
    .io_dbus_wdata(wb_inter_connect_io_dbus_wdata),
    .io_dbus_rdata(wb_inter_connect_io_dbus_rdata),
    .io_dbus_rd_en(wb_inter_connect_io_dbus_rd_en),
    .io_dbus_wr_en(wb_inter_connect_io_dbus_wr_en),
    .io_dbus_st_type(wb_inter_connect_io_dbus_st_type),
    .io_dbus_ld_type(wb_inter_connect_io_dbus_ld_type),
    .io_dbus_valid(wb_inter_connect_io_dbus_valid),
    .io_ibus_addr(wb_inter_connect_io_ibus_addr),
    .io_ibus_inst(wb_inter_connect_io_ibus_inst),
    .io_ibus_valid(wb_inter_connect_io_ibus_valid),
    .io_uart_tx(wb_inter_connect_io_uart_tx),
    .io_uart_rx(wb_inter_connect_io_uart_rx),
    .io_uart_irq(wb_inter_connect_io_uart_irq),
    .io_spi_cs(wb_inter_connect_io_spi_cs),
    .io_spi_clk(wb_inter_connect_io_spi_clk),
    .io_spi_mosi(wb_inter_connect_io_spi_mosi),
    .io_spi_miso(wb_inter_connect_io_spi_miso),
    .io_spi_irq(wb_inter_connect_io_spi_irq),
    .io_m1_io_qei_ch_a(wb_inter_connect_io_m1_io_qei_ch_a),
    .io_m1_io_qei_ch_b(wb_inter_connect_io_m1_io_qei_ch_b),
    .io_m1_io_pwm_high(wb_inter_connect_io_m1_io_pwm_high),
    .io_m1_io_pwm_low(wb_inter_connect_io_m1_io_pwm_low),
    .io_m2_io_qei_ch_a(wb_inter_connect_io_m2_io_qei_ch_a),
    .io_m2_io_qei_ch_b(wb_inter_connect_io_m2_io_qei_ch_b),
    .io_m2_io_pwm_high(wb_inter_connect_io_m2_io_pwm_high),
    .io_m2_io_pwm_low(wb_inter_connect_io_m2_io_pwm_low),
    .io_m3_io_qei_ch_a(wb_inter_connect_io_m3_io_qei_ch_a),
    .io_m3_io_qei_ch_b(wb_inter_connect_io_m3_io_qei_ch_b),
    .io_m3_io_pwm_high(wb_inter_connect_io_m3_io_pwm_high),
    .io_m3_io_pwm_low(wb_inter_connect_io_m3_io_pwm_low),
    .io_m1_irq(wb_inter_connect_io_m1_irq),
    .io_m2_irq(wb_inter_connect_io_m2_irq),
    .io_m3_irq(wb_inter_connect_io_m3_irq)
  );
  assign io_uart_tx = wb_inter_connect_io_uart_tx; // @[SoC_Tile.scala 56:32:@28816.4]
  assign io_spi_cs = wb_inter_connect_io_spi_cs; // @[SoC_Tile.scala 61:32:@28819.4]
  assign io_spi_clk = wb_inter_connect_io_spi_clk; // @[SoC_Tile.scala 62:32:@28820.4]
  assign io_spi_mosi = wb_inter_connect_io_spi_mosi; // @[SoC_Tile.scala 63:32:@28821.4]
  assign io_m1_io_pwm_high = wb_inter_connect_io_m1_io_pwm_high; // @[SoC_Tile.scala 68:12:@28825.4]
  assign io_m1_io_pwm_low = wb_inter_connect_io_m1_io_pwm_low; // @[SoC_Tile.scala 68:12:@28824.4]
  assign io_m2_io_pwm_high = wb_inter_connect_io_m2_io_pwm_high; // @[SoC_Tile.scala 69:12:@28829.4]
  assign io_m2_io_pwm_low = wb_inter_connect_io_m2_io_pwm_low; // @[SoC_Tile.scala 69:12:@28828.4]
  assign io_m3_io_pwm_high = wb_inter_connect_io_m3_io_pwm_high; // @[SoC_Tile.scala 70:12:@28833.4]
  assign io_m3_io_pwm_low = wb_inter_connect_io_m3_io_pwm_low; // @[SoC_Tile.scala 70:12:@28832.4]
  assign core_clock = clock; // @[:@28800.4]
  assign core_reset = reset; // @[:@28801.4]
  assign core_io_irq_uart_irq = wb_inter_connect_io_uart_irq; // @[SoC_Tile.scala 58:32:@28818.4]
  assign core_io_irq_spi_irq = wb_inter_connect_io_spi_irq; // @[SoC_Tile.scala 65:32:@28823.4]
  assign core_io_irq_m1_irq = wb_inter_connect_io_m1_irq; // @[SoC_Tile.scala 73:22:@28836.4]
  assign core_io_irq_m2_irq = wb_inter_connect_io_m2_irq; // @[SoC_Tile.scala 74:22:@28837.4]
  assign core_io_irq_m3_irq = wb_inter_connect_io_m3_irq; // @[SoC_Tile.scala 75:22:@28838.4]
  assign core_io_ibus_inst = wb_inter_connect_io_ibus_inst; // @[SoC_Tile.scala 52:24:@28806.4]
  assign core_io_ibus_valid = wb_inter_connect_io_ibus_valid; // @[SoC_Tile.scala 52:24:@28805.4]
  assign core_io_dbus_rdata = wb_inter_connect_io_dbus_rdata; // @[SoC_Tile.scala 53:24:@28813.4]
  assign core_io_dbus_valid = wb_inter_connect_io_dbus_valid; // @[SoC_Tile.scala 53:24:@28808.4]
  assign wb_inter_connect_clock = clock; // @[:@28803.4]
  assign wb_inter_connect_reset = reset; // @[:@28804.4]
  assign wb_inter_connect_io_dbus_addr = core_io_dbus_addr; // @[SoC_Tile.scala 53:24:@28815.4]
  assign wb_inter_connect_io_dbus_wdata = core_io_dbus_wdata; // @[SoC_Tile.scala 53:24:@28814.4]
  assign wb_inter_connect_io_dbus_rd_en = core_io_dbus_rd_en; // @[SoC_Tile.scala 53:24:@28812.4]
  assign wb_inter_connect_io_dbus_wr_en = core_io_dbus_wr_en; // @[SoC_Tile.scala 53:24:@28811.4]
  assign wb_inter_connect_io_dbus_st_type = core_io_dbus_st_type; // @[SoC_Tile.scala 53:24:@28810.4]
  assign wb_inter_connect_io_dbus_ld_type = core_io_dbus_ld_type; // @[SoC_Tile.scala 53:24:@28809.4]
  assign wb_inter_connect_io_ibus_addr = core_io_ibus_addr; // @[SoC_Tile.scala 52:24:@28807.4]
  assign wb_inter_connect_io_uart_rx = io_uart_rx; // @[SoC_Tile.scala 57:32:@28817.4]
  assign wb_inter_connect_io_spi_miso = io_spi_miso; // @[SoC_Tile.scala 64:32:@28822.4]
  assign wb_inter_connect_io_m1_io_qei_ch_a = io_m1_io_qei_ch_a; // @[SoC_Tile.scala 68:12:@28827.4]
  assign wb_inter_connect_io_m1_io_qei_ch_b = io_m1_io_qei_ch_b; // @[SoC_Tile.scala 68:12:@28826.4]
  assign wb_inter_connect_io_m2_io_qei_ch_a = io_m2_io_qei_ch_a; // @[SoC_Tile.scala 69:12:@28831.4]
  assign wb_inter_connect_io_m2_io_qei_ch_b = io_m2_io_qei_ch_b; // @[SoC_Tile.scala 69:12:@28830.4]
  assign wb_inter_connect_io_m3_io_qei_ch_a = io_m3_io_qei_ch_a; // @[SoC_Tile.scala 70:12:@28835.4]
  assign wb_inter_connect_io_m3_io_qei_ch_b = io_m3_io_qei_ch_b; // @[SoC_Tile.scala 70:12:@28834.4]
endmodule
