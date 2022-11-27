module CSR(
  input         clock,
  input         reset,
  input         io_stall,
  input  [2:0]  io_cmd,
  input  [31:0] io_in,
  output [31:0] io_out,
  input  [31:0] io_pc,
  input  [31:0] io_addr,
  input  [31:0] io_inst,
  input         io_illegal,
  input  [1:0]  io_st_type,
  input  [2:0]  io_ld_type,
  input         io_pc_check,
  output        io_expt,
  output [31:0] io_evec,
  output [31:0] io_epc,
  input         io_irq_uart_irq,
  input         io_irq_spi_irq,
  input         io_irq_m1_irq,
  input         io_irq_m2_irq,
  input         io_irq_m3_irq,
  input         io_br_taken
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  wire [11:0] csr_addr = io_inst[31:20]; // @[csr.scala 108:27]
  wire [4:0] rs1_addr = io_inst[19:15]; // @[csr.scala 109:27]
  reg [31:0] time_; // @[csr.scala 112:27]
  reg [31:0] timeh; // @[csr.scala 113:27]
  reg [31:0] cycle; // @[csr.scala 114:27]
  reg [31:0] cycleh; // @[csr.scala 115:27]
  reg [31:0] instret; // @[csr.scala 116:27]
  reg [31:0] instreth; // @[csr.scala 117:27]
  reg [1:0] mstatus_prv; // @[csr.scala 131:23]
  reg [1:0] mstatus_mpp; // @[csr.scala 131:23]
  reg  mstatus_mpie; // @[csr.scala 131:23]
  reg  mstatus_mie; // @[csr.scala 131:23]
  reg  mie_motor3ie; // @[csr.scala 132:23]
  reg  mie_motor2ie; // @[csr.scala 132:23]
  reg  mie_motor1ie; // @[csr.scala 132:23]
  reg  mie_spiie; // @[csr.scala 132:23]
  reg  mie_uartie; // @[csr.scala 132:23]
  reg  mie_mtie; // @[csr.scala 132:23]
  reg  mie_msie; // @[csr.scala 132:23]
  reg  mip_motor1ip; // @[csr.scala 134:27]
  reg  mip_motor2ip; // @[csr.scala 134:27]
  reg  mip_motor3ip; // @[csr.scala 134:27]
  reg  mip_spiip; // @[csr.scala 134:27]
  reg  mip_uartip; // @[csr.scala 134:27]
  reg  mip_mtip; // @[csr.scala 134:27]
  reg  mip_msip; // @[csr.scala 134:27]
  reg [31:0] mtvec; // @[csr.scala 138:27]
  reg [31:0] mscratch; // @[csr.scala 141:23]
  reg [31:0] mepc; // @[csr.scala 142:23]
  reg [31:0] mcause; // @[csr.scala 143:23]
  reg [31:0] mtval; // @[csr.scala 144:23]
  wire  _GEN_0 = reset ? 1'h0 : mie_motor3ie; // @[csr.scala 148:3 149:19 132:23]
  wire  _GEN_1 = reset | mie_motor2ie; // @[csr.scala 148:3 150:19 132:23]
  wire  _GEN_2 = reset | mie_motor1ie; // @[csr.scala 148:3 151:19 132:23]
  wire  _GEN_3 = reset ? 1'h0 : mie_spiie; // @[csr.scala 148:3 152:18 132:23]
  wire  _GEN_4 = reset | mie_uartie; // @[csr.scala 148:3 153:18 132:23]
  wire  _GEN_5 = reset | mstatus_mie; // @[csr.scala 148:3 154:18 131:23]
  wire [1:0] _GEN_6 = reset ? 2'h3 : mstatus_prv; // @[csr.scala 148:3 155:18 131:23]
  wire [1:0] _GEN_7 = reset ? 2'h3 : mstatus_mpp; // @[csr.scala 148:3 156:18 131:23]
  wire [8:0] lo = {1'h0,mie_mtie,1'h0,2'h0,mie_msie,1'h0,2'h0}; // @[csr.scala 168:34]
  wire [31:0] _T_1 = {11'h0,mie_motor3ie,mie_motor2ie,mie_motor1ie,mie_spiie,mie_uartie,4'h0,1'h0,2'h0,lo}; // @[csr.scala 168:34]
  wire [8:0] lo_1 = {1'h0,mip_mtip,1'h0,2'h0,mip_msip,1'h0,2'h0}; // @[csr.scala 173:34]
  wire [31:0] _T_2 = {11'h0,mip_motor1ip,mip_motor2ip,mip_motor3ip,mip_spiip,mip_uartip,4'h0,1'h0,2'h0,lo_1}; // @[csr.scala 173:34]
  wire [12:0] lo_2 = {mstatus_mpp,2'h0,1'h0,mstatus_mpie,1'h0,1'h0,1'h0,mstatus_mie,1'h0,2'h0}; // @[csr.scala 174:38]
  wire [31:0] _T_3 = {7'h0,mstatus_prv,3'h0,7'h0,lo_2}; // @[csr.scala 174:38]
  wire  _io_out_T_1 = 12'hc00 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_3 = 12'hc01 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_5 = 12'hc02 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_7 = 12'hc80 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_9 = 12'hc81 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_11 = 12'hc82 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_13 = 12'h305 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_15 = 12'h304 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_17 = 12'h340 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_19 = 12'h341 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_21 = 12'h342 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_23 = 12'h343 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_25 = 12'h344 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_27 = 12'h300 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_29 = 12'h301 == csr_addr; // @[Lookup.scala 31:38]
  wire [31:0] _io_out_T_30 = _io_out_T_29 ? 32'h40000100 : 32'h0; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_31 = _io_out_T_27 ? _T_3 : _io_out_T_30; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_32 = _io_out_T_25 ? _T_2 : _io_out_T_31; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_33 = _io_out_T_23 ? mtval : _io_out_T_32; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_34 = _io_out_T_21 ? mcause : _io_out_T_33; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_35 = _io_out_T_19 ? mepc : _io_out_T_34; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_36 = _io_out_T_17 ? mscratch : _io_out_T_35; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_37 = _io_out_T_15 ? _T_1 : _io_out_T_36; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_38 = _io_out_T_13 ? mtvec : _io_out_T_37; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_39 = _io_out_T_11 ? instreth : _io_out_T_38; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_40 = _io_out_T_9 ? timeh : _io_out_T_39; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_41 = _io_out_T_7 ? cycleh : _io_out_T_40; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_42 = _io_out_T_5 ? instret : _io_out_T_41; // @[Lookup.scala 34:39]
  wire [31:0] _io_out_T_43 = _io_out_T_3 ? time_ : _io_out_T_42; // @[Lookup.scala 34:39]
  wire  privValid = csr_addr[9:8] <= mstatus_prv; // @[csr.scala 182:38]
  wire  privInst = io_cmd == 3'h4; // @[csr.scala 183:30]
  wire  _isEcall_T_2 = privInst & ~csr_addr[0]; // @[csr.scala 184:32]
  wire  _isEcall_T_4 = ~csr_addr[8]; // @[csr.scala 184:51]
  wire  isEcall = privInst & ~csr_addr[0] & ~csr_addr[8]; // @[csr.scala 184:48]
  wire  isEbreak = privInst & csr_addr[0] & _isEcall_T_4; // @[csr.scala 185:48]
  wire  isEret = _isEcall_T_2 & csr_addr[8]; // @[csr.scala 186:48]
  wire  iaddrInvalid = io_pc_check & io_addr[1]; // @[csr.scala 187:35]
  wire  _laddrInvalid_T_1 = |io_addr[1:0]; // @[csr.scala 189:56]
  wire  _laddrInvalid_T_7 = 3'h2 == io_ld_type ? io_addr[0] : 3'h1 == io_ld_type & _laddrInvalid_T_1; // @[Mux.scala 81:58]
  wire  laddrInvalid = 3'h4 == io_ld_type ? io_addr[0] : _laddrInvalid_T_7; // @[Mux.scala 81:58]
  wire  saddrInvalid = 2'h2 == io_st_type ? io_addr[0] : 2'h1 == io_st_type & _laddrInvalid_T_1; // @[Mux.scala 81:58]
  wire  isMotor1 = mip_motor1ip & mie_motor1ie; // @[csr.scala 193:37]
  wire  isMotor2 = mip_motor2ip & mie_motor2ie; // @[csr.scala 194:37]
  wire  isMotor3 = mip_motor3ip & mie_motor3ie; // @[csr.scala 195:37]
  wire  isSpi = mip_spiip & mie_spiie; // @[csr.scala 196:35]
  wire  isUart = mip_uartip & mie_uartie; // @[csr.scala 197:36]
  wire  isTimer = mip_mtip & mie_mtie; // @[csr.scala 198:36]
  wire  isSoftware = mip_msip & mie_msie; // @[csr.scala 200:36]
  wire  csrValid = _io_out_T_1 | _io_out_T_3 | _io_out_T_5 | _io_out_T_7 | _io_out_T_9 | _io_out_T_11 | _io_out_T_13 |
    _io_out_T_15 | _io_out_T_17 | _io_out_T_19 | _io_out_T_21 | _io_out_T_23 | _io_out_T_25 | _io_out_T_27 |
    _io_out_T_29; // @[csr.scala 203:65]
  wire  csrRO = &csr_addr[11:10]; // @[csr.scala 204:40]
  wire  wen = io_cmd == 3'h1 | io_cmd[1] & |rs1_addr; // @[csr.scala 205:40]
  wire [31:0] _wdata_T = io_out | io_in; // @[csr.scala 207:68]
  wire [31:0] _wdata_T_1 = ~io_in; // @[csr.scala 208:70]
  wire [31:0] _wdata_T_2 = io_out & _wdata_T_1; // @[csr.scala 208:68]
  wire [31:0] _wdata_T_4 = 3'h1 == io_cmd ? io_in : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _wdata_T_6 = 3'h2 == io_cmd ? _wdata_T : _wdata_T_4; // @[Mux.scala 81:58]
  wire [31:0] wdata = 3'h3 == io_cmd ? _wdata_T_2 : _wdata_T_6; // @[Mux.scala 81:58]
  wire [29:0] _GEN_175 = {{28'd0}, mstatus_prv}; // @[csr.scala 214:50]
  wire [29:0] _causeExpt_T_1 = 30'h8 + _GEN_175; // @[csr.scala 214:50]
  wire [29:0] _causeExpt_T_2 = isEbreak ? 30'h3 : 30'h2; // @[csr.scala 215:22]
  wire [29:0] _causeExpt_T_3 = isEcall ? _causeExpt_T_1 : _causeExpt_T_2; // @[csr.scala 214:22]
  wire [29:0] _causeExpt_T_4 = saddrInvalid ? 30'h6 : _causeExpt_T_3; // @[csr.scala 213:22]
  wire [29:0] _causeExpt_T_5 = laddrInvalid ? 30'h4 : _causeExpt_T_4; // @[csr.scala 212:22]
  wire [29:0] causeExpt = iaddrInvalid ? 30'h0 : _causeExpt_T_5; // @[csr.scala 211:22]
  wire [29:0] _causeInt_T = isMotor2 ? 30'h13 : 30'h14; // @[csr.scala 223:22]
  wire [29:0] _causeInt_T_1 = isMotor1 ? 30'h12 : _causeInt_T; // @[csr.scala 222:22]
  wire [29:0] _causeInt_T_2 = isSpi ? 30'h11 : _causeInt_T_1; // @[csr.scala 221:22]
  wire [29:0] _causeInt_T_3 = isUart ? 30'h10 : _causeInt_T_2; // @[csr.scala 220:22]
  wire [29:0] _causeInt_T_4 = isTimer ? 30'h7 : _causeInt_T_3; // @[csr.scala 219:22]
  wire [29:0] causeInt = isSoftware ? 30'h3 : _causeInt_T_4; // @[csr.scala 217:22]
  wire  isInt = (isMotor1 | isMotor2 | isMotor3 | isSpi | isUart | isTimer | isSoftware) & mstatus_mie; // @[csr.scala 226:113]
  wire [29:0] cause = isInt ? causeInt : causeExpt; // @[csr.scala 227:23]
  wire [31:0] base = {mtvec[31:2], 2'h0}; // @[csr.scala 230:31]
  wire [1:0] mode = mtvec[1:0]; // @[csr.scala 231:25]
  wire [31:0] _io_evec_T_2 = {cause, 2'h0}; // @[csr.scala 232:57]
  wire [31:0] _io_evec_T_4 = base + _io_evec_T_2; // @[csr.scala 232:48]
  wire  _io_expt_T_6 = ~privValid; // @[csr.scala 236:56]
  wire  _io_expt_T_8 = |io_cmd[1:0] & (~csrValid | ~privValid); // @[csr.scala 236:39]
  wire  _io_expt_T_9 = io_illegal | iaddrInvalid | laddrInvalid | saddrInvalid | _io_expt_T_8; // @[csr.scala 235:81]
  wire  _io_expt_T_13 = privInst & _io_expt_T_6; // @[csr.scala 237:32]
  wire  _io_expt_T_14 = _io_expt_T_9 | wen & csrRO | _io_expt_T_13; // @[csr.scala 236:84]
  wire [31:0] _time_T_1 = time_ + 32'h1; // @[csr.scala 241:26]
  wire [31:0] _timeh_T_1 = timeh + 32'h1; // @[csr.scala 243:27]
  wire [31:0] _cycle_T_1 = cycle + 32'h1; // @[csr.scala 245:27]
  wire [31:0] _cycleh_T_1 = cycleh + 32'h1; // @[csr.scala 247:28]
  wire  _isInstRet_T_5 = ~io_stall; // @[csr.scala 249:89]
  wire  isInstRet = io_inst != 32'h13 & (~io_expt | isEcall | isEbreak) & ~io_stall; // @[csr.scala 249:86]
  wire [31:0] _instret_T_1 = instret + 32'h1; // @[csr.scala 252:29]
  wire [31:0] _instreth_T_1 = instreth + 32'h1; // @[csr.scala 255:30]
  reg  wasEret; // @[csr.scala 259:28]
  reg  br_taken; // @[csr.scala 263:30]
  reg  br_taken_delayed; // @[csr.scala 264:30]
  wire  _T_9 = ~wasEret; // @[csr.scala 273:12]
  wire [31:0] _mepc_T_1 = io_pc - 32'h4; // @[csr.scala 274:54]
  wire [31:0] _mepc_T_2 = br_taken_delayed ? _mepc_T_1 : io_pc; // @[csr.scala 274:29]
  wire [31:0] _mepc_T_4 = {_mepc_T_2[31:2], 2'h0}; // @[csr.scala 274:74]
  wire [31:0] _GEN_12 = _T_9 ? _mepc_T_4 : mepc; // @[csr.scala 274:22 142:23 274:7]
  wire [31:0] _mcause_T_1 = {isInt,1'h0,cause}; // @[Cat.scala 33:92]
  wire [31:0] _mepc_T_5 = {{2'd0}, wdata[31:2]}; // @[csr.scala 315:56]
  wire [33:0] _GEN_177 = {_mepc_T_5, 2'h0}; // @[csr.scala 315:63]
  wire [34:0] _mepc_T_6 = {{1'd0}, _GEN_177}; // @[csr.scala 315:63]
  wire [31:0] _mcause_T_2 = wdata & 32'h8000000f; // @[csr.scala 316:60]
  wire [31:0] _GEN_14 = csr_addr == 12'h343 ? wdata : mtval; // @[csr.scala 144:23 317:{41,49}]
  wire [31:0] _GEN_15 = csr_addr == 12'h342 ? _mcause_T_2 : mcause; // @[csr.scala 143:23 316:{42,51}]
  wire [31:0] _GEN_16 = csr_addr == 12'h342 ? mtval : _GEN_14; // @[csr.scala 144:23 316:42]
  wire [34:0] _GEN_17 = csr_addr == 12'h341 ? _mepc_T_6 : {{3'd0}, mepc}; // @[csr.scala 142:23 315:{40,47}]
  wire [31:0] _GEN_18 = csr_addr == 12'h341 ? mcause : _GEN_15; // @[csr.scala 143:23 315:40]
  wire [31:0] _GEN_19 = csr_addr == 12'h341 ? mtval : _GEN_16; // @[csr.scala 144:23 315:40]
  wire [31:0] _GEN_20 = csr_addr == 12'h340 ? wdata : mscratch; // @[csr.scala 141:23 314:{44,55}]
  wire [34:0] _GEN_21 = csr_addr == 12'h340 ? {{3'd0}, mepc} : _GEN_17; // @[csr.scala 142:23 314:44]
  wire [31:0] _GEN_22 = csr_addr == 12'h340 ? mcause : _GEN_18; // @[csr.scala 143:23 314:44]
  wire [31:0] _GEN_23 = csr_addr == 12'h340 ? mtval : _GEN_19; // @[csr.scala 144:23 314:44]
  wire [31:0] _GEN_24 = csr_addr == 12'h305 ? wdata : mtvec; // @[csr.scala 138:27 313:{41,49}]
  wire [31:0] _GEN_25 = csr_addr == 12'h305 ? mscratch : _GEN_20; // @[csr.scala 141:23 313:41]
  wire [34:0] _GEN_26 = csr_addr == 12'h305 ? {{3'd0}, mepc} : _GEN_21; // @[csr.scala 142:23 313:41]
  wire [31:0] _GEN_27 = csr_addr == 12'h305 ? mcause : _GEN_22; // @[csr.scala 143:23 313:41]
  wire [31:0] _GEN_28 = csr_addr == 12'h305 ? mtval : _GEN_23; // @[csr.scala 144:23 313:41]
  wire  _GEN_29 = csr_addr == 12'h304 ? wdata[20] : _GEN_0; // @[csr.scala 304:39 305:22]
  wire  _GEN_30 = csr_addr == 12'h304 ? wdata[19] : _GEN_1; // @[csr.scala 304:39 306:22]
  wire  _GEN_31 = csr_addr == 12'h304 ? wdata[18] : _GEN_2; // @[csr.scala 304:39 307:22]
  wire  _GEN_32 = csr_addr == 12'h304 ? wdata[17] : _GEN_3; // @[csr.scala 304:39 308:22]
  wire  _GEN_33 = csr_addr == 12'h304 ? wdata[16] : _GEN_4; // @[csr.scala 304:39 309:22]
  wire  _GEN_34 = csr_addr == 12'h304 ? wdata[7] : mie_mtie; // @[csr.scala 304:39 310:22 132:23]
  wire  _GEN_35 = csr_addr == 12'h304 ? wdata[3] : mie_msie; // @[csr.scala 304:39 311:22 132:23]
  wire [31:0] _GEN_36 = csr_addr == 12'h304 ? mtvec : _GEN_24; // @[csr.scala 138:27 304:39]
  wire [31:0] _GEN_37 = csr_addr == 12'h304 ? mscratch : _GEN_25; // @[csr.scala 141:23 304:39]
  wire [34:0] _GEN_38 = csr_addr == 12'h304 ? {{3'd0}, mepc} : _GEN_26; // @[csr.scala 142:23 304:39]
  wire [31:0] _GEN_39 = csr_addr == 12'h304 ? mcause : _GEN_27; // @[csr.scala 143:23 304:39]
  wire [31:0] _GEN_40 = csr_addr == 12'h304 ? mtval : _GEN_28; // @[csr.scala 144:23 304:39]
  wire  _GEN_46 = csr_addr == 12'h344 ? wdata[7] : mip_mtip; // @[csr.scala 295:39 301:22 134:27]
  wire  _GEN_47 = csr_addr == 12'h344 ? wdata[3] : mip_msip; // @[csr.scala 295:39 302:22 134:27]
  wire  _GEN_48 = csr_addr == 12'h344 ? _GEN_0 : _GEN_29; // @[csr.scala 295:39]
  wire  _GEN_49 = csr_addr == 12'h344 ? _GEN_1 : _GEN_30; // @[csr.scala 295:39]
  wire  _GEN_50 = csr_addr == 12'h344 ? _GEN_2 : _GEN_31; // @[csr.scala 295:39]
  wire  _GEN_51 = csr_addr == 12'h344 ? _GEN_3 : _GEN_32; // @[csr.scala 295:39]
  wire  _GEN_52 = csr_addr == 12'h344 ? _GEN_4 : _GEN_33; // @[csr.scala 295:39]
  wire  _GEN_53 = csr_addr == 12'h344 ? mie_mtie : _GEN_34; // @[csr.scala 132:23 295:39]
  wire  _GEN_54 = csr_addr == 12'h344 ? mie_msie : _GEN_35; // @[csr.scala 132:23 295:39]
  wire [31:0] _GEN_55 = csr_addr == 12'h344 ? mtvec : _GEN_36; // @[csr.scala 138:27 295:39]
  wire [31:0] _GEN_56 = csr_addr == 12'h344 ? mscratch : _GEN_37; // @[csr.scala 141:23 295:39]
  wire [34:0] _GEN_57 = csr_addr == 12'h344 ? {{3'd0}, mepc} : _GEN_38; // @[csr.scala 142:23 295:39]
  wire [31:0] _GEN_58 = csr_addr == 12'h344 ? mcause : _GEN_39; // @[csr.scala 143:23 295:39]
  wire [31:0] _GEN_59 = csr_addr == 12'h344 ? mtval : _GEN_40; // @[csr.scala 144:23 295:39]
  wire [1:0] _GEN_60 = csr_addr == 12'h300 ? wdata[12:11] : _GEN_7; // @[csr.scala 289:38 290:22]
  wire  _GEN_61 = csr_addr == 12'h300 ? wdata[7] : mstatus_mpie; // @[csr.scala 289:38 291:22 131:23]
  wire [1:0] _GEN_62 = csr_addr == 12'h300 ? wdata[24:23] : _GEN_6; // @[csr.scala 289:38 292:22]
  wire  _GEN_63 = csr_addr == 12'h300 ? wdata[3] : _GEN_5; // @[csr.scala 289:38 293:22]
  wire  _GEN_69 = csr_addr == 12'h300 ? mip_mtip : _GEN_46; // @[csr.scala 134:27 289:38]
  wire  _GEN_70 = csr_addr == 12'h300 ? mip_msip : _GEN_47; // @[csr.scala 134:27 289:38]
  wire  _GEN_71 = csr_addr == 12'h300 ? _GEN_0 : _GEN_48; // @[csr.scala 289:38]
  wire  _GEN_72 = csr_addr == 12'h300 ? _GEN_1 : _GEN_49; // @[csr.scala 289:38]
  wire  _GEN_73 = csr_addr == 12'h300 ? _GEN_2 : _GEN_50; // @[csr.scala 289:38]
  wire  _GEN_74 = csr_addr == 12'h300 ? _GEN_3 : _GEN_51; // @[csr.scala 289:38]
  wire  _GEN_75 = csr_addr == 12'h300 ? _GEN_4 : _GEN_52; // @[csr.scala 289:38]
  wire  _GEN_76 = csr_addr == 12'h300 ? mie_mtie : _GEN_53; // @[csr.scala 132:23 289:38]
  wire  _GEN_77 = csr_addr == 12'h300 ? mie_msie : _GEN_54; // @[csr.scala 132:23 289:38]
  wire [31:0] _GEN_78 = csr_addr == 12'h300 ? mtvec : _GEN_55; // @[csr.scala 138:27 289:38]
  wire [31:0] _GEN_79 = csr_addr == 12'h300 ? mscratch : _GEN_56; // @[csr.scala 141:23 289:38]
  wire [34:0] _GEN_80 = csr_addr == 12'h300 ? {{3'd0}, mepc} : _GEN_57; // @[csr.scala 142:23 289:38]
  wire [31:0] _GEN_81 = csr_addr == 12'h300 ? mcause : _GEN_58; // @[csr.scala 143:23 289:38]
  wire [31:0] _GEN_82 = csr_addr == 12'h300 ? mtval : _GEN_59; // @[csr.scala 144:23 289:38]
  wire  _GEN_84 = wen ? _GEN_61 : mstatus_mpie; // @[csr.scala 288:21 131:23]
  wire  _GEN_92 = wen ? _GEN_69 : mip_mtip; // @[csr.scala 288:21 134:27]
  wire  _GEN_93 = wen ? _GEN_70 : mip_msip; // @[csr.scala 288:21 134:27]
  wire [31:0] _GEN_101 = wen ? _GEN_78 : mtvec; // @[csr.scala 288:21 138:27]
  wire [34:0] _GEN_103 = wen ? _GEN_80 : {{3'd0}, mepc}; // @[csr.scala 288:21 142:23]
  wire  _GEN_109 = isEret | _GEN_84; // @[csr.scala 283:24 287:22]
  wire [34:0] _GEN_126 = isEret ? {{3'd0}, mepc} : _GEN_103; // @[csr.scala 142:23 283:24]
  wire [34:0] _GEN_129 = io_expt ? {{3'd0}, _GEN_12} : _GEN_126; // @[csr.scala 269:19]
  wire [34:0] _GEN_152 = _isInstRet_T_5 ? _GEN_129 : {{3'd0}, mepc}; // @[csr.scala 268:20 142:23]
  assign io_out = _io_out_T_1 ? cycle : _io_out_T_43; // @[Lookup.scala 34:39]
  assign io_expt = _io_expt_T_14 | isEcall | isEbreak | isInt; // @[csr.scala 237:70]
  assign io_evec = isInt & mode[0] ? _io_evec_T_4 : base; // @[csr.scala 232:24]
  assign io_epc = mepc; // @[csr.scala 238:18]
  always @(posedge clock) begin
    if (reset) begin // @[csr.scala 112:27]
      time_ <= 32'h0; // @[csr.scala 112:27]
    end else begin
      time_ <= _time_T_1; // @[csr.scala 241:18]
    end
    if (reset) begin // @[csr.scala 113:27]
      timeh <= 32'h0; // @[csr.scala 113:27]
    end else if (&time_) begin // @[csr.scala 242:19]
      timeh <= _timeh_T_1; // @[csr.scala 243:18]
    end
    if (reset) begin // @[csr.scala 114:27]
      cycle <= 32'h0; // @[csr.scala 114:27]
    end else begin
      cycle <= _cycle_T_1; // @[csr.scala 245:18]
    end
    if (reset) begin // @[csr.scala 115:27]
      cycleh <= 32'h0; // @[csr.scala 115:27]
    end else if (&cycle) begin // @[csr.scala 246:20]
      cycleh <= _cycleh_T_1; // @[csr.scala 247:18]
    end
    if (reset) begin // @[csr.scala 116:27]
      instret <= 32'h0; // @[csr.scala 116:27]
    end else if (isInstRet) begin // @[csr.scala 251:19]
      instret <= _instret_T_1; // @[csr.scala 252:18]
    end
    if (reset) begin // @[csr.scala 117:27]
      instreth <= 32'h0; // @[csr.scala 117:27]
    end else if (isInstRet & &instret) begin // @[csr.scala 254:35]
      instreth <= _instreth_T_1; // @[csr.scala 255:18]
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        mstatus_prv <= 2'h3; // @[csr.scala 278:22]
      end else if (isEret) begin // @[csr.scala 283:24]
        mstatus_prv <= mstatus_mpp; // @[csr.scala 284:22]
      end else if (wen) begin // @[csr.scala 288:21]
        mstatus_prv <= _GEN_62;
      end else begin
        mstatus_prv <= _GEN_6;
      end
    end else begin
      mstatus_prv <= _GEN_6;
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        mstatus_mpp <= mstatus_prv; // @[csr.scala 280:22]
      end else if (isEret) begin // @[csr.scala 283:24]
        mstatus_mpp <= 2'h3; // @[csr.scala 286:22]
      end else if (wen) begin // @[csr.scala 288:21]
        mstatus_mpp <= _GEN_60;
      end else begin
        mstatus_mpp <= _GEN_7;
      end
    end else begin
      mstatus_mpp <= _GEN_7;
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        mstatus_mpie <= mstatus_mie; // @[csr.scala 281:22]
      end else begin
        mstatus_mpie <= _GEN_109;
      end
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        mstatus_mie <= 1'h0; // @[csr.scala 279:22]
      end else if (isEret) begin // @[csr.scala 283:24]
        mstatus_mie <= mstatus_mpie; // @[csr.scala 285:22]
      end else if (wen) begin // @[csr.scala 288:21]
        mstatus_mie <= _GEN_63;
      end else begin
        mstatus_mie <= _GEN_5;
      end
    end else begin
      mstatus_mie <= _GEN_5;
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        mie_motor3ie <= _GEN_0;
      end else if (isEret) begin // @[csr.scala 283:24]
        mie_motor3ie <= _GEN_0;
      end else if (wen) begin // @[csr.scala 288:21]
        mie_motor3ie <= _GEN_71;
      end else begin
        mie_motor3ie <= _GEN_0;
      end
    end else begin
      mie_motor3ie <= _GEN_0;
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        mie_motor2ie <= _GEN_1;
      end else if (isEret) begin // @[csr.scala 283:24]
        mie_motor2ie <= _GEN_1;
      end else if (wen) begin // @[csr.scala 288:21]
        mie_motor2ie <= _GEN_72;
      end else begin
        mie_motor2ie <= _GEN_1;
      end
    end else begin
      mie_motor2ie <= _GEN_1;
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        mie_motor1ie <= _GEN_2;
      end else if (isEret) begin // @[csr.scala 283:24]
        mie_motor1ie <= _GEN_2;
      end else if (wen) begin // @[csr.scala 288:21]
        mie_motor1ie <= _GEN_73;
      end else begin
        mie_motor1ie <= _GEN_2;
      end
    end else begin
      mie_motor1ie <= _GEN_2;
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        mie_spiie <= _GEN_3;
      end else if (isEret) begin // @[csr.scala 283:24]
        mie_spiie <= _GEN_3;
      end else if (wen) begin // @[csr.scala 288:21]
        mie_spiie <= _GEN_74;
      end else begin
        mie_spiie <= _GEN_3;
      end
    end else begin
      mie_spiie <= _GEN_3;
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        mie_uartie <= _GEN_4;
      end else if (isEret) begin // @[csr.scala 283:24]
        mie_uartie <= _GEN_4;
      end else if (wen) begin // @[csr.scala 288:21]
        mie_uartie <= _GEN_75;
      end else begin
        mie_uartie <= _GEN_4;
      end
    end else begin
      mie_uartie <= _GEN_4;
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (!(io_expt)) begin // @[csr.scala 269:19]
        if (!(isEret)) begin // @[csr.scala 283:24]
          if (wen) begin // @[csr.scala 288:21]
            mie_mtie <= _GEN_76;
          end
        end
      end
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (!(io_expt)) begin // @[csr.scala 269:19]
        if (!(isEret)) begin // @[csr.scala 283:24]
          if (wen) begin // @[csr.scala 288:21]
            mie_msie <= _GEN_77;
          end
        end
      end
    end
    if (reset) begin // @[csr.scala 134:27]
      mip_motor1ip <= 1'h0; // @[csr.scala 134:27]
    end else if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      mip_motor1ip <= io_irq_m1_irq; // @[csr.scala 322:21]
    end
    if (reset) begin // @[csr.scala 134:27]
      mip_motor2ip <= 1'h0; // @[csr.scala 134:27]
    end else if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      mip_motor2ip <= io_irq_m2_irq; // @[csr.scala 323:21]
    end
    if (reset) begin // @[csr.scala 134:27]
      mip_motor3ip <= 1'h0; // @[csr.scala 134:27]
    end else if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      mip_motor3ip <= io_irq_m3_irq; // @[csr.scala 324:21]
    end
    if (reset) begin // @[csr.scala 134:27]
      mip_spiip <= 1'h0; // @[csr.scala 134:27]
    end else if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      mip_spiip <= io_irq_spi_irq; // @[csr.scala 321:21]
    end
    if (reset) begin // @[csr.scala 134:27]
      mip_uartip <= 1'h0; // @[csr.scala 134:27]
    end else if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      mip_uartip <= io_irq_uart_irq; // @[csr.scala 320:21]
    end
    if (reset) begin // @[csr.scala 134:27]
      mip_mtip <= 1'h0; // @[csr.scala 134:27]
    end else if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (!(io_expt)) begin // @[csr.scala 269:19]
        if (!(isEret)) begin // @[csr.scala 283:24]
          mip_mtip <= _GEN_92;
        end
      end
    end
    if (reset) begin // @[csr.scala 134:27]
      mip_msip <= 1'h0; // @[csr.scala 134:27]
    end else if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (!(io_expt)) begin // @[csr.scala 269:19]
        if (!(isEret)) begin // @[csr.scala 283:24]
          mip_msip <= _GEN_93;
        end
      end
    end
    if (reset) begin // @[csr.scala 138:27]
      mtvec <= 32'h9; // @[csr.scala 138:27]
    end else if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (!(io_expt)) begin // @[csr.scala 269:19]
        if (!(isEret)) begin // @[csr.scala 283:24]
          mtvec <= _GEN_101;
        end
      end
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (!(io_expt)) begin // @[csr.scala 269:19]
        if (!(isEret)) begin // @[csr.scala 283:24]
          if (wen) begin // @[csr.scala 288:21]
            mscratch <= _GEN_79;
          end
        end
      end
    end
    mepc <= _GEN_152[31:0];
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        mcause <= _mcause_T_1; // @[csr.scala 277:22]
      end else if (!(isEret)) begin // @[csr.scala 283:24]
        if (wen) begin // @[csr.scala 288:21]
          mcause <= _GEN_81;
        end
      end
    end
    if (_isInstRet_T_5) begin // @[csr.scala 268:20]
      if (io_expt) begin // @[csr.scala 269:19]
        if (iaddrInvalid | laddrInvalid | saddrInvalid) begin // @[csr.scala 282:58]
          mtval <= io_addr; // @[csr.scala 282:66]
        end
      end else if (!(isEret)) begin // @[csr.scala 283:24]
        if (wen) begin // @[csr.scala 288:21]
          mtval <= _GEN_82;
        end
      end
    end
    if (reset) begin // @[csr.scala 259:28]
      wasEret <= 1'h0; // @[csr.scala 259:28]
    end else begin
      wasEret <= isEret; // @[csr.scala 260:19]
    end
    br_taken <= io_br_taken; // @[csr.scala 265:24]
    br_taken_delayed <= br_taken; // @[csr.scala 266:24]
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  time_ = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  timeh = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  cycle = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  cycleh = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  instret = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  instreth = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  mstatus_prv = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  mstatus_mpp = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  mstatus_mpie = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  mstatus_mie = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  mie_motor3ie = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mie_motor2ie = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  mie_motor1ie = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  mie_spiie = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  mie_uartie = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  mie_mtie = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  mie_msie = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  mip_motor1ip = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  mip_motor2ip = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  mip_motor3ip = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  mip_spiip = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  mip_uartip = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  mip_mtip = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  mip_msip = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  mtvec = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  mscratch = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  mepc = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  mcause = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  mtval = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  wasEret = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  br_taken = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  br_taken_delayed = _RAND_31[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegFile(
  input         clock,
  input  [4:0]  io_raddr_1,
  input  [4:0]  io_raddr_2,
  output [31:0] io_rdata_1,
  output [31:0] io_rdata_2,
  input         io_wen,
  input  [4:0]  io_waddr,
  input  [31:0] io_wdata
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regs [0:31]; // @[reg_file.scala 31:17]
  wire  regs_io_rdata_1_MPORT_en; // @[reg_file.scala 31:17]
  wire [4:0] regs_io_rdata_1_MPORT_addr; // @[reg_file.scala 31:17]
  wire [31:0] regs_io_rdata_1_MPORT_data; // @[reg_file.scala 31:17]
  wire  regs_io_rdata_2_MPORT_en; // @[reg_file.scala 31:17]
  wire [4:0] regs_io_rdata_2_MPORT_addr; // @[reg_file.scala 31:17]
  wire [31:0] regs_io_rdata_2_MPORT_data; // @[reg_file.scala 31:17]
  wire [31:0] regs_MPORT_data; // @[reg_file.scala 31:17]
  wire [4:0] regs_MPORT_addr; // @[reg_file.scala 31:17]
  wire  regs_MPORT_mask; // @[reg_file.scala 31:17]
  wire  regs_MPORT_en; // @[reg_file.scala 31:17]
  wire  _T = |io_waddr; // @[reg_file.scala 42:26]
  assign regs_io_rdata_1_MPORT_en = 1'h1;
  assign regs_io_rdata_1_MPORT_addr = io_raddr_1;
  assign regs_io_rdata_1_MPORT_data = regs[regs_io_rdata_1_MPORT_addr]; // @[reg_file.scala 31:17]
  assign regs_io_rdata_2_MPORT_en = 1'h1;
  assign regs_io_rdata_2_MPORT_addr = io_raddr_2;
  assign regs_io_rdata_2_MPORT_data = regs[regs_io_rdata_2_MPORT_addr]; // @[reg_file.scala 31:17]
  assign regs_MPORT_data = io_wdata;
  assign regs_MPORT_addr = io_waddr;
  assign regs_MPORT_mask = 1'h1;
  assign regs_MPORT_en = io_wen & _T;
  assign io_rdata_1 = |io_raddr_1 ? regs_io_rdata_1_MPORT_data : 32'h0; // @[reg_file.scala 39:20]
  assign io_rdata_2 = |io_raddr_2 ? regs_io_rdata_2_MPORT_data : 32'h0; // @[reg_file.scala 40:20]
  always @(posedge clock) begin
    if (regs_MPORT_en & regs_MPORT_mask) begin
      regs[regs_MPORT_addr] <= regs_MPORT_data; // @[reg_file.scala 31:17]
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regs[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ALU(
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  input  [3:0]  io_alu_op,
  output [31:0] io_out,
  output [31:0] io_sum
);
  wire [31:0] _sum_T_2 = 32'h0 - io_in_b; // @[alu.scala 45:44]
  wire [31:0] _sum_T_3 = io_alu_op[0] ? _sum_T_2 : io_in_b; // @[alu.scala 45:29]
  wire [31:0] sum = io_in_a + _sum_T_3; // @[alu.scala 45:24]
  wire  _cmp_T_7 = io_alu_op[1] ? io_in_b[31] : io_in_a[31]; // @[alu.scala 47:23]
  wire  cmp = io_in_a[31] == io_in_b[31] ? sum[31] : _cmp_T_7; // @[alu.scala 46:19]
  wire [4:0] shamt = io_in_b[4:0]; // @[alu.scala 48:23]
  wire [31:0] _GEN_0 = {{16'd0}, io_in_a[31:16]}; // @[Bitwise.scala 108:31]
  wire [31:0] _shin_T_4 = _GEN_0 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _shin_T_6 = {io_in_a[15:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _shin_T_8 = _shin_T_6 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _shin_T_9 = _shin_T_4 | _shin_T_8; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_1 = {{8'd0}, _shin_T_9[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _shin_T_14 = _GEN_1 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _shin_T_16 = {_shin_T_9[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _shin_T_18 = _shin_T_16 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _shin_T_19 = _shin_T_14 | _shin_T_18; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_2 = {{4'd0}, _shin_T_19[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _shin_T_24 = _GEN_2 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _shin_T_26 = {_shin_T_19[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _shin_T_28 = _shin_T_26 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _shin_T_29 = _shin_T_24 | _shin_T_28; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_3 = {{2'd0}, _shin_T_29[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _shin_T_34 = _GEN_3 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _shin_T_36 = {_shin_T_29[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _shin_T_38 = _shin_T_36 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _shin_T_39 = _shin_T_34 | _shin_T_38; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_4 = {{1'd0}, _shin_T_39[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _shin_T_44 = _GEN_4 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _shin_T_46 = {_shin_T_39[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _shin_T_48 = _shin_T_46 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] _shin_T_49 = _shin_T_44 | _shin_T_48; // @[Bitwise.scala 108:39]
  wire [31:0] shin = io_alu_op[3] ? io_in_a : _shin_T_49; // @[alu.scala 49:19]
  wire  _shiftr_T_2 = io_alu_op[0] & shin[31]; // @[alu.scala 50:34]
  wire [32:0] _shiftr_T_4 = {_shiftr_T_2,shin}; // @[alu.scala 50:57]
  wire [32:0] _shiftr_T_5 = $signed(_shiftr_T_4) >>> shamt; // @[alu.scala 50:64]
  wire [31:0] shiftr = _shiftr_T_5[31:0]; // @[alu.scala 50:73]
  wire [31:0] _GEN_5 = {{16'd0}, shiftr[31:16]}; // @[Bitwise.scala 108:31]
  wire [31:0] _shiftl_T_3 = _GEN_5 & 32'hffff; // @[Bitwise.scala 108:31]
  wire [31:0] _shiftl_T_5 = {shiftr[15:0], 16'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _shiftl_T_7 = _shiftl_T_5 & 32'hffff0000; // @[Bitwise.scala 108:80]
  wire [31:0] _shiftl_T_8 = _shiftl_T_3 | _shiftl_T_7; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_6 = {{8'd0}, _shiftl_T_8[31:8]}; // @[Bitwise.scala 108:31]
  wire [31:0] _shiftl_T_13 = _GEN_6 & 32'hff00ff; // @[Bitwise.scala 108:31]
  wire [31:0] _shiftl_T_15 = {_shiftl_T_8[23:0], 8'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _shiftl_T_17 = _shiftl_T_15 & 32'hff00ff00; // @[Bitwise.scala 108:80]
  wire [31:0] _shiftl_T_18 = _shiftl_T_13 | _shiftl_T_17; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_7 = {{4'd0}, _shiftl_T_18[31:4]}; // @[Bitwise.scala 108:31]
  wire [31:0] _shiftl_T_23 = _GEN_7 & 32'hf0f0f0f; // @[Bitwise.scala 108:31]
  wire [31:0] _shiftl_T_25 = {_shiftl_T_18[27:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _shiftl_T_27 = _shiftl_T_25 & 32'hf0f0f0f0; // @[Bitwise.scala 108:80]
  wire [31:0] _shiftl_T_28 = _shiftl_T_23 | _shiftl_T_27; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_8 = {{2'd0}, _shiftl_T_28[31:2]}; // @[Bitwise.scala 108:31]
  wire [31:0] _shiftl_T_33 = _GEN_8 & 32'h33333333; // @[Bitwise.scala 108:31]
  wire [31:0] _shiftl_T_35 = {_shiftl_T_28[29:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _shiftl_T_37 = _shiftl_T_35 & 32'hcccccccc; // @[Bitwise.scala 108:80]
  wire [31:0] _shiftl_T_38 = _shiftl_T_33 | _shiftl_T_37; // @[Bitwise.scala 108:39]
  wire [31:0] _GEN_9 = {{1'd0}, _shiftl_T_38[31:1]}; // @[Bitwise.scala 108:31]
  wire [31:0] _shiftl_T_43 = _GEN_9 & 32'h55555555; // @[Bitwise.scala 108:31]
  wire [31:0] _shiftl_T_45 = {_shiftl_T_38[30:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [31:0] _shiftl_T_47 = _shiftl_T_45 & 32'haaaaaaaa; // @[Bitwise.scala 108:80]
  wire [31:0] shiftl = _shiftl_T_43 | _shiftl_T_47; // @[Bitwise.scala 108:39]
  wire [31:0] _out_T_11 = io_in_a & io_in_b; // @[alu.scala 58:41]
  wire [31:0] _out_T_13 = io_in_a | io_in_b; // @[alu.scala 59:41]
  wire [31:0] _out_T_15 = io_in_a ^ io_in_b; // @[alu.scala 60:41]
  wire [31:0] _out_T_17 = io_alu_op == 4'ha ? io_in_a : io_in_b; // @[alu.scala 61:8]
  wire [31:0] _out_T_18 = io_alu_op == 4'h4 ? _out_T_15 : _out_T_17; // @[alu.scala 60:8]
  wire [31:0] _out_T_19 = io_alu_op == 4'h3 ? _out_T_13 : _out_T_18; // @[alu.scala 59:8]
  wire [31:0] _out_T_20 = io_alu_op == 4'h2 ? _out_T_11 : _out_T_19; // @[alu.scala 58:8]
  wire [31:0] _out_T_21 = io_alu_op == 4'h6 ? shiftl : _out_T_20; // @[alu.scala 57:8]
  wire [31:0] _out_T_22 = io_alu_op == 4'h9 | io_alu_op == 4'h8 ? shiftr : _out_T_21; // @[alu.scala 56:8]
  wire [31:0] _out_T_23 = io_alu_op == 4'h5 | io_alu_op == 4'h7 ? {{31'd0}, cmp} : _out_T_22; // @[alu.scala 55:8]
  assign io_out = io_alu_op == 4'h0 | io_alu_op == 4'h1 ? sum : _out_T_23; // @[alu.scala 54:8]
  assign io_sum = io_in_a + _sum_T_3; // @[alu.scala 45:24]
endmodule
module Imm(
  input  [31:0] io_inst,
  input  [2:0]  io_imm_sel,
  output [31:0] io_imm_out
);
  wire  _sign_val_T = io_imm_sel == 3'h6; // @[imm_gen.scala 25:33]
  wire  _sign_val_T_2 = io_inst[31]; // @[imm_gen.scala 25:61]
  wire  sign_val = io_imm_sel == 3'h6 ? $signed(1'sh0) : $signed(_sign_val_T_2); // @[imm_gen.scala 25:21]
  wire  _imm30_20_T = io_imm_sel == 3'h3; // @[imm_gen.scala 26:33]
  wire [10:0] _imm30_20_T_2 = io_inst[30:20]; // @[imm_gen.scala 26:59]
  wire [7:0] _imm19_12_T_4 = io_inst[19:12]; // @[imm_gen.scala 27:93]
  wire  _imm11_T_2 = _imm30_20_T | _sign_val_T; // @[imm_gen.scala 28:43]
  wire  _imm11_T_5 = io_inst[20]; // @[imm_gen.scala 29:58]
  wire  _imm11_T_6 = io_imm_sel == 3'h5; // @[imm_gen.scala 30:37]
  wire  _imm11_T_8 = io_inst[7]; // @[imm_gen.scala 30:59]
  wire  _imm11_T_9 = io_imm_sel == 3'h5 ? $signed(_imm11_T_8) : $signed(sign_val); // @[imm_gen.scala 30:25]
  wire  _imm11_T_10 = io_imm_sel == 3'h4 ? $signed(_imm11_T_5) : $signed(_imm11_T_9); // @[imm_gen.scala 29:23]
  wire [5:0] imm10_5 = _imm11_T_2 ? 6'h0 : io_inst[30:25]; // @[imm_gen.scala 31:21]
  wire  _imm4_1_T_1 = io_imm_sel == 3'h2; // @[imm_gen.scala 33:35]
  wire [3:0] _imm4_1_T_8 = _sign_val_T ? io_inst[19:16] : io_inst[24:21]; // @[imm_gen.scala 34:25]
  wire [3:0] _imm4_1_T_9 = io_imm_sel == 3'h2 | _imm11_T_6 ? io_inst[11:8] : _imm4_1_T_8; // @[imm_gen.scala 33:23]
  wire [3:0] imm4_1 = _imm30_20_T ? 4'h0 : _imm4_1_T_9; // @[imm_gen.scala 32:21]
  wire  _imm0_T_6 = _sign_val_T & io_inst[15]; // @[imm_gen.scala 37:24]
  wire  _imm0_T_7 = io_imm_sel == 3'h1 ? io_inst[20] : _imm0_T_6; // @[imm_gen.scala 36:23]
  wire  imm0 = _imm4_1_T_1 ? io_inst[7] : _imm0_T_7; // @[imm_gen.scala 35:21]
  wire  io_imm_out_hi_lo_lo = _imm30_20_T | _sign_val_T ? $signed(1'sh0) : $signed(_imm11_T_10); // @[Cat.scala 33:92]
  wire [7:0] io_imm_out_hi_lo_hi = io_imm_sel != 3'h3 & io_imm_sel != 3'h4 ? $signed({8{sign_val}}) : $signed(
    _imm19_12_T_4); // @[Cat.scala 33:92]
  wire [10:0] io_imm_out_hi_hi_lo = io_imm_sel == 3'h3 ? $signed(_imm30_20_T_2) : $signed({11{sign_val}}); // @[Cat.scala 33:92]
  wire  io_imm_out_hi_hi_hi = io_imm_sel == 3'h6 ? $signed(1'sh0) : $signed(_sign_val_T_2); // @[Cat.scala 33:92]
  assign io_imm_out = {io_imm_out_hi_hi_hi,io_imm_out_hi_hi_lo,io_imm_out_hi_lo_hi,io_imm_out_hi_lo_lo,imm10_5,imm4_1,
    imm0}; // @[imm_gen.scala 39:88]
endmodule
module Branch(
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  input  [2:0]  io_br_type,
  output        io_br_taken
);
  wire [31:0] difference = io_in_a - io_in_b; // @[branch.scala 24:33]
  wire  not_equal = |difference; // @[branch.scala 25:36]
  wire  equal = ~not_equal; // @[branch.scala 26:25]
  wire  is_same_sign = io_in_a[31] == io_in_b[31]; // @[branch.scala 27:41]
  wire  less_than = is_same_sign ? difference[31] : io_in_a[31]; // @[branch.scala 28:28]
  wire  less_than_u = is_same_sign ? difference[31] : io_in_b[31]; // @[branch.scala 29:28]
  wire  greater_equal = ~less_than; // @[branch.scala 30:25]
  wire  greater_equal_u = ~less_than_u; // @[branch.scala 31:25]
  wire  _io_br_taken_T_3 = io_br_type == 3'h6 & not_equal; // @[branch.scala 36:30]
  wire  _io_br_taken_T_4 = io_br_type == 3'h3 & equal | _io_br_taken_T_3; // @[branch.scala 35:40]
  wire  _io_br_taken_T_6 = io_br_type == 3'h2 & less_than; // @[branch.scala 37:30]
  wire  _io_br_taken_T_7 = _io_br_taken_T_4 | _io_br_taken_T_6; // @[branch.scala 36:44]
  wire  _io_br_taken_T_9 = io_br_type == 3'h5 & greater_equal; // @[branch.scala 38:30]
  wire  _io_br_taken_T_10 = _io_br_taken_T_7 | _io_br_taken_T_9; // @[branch.scala 37:44]
  wire  _io_br_taken_T_12 = io_br_type == 3'h1 & less_than_u; // @[branch.scala 39:30]
  wire  _io_br_taken_T_13 = _io_br_taken_T_10 | _io_br_taken_T_12; // @[branch.scala 38:48]
  wire  _io_br_taken_T_15 = io_br_type == 3'h4 & greater_equal_u; // @[branch.scala 40:30]
  assign io_br_taken = _io_br_taken_T_13 | _io_br_taken_T_15; // @[branch.scala 39:46]
endmodule
module LS_Unit(
  input  [1:0]  io_lsu_st_type,
  input  [31:0] io_lsu_wdata_in,
  output [31:0] io_lsu_wdata_out,
  input  [31:0] io_lsu_rdata_in,
  output [31:0] io_lsu_rdata_out,
  input  [2:0]  io_lsu_ld_type
);
  wire [31:0] _io_lsu_wdata_out_T_3 = 2'h1 == io_lsu_st_type ? io_lsu_wdata_in : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_lsu_wdata_out_T_5 = 2'h2 == io_lsu_st_type ? {{16'd0}, io_lsu_wdata_in[15:0]} : _io_lsu_wdata_out_T_3; // @[Mux.scala 81:58]
  wire [32:0] _io_lsu_rdata_out_T = {1'b0,$signed(io_lsu_rdata_in)}; // @[ls_unit.scala 40:29]
  wire [15:0] _io_lsu_rdata_out_T_2 = io_lsu_rdata_in[15:0]; // @[ls_unit.scala 41:36]
  wire [7:0] _io_lsu_rdata_out_T_4 = io_lsu_rdata_in[7:0]; // @[ls_unit.scala 42:35]
  wire [16:0] _io_lsu_rdata_out_T_6 = {1'b0,$signed(io_lsu_rdata_in[15:0])}; // @[ls_unit.scala 43:36]
  wire [8:0] _io_lsu_rdata_out_T_8 = {1'b0,$signed(io_lsu_rdata_in[7:0])}; // @[ls_unit.scala 44:35]
  wire [32:0] _io_lsu_rdata_out_T_10 = 3'h1 == io_lsu_ld_type ? $signed(_io_lsu_rdata_out_T) : $signed(33'sh0); // @[Mux.scala 81:58]
  wire [32:0] _io_lsu_rdata_out_T_12 = 3'h2 == io_lsu_ld_type ? $signed({{17{_io_lsu_rdata_out_T_2[15]}},
    _io_lsu_rdata_out_T_2}) : $signed(_io_lsu_rdata_out_T_10); // @[Mux.scala 81:58]
  wire [32:0] _io_lsu_rdata_out_T_14 = 3'h3 == io_lsu_ld_type ? $signed({{25{_io_lsu_rdata_out_T_4[7]}},
    _io_lsu_rdata_out_T_4}) : $signed(_io_lsu_rdata_out_T_12); // @[Mux.scala 81:58]
  wire [32:0] _io_lsu_rdata_out_T_16 = 3'h4 == io_lsu_ld_type ? $signed({{16{_io_lsu_rdata_out_T_6[16]}},
    _io_lsu_rdata_out_T_6}) : $signed(_io_lsu_rdata_out_T_14); // @[Mux.scala 81:58]
  wire [32:0] _io_lsu_rdata_out_T_18 = 3'h5 == io_lsu_ld_type ? $signed({{24{_io_lsu_rdata_out_T_8[8]}},
    _io_lsu_rdata_out_T_8}) : $signed(_io_lsu_rdata_out_T_16); // @[Mux.scala 81:58]
  assign io_lsu_wdata_out = 2'h3 == io_lsu_st_type ? {{24'd0}, io_lsu_wdata_in[7:0]} : _io_lsu_wdata_out_T_5; // @[Mux.scala 81:58]
  assign io_lsu_rdata_out = _io_lsu_rdata_out_T_18[31:0]; // @[ls_unit.scala 39:21]
endmodule
module Datapath(
  input         clock,
  input         reset,
  input         io_irq_uart_irq,
  input         io_irq_spi_irq,
  input         io_irq_m1_irq,
  input         io_irq_m2_irq,
  input         io_irq_m3_irq,
  output [31:0] io_ibus_addr,
  input  [31:0] io_ibus_inst,
  input         io_ibus_valid,
  output [31:0] io_dbus_addr,
  output [31:0] io_dbus_wdata,
  input  [31:0] io_dbus_rdata,
  output        io_dbus_rd_en,
  output        io_dbus_wr_en,
  output [1:0]  io_dbus_st_type,
  output [2:0]  io_dbus_ld_type,
  input         io_dbus_valid,
  output [31:0] io_ctrl_inst,
  input  [1:0]  io_ctrl_pc_sel,
  input         io_ctrl_inst_kill,
  input         io_ctrl_a_sel,
  input         io_ctrl_b_sel,
  input  [2:0]  io_ctrl_imm_sel,
  input  [4:0]  io_ctrl_alu_op,
  input  [2:0]  io_ctrl_br_type,
  input  [1:0]  io_ctrl_st_type,
  input  [2:0]  io_ctrl_ld_type,
  input  [1:0]  io_ctrl_wb_mux_sel,
  input         io_ctrl_wb_en,
  input  [2:0]  io_ctrl_csr_cmd,
  input         io_ctrl_illegal,
  input         io_ctrl_en_rs1,
  input         io_ctrl_en_rs2
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire  csr_clock; // @[pipeline.scala 34:26]
  wire  csr_reset; // @[pipeline.scala 34:26]
  wire  csr_io_stall; // @[pipeline.scala 34:26]
  wire [2:0] csr_io_cmd; // @[pipeline.scala 34:26]
  wire [31:0] csr_io_in; // @[pipeline.scala 34:26]
  wire [31:0] csr_io_out; // @[pipeline.scala 34:26]
  wire [31:0] csr_io_pc; // @[pipeline.scala 34:26]
  wire [31:0] csr_io_addr; // @[pipeline.scala 34:26]
  wire [31:0] csr_io_inst; // @[pipeline.scala 34:26]
  wire  csr_io_illegal; // @[pipeline.scala 34:26]
  wire [1:0] csr_io_st_type; // @[pipeline.scala 34:26]
  wire [2:0] csr_io_ld_type; // @[pipeline.scala 34:26]
  wire  csr_io_pc_check; // @[pipeline.scala 34:26]
  wire  csr_io_expt; // @[pipeline.scala 34:26]
  wire [31:0] csr_io_evec; // @[pipeline.scala 34:26]
  wire [31:0] csr_io_epc; // @[pipeline.scala 34:26]
  wire  csr_io_irq_uart_irq; // @[pipeline.scala 34:26]
  wire  csr_io_irq_spi_irq; // @[pipeline.scala 34:26]
  wire  csr_io_irq_m1_irq; // @[pipeline.scala 34:26]
  wire  csr_io_irq_m2_irq; // @[pipeline.scala 34:26]
  wire  csr_io_irq_m3_irq; // @[pipeline.scala 34:26]
  wire  csr_io_br_taken; // @[pipeline.scala 34:26]
  wire  reg_file_clock; // @[pipeline.scala 35:26]
  wire [4:0] reg_file_io_raddr_1; // @[pipeline.scala 35:26]
  wire [4:0] reg_file_io_raddr_2; // @[pipeline.scala 35:26]
  wire [31:0] reg_file_io_rdata_1; // @[pipeline.scala 35:26]
  wire [31:0] reg_file_io_rdata_2; // @[pipeline.scala 35:26]
  wire  reg_file_io_wen; // @[pipeline.scala 35:26]
  wire [4:0] reg_file_io_waddr; // @[pipeline.scala 35:26]
  wire [31:0] reg_file_io_wdata; // @[pipeline.scala 35:26]
  wire [31:0] alu_io_in_a; // @[pipeline.scala 36:26]
  wire [31:0] alu_io_in_b; // @[pipeline.scala 36:26]
  wire [3:0] alu_io_alu_op; // @[pipeline.scala 36:26]
  wire [31:0] alu_io_out; // @[pipeline.scala 36:26]
  wire [31:0] alu_io_sum; // @[pipeline.scala 36:26]
  wire [31:0] gen_imm_io_inst; // @[pipeline.scala 37:26]
  wire [2:0] gen_imm_io_imm_sel; // @[pipeline.scala 37:26]
  wire [31:0] gen_imm_io_imm_out; // @[pipeline.scala 37:26]
  wire [31:0] cond_br_io_in_a; // @[pipeline.scala 38:26]
  wire [31:0] cond_br_io_in_b; // @[pipeline.scala 38:26]
  wire [2:0] cond_br_io_br_type; // @[pipeline.scala 38:26]
  wire  cond_br_io_br_taken; // @[pipeline.scala 38:26]
  wire [1:0] lsu_io_lsu_st_type; // @[pipeline.scala 137:19]
  wire [31:0] lsu_io_lsu_wdata_in; // @[pipeline.scala 137:19]
  wire [31:0] lsu_io_lsu_wdata_out; // @[pipeline.scala 137:19]
  wire [31:0] lsu_io_lsu_rdata_in; // @[pipeline.scala 137:19]
  wire [31:0] lsu_io_lsu_rdata_out; // @[pipeline.scala 137:19]
  wire [2:0] lsu_io_lsu_ld_type; // @[pipeline.scala 137:19]
  reg [31:0] fet_exe_inst; // @[pipeline.scala 42:30]
  reg [31:0] fet_exe_pc; // @[pipeline.scala 43:26]
  reg [31:0] exe_wb_inst; // @[pipeline.scala 46:33]
  reg [31:0] exe_wb_pc; // @[pipeline.scala 47:29]
  reg [31:0] exe_wb_alu; // @[pipeline.scala 48:29]
  reg [31:0] csr_in; // @[pipeline.scala 49:29]
  reg [1:0] ctrl_st_type; // @[pipeline.scala 52:29]
  reg [2:0] ctrl_ld_type; // @[pipeline.scala 53:29]
  reg [1:0] ctrl_wb_mux_sel; // @[pipeline.scala 54:29]
  reg  ctrl_wb_en; // @[pipeline.scala 55:29]
  reg [2:0] ctrl_csr_cmd; // @[pipeline.scala 56:29]
  reg  ctrl_illegal; // @[pipeline.scala 57:29]
  reg  ctrl_pc_check; // @[pipeline.scala 58:29]
  reg  notstarted; // @[pipeline.scala 61:27]
  wire [31:0] _pc_T_1 = 32'h0 - 32'h4; // @[pipeline.scala 64:57]
  reg [31:0] pc; // @[pipeline.scala 64:27]
  wire  _npc_T = ~io_ibus_valid; // @[pipeline.scala 66:33]
  wire  _hazard_stall_T = |ctrl_ld_type; // @[pipeline.scala 113:39]
  wire [4:0] rs1_addr = fet_exe_inst[19:15]; // @[pipeline.scala 91:37]
  wire [4:0] wrbk_rd_addr = exe_wb_inst[11:7]; // @[pipeline.scala 102:35]
  wire  rs1hazard = ctrl_wb_en & |rs1_addr & rs1_addr == wrbk_rd_addr; // @[pipeline.scala 103:51]
  wire [4:0] rs2_addr = fet_exe_inst[24:20]; // @[pipeline.scala 92:37]
  wire  rs2hazard = ctrl_wb_en & |rs2_addr & rs2_addr == wrbk_rd_addr; // @[pipeline.scala 104:51]
  wire  hazard_stall = (|ctrl_ld_type | ctrl_csr_cmd != 3'h0) & (io_ctrl_en_rs1 & rs1hazard | io_ctrl_en_rs2 & rs2hazard
    ); // @[pipeline.scala 113:70]
  wire  is_load_store = _hazard_stall_T | |ctrl_st_type; // @[pipeline.scala 117:41]
  wire  dmem_stall = ~(io_dbus_valid & is_load_store | ~is_load_store); // @[pipeline.scala 119:25]
  wire  stall = hazard_stall | dmem_stall; // @[pipeline.scala 120:38]
  wire  _npc_T_3 = io_ctrl_pc_sel == 2'h1; // @[pipeline.scala 68:39]
  wire [31:0] _npc_T_5 = {{1'd0}, alu_io_sum[31:1]}; // @[pipeline.scala 68:85]
  wire [32:0] _npc_T_6 = {_npc_T_5, 1'h0}; // @[pipeline.scala 68:92]
  wire [31:0] _npc_T_9 = pc + 32'h4; // @[pipeline.scala 69:56]
  wire [31:0] _npc_T_10 = io_ctrl_pc_sel == 2'h2 ? pc : _npc_T_9; // @[pipeline.scala 69:23]
  wire [32:0] _npc_T_11 = io_ctrl_pc_sel == 2'h1 | cond_br_io_br_taken ? _npc_T_6 : {{1'd0}, _npc_T_10}; // @[pipeline.scala 68:23]
  wire [32:0] _npc_T_12 = io_ctrl_pc_sel == 2'h3 ? {{1'd0}, csr_io_epc} : _npc_T_11; // @[pipeline.scala 67:23]
  wire [32:0] _npc_T_13 = csr_io_expt ? {{1'd0}, csr_io_evec} : _npc_T_12; // @[pipeline.scala 66:57]
  wire [32:0] _npc_T_14 = stall | ~io_ibus_valid ? {{1'd0}, pc} : _npc_T_13; // @[pipeline.scala 66:23]
  wire  _T = ~stall; // @[pipeline.scala 80:9]
  wire  _rs1_T = ctrl_wb_mux_sel == 2'h0; // @[pipeline.scala 107:44]
  wire [31:0] rs1 = ctrl_wb_mux_sel == 2'h0 & rs1hazard ? exe_wb_alu : reg_file_io_rdata_1; // @[pipeline.scala 107:27]
  wire [31:0] rs2 = _rs1_T & rs2hazard ? exe_wb_alu : reg_file_io_rdata_2; // @[pipeline.scala 108:27]
  wire  _T_6 = ~csr_io_expt; // @[pipeline.scala 164:24]
  wire [32:0] _reg_file_wdata_T = {1'b0,$signed(exe_wb_alu)}; // @[pipeline.scala 208:62]
  wire [31:0] _reg_file_wdata_T_2 = exe_wb_pc + 32'h4; // @[pipeline.scala 210:54]
  wire [32:0] _reg_file_wdata_T_3 = {1'b0,$signed(_reg_file_wdata_T_2)}; // @[pipeline.scala 210:61]
  wire [32:0] _reg_file_wdata_T_4 = {1'b0,$signed(csr_io_out)}; // @[pipeline.scala 211:54]
  wire [32:0] _reg_file_wdata_T_6 = 2'h1 == ctrl_wb_mux_sel ? $signed({{1{lsu_io_lsu_rdata_out[31]}},
    lsu_io_lsu_rdata_out}) : $signed(_reg_file_wdata_T); // @[Mux.scala 81:58]
  wire [32:0] _reg_file_wdata_T_8 = 2'h2 == ctrl_wb_mux_sel ? $signed(_reg_file_wdata_T_3) : $signed(_reg_file_wdata_T_6
    ); // @[Mux.scala 81:58]
  wire [32:0] reg_file_wdata = 2'h3 == ctrl_wb_mux_sel ? $signed(_reg_file_wdata_T_4) : $signed(_reg_file_wdata_T_8); // @[pipeline.scala 211:62]
  wire [31:0] npc = _npc_T_14[31:0];
  CSR csr ( // @[pipeline.scala 34:26]
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
  RegFile reg_file ( // @[pipeline.scala 35:26]
    .clock(reg_file_clock),
    .io_raddr_1(reg_file_io_raddr_1),
    .io_raddr_2(reg_file_io_raddr_2),
    .io_rdata_1(reg_file_io_rdata_1),
    .io_rdata_2(reg_file_io_rdata_2),
    .io_wen(reg_file_io_wen),
    .io_waddr(reg_file_io_waddr),
    .io_wdata(reg_file_io_wdata)
  );
  ALU alu ( // @[pipeline.scala 36:26]
    .io_in_a(alu_io_in_a),
    .io_in_b(alu_io_in_b),
    .io_alu_op(alu_io_alu_op),
    .io_out(alu_io_out),
    .io_sum(alu_io_sum)
  );
  Imm gen_imm ( // @[pipeline.scala 37:26]
    .io_inst(gen_imm_io_inst),
    .io_imm_sel(gen_imm_io_imm_sel),
    .io_imm_out(gen_imm_io_imm_out)
  );
  Branch cond_br ( // @[pipeline.scala 38:26]
    .io_in_a(cond_br_io_in_a),
    .io_in_b(cond_br_io_in_b),
    .io_br_type(cond_br_io_br_type),
    .io_br_taken(cond_br_io_br_taken)
  );
  LS_Unit lsu ( // @[pipeline.scala 137:19]
    .io_lsu_st_type(lsu_io_lsu_st_type),
    .io_lsu_wdata_in(lsu_io_lsu_wdata_in),
    .io_lsu_wdata_out(lsu_io_lsu_wdata_out),
    .io_lsu_rdata_in(lsu_io_lsu_rdata_in),
    .io_lsu_rdata_out(lsu_io_lsu_rdata_out),
    .io_lsu_ld_type(lsu_io_lsu_ld_type)
  );
  assign io_ibus_addr = _npc_T_14[31:0]; // @[pipeline.scala 75:18]
  assign io_dbus_addr = alu_io_sum; // @[pipeline.scala 152:23]
  assign io_dbus_wdata = lsu_io_lsu_wdata_out; // @[pipeline.scala 142:23]
  assign io_dbus_rd_en = |io_ctrl_ld_type; // @[pipeline.scala 145:42]
  assign io_dbus_wr_en = hazard_stall ? 1'h0 : |io_ctrl_st_type; // @[pipeline.scala 123:28]
  assign io_dbus_st_type = io_ctrl_st_type; // @[pipeline.scala 124:22]
  assign io_dbus_ld_type = io_ctrl_ld_type; // @[pipeline.scala 146:23]
  assign io_ctrl_inst = fet_exe_inst; // @[pipeline.scala 87:22]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_stall = hazard_stall | dmem_stall; // @[pipeline.scala 120:38]
  assign csr_io_cmd = ctrl_csr_cmd; // @[pipeline.scala 192:20]
  assign csr_io_in = csr_in; // @[pipeline.scala 191:20]
  assign csr_io_pc = exe_wb_pc; // @[pipeline.scala 194:20]
  assign csr_io_addr = exe_wb_alu; // @[pipeline.scala 195:20]
  assign csr_io_inst = exe_wb_inst; // @[pipeline.scala 193:20]
  assign csr_io_illegal = ctrl_illegal; // @[pipeline.scala 196:20]
  assign csr_io_st_type = ctrl_st_type; // @[pipeline.scala 199:20]
  assign csr_io_ld_type = ctrl_ld_type; // @[pipeline.scala 198:20]
  assign csr_io_pc_check = ctrl_pc_check; // @[pipeline.scala 197:20]
  assign csr_io_irq_uart_irq = io_irq_uart_irq; // @[pipeline.scala 203:20]
  assign csr_io_irq_spi_irq = io_irq_spi_irq; // @[pipeline.scala 203:20]
  assign csr_io_irq_m1_irq = io_irq_m1_irq; // @[pipeline.scala 203:20]
  assign csr_io_irq_m2_irq = io_irq_m2_irq; // @[pipeline.scala 203:20]
  assign csr_io_irq_m3_irq = io_irq_m3_irq; // @[pipeline.scala 203:20]
  assign csr_io_br_taken = cond_br_io_br_taken; // @[pipeline.scala 200:20]
  assign reg_file_clock = clock;
  assign reg_file_io_raddr_1 = fet_exe_inst[19:15]; // @[pipeline.scala 91:37]
  assign reg_file_io_raddr_2 = fet_exe_inst[24:20]; // @[pipeline.scala 92:37]
  assign reg_file_io_wen = ctrl_wb_en & _T_6; // @[pipeline.scala 213:36]
  assign reg_file_io_waddr = exe_wb_inst[11:7]; // @[pipeline.scala 102:35]
  assign reg_file_io_wdata = reg_file_wdata[31:0]; // @[pipeline.scala 215:22]
  assign alu_io_in_a = io_ctrl_a_sel ? rs1 : fet_exe_pc; // @[pipeline.scala 127:28]
  assign alu_io_in_b = io_ctrl_b_sel ? rs2 : gen_imm_io_imm_out; // @[pipeline.scala 128:28]
  assign alu_io_alu_op = io_ctrl_alu_op[3:0]; // @[pipeline.scala 129:22]
  assign gen_imm_io_inst = fet_exe_inst; // @[pipeline.scala 97:22]
  assign gen_imm_io_imm_sel = io_ctrl_imm_sel; // @[pipeline.scala 98:26]
  assign cond_br_io_in_a = ctrl_wb_mux_sel == 2'h0 & rs1hazard ? exe_wb_alu : reg_file_io_rdata_1; // @[pipeline.scala 107:27]
  assign cond_br_io_in_b = _rs1_T & rs2hazard ? exe_wb_alu : reg_file_io_rdata_2; // @[pipeline.scala 108:27]
  assign cond_br_io_br_type = io_ctrl_br_type; // @[pipeline.scala 134:22]
  assign lsu_io_lsu_st_type = io_ctrl_st_type; // @[pipeline.scala 140:23]
  assign lsu_io_lsu_wdata_in = _rs1_T & rs2hazard ? exe_wb_alu : reg_file_io_rdata_2; // @[pipeline.scala 108:27]
  assign lsu_io_lsu_rdata_in = io_dbus_rdata; // @[pipeline.scala 148:23]
  assign lsu_io_lsu_ld_type = ctrl_ld_type; // @[pipeline.scala 147:23]
  always @(posedge clock) begin
    if (reset) begin // @[pipeline.scala 42:30]
      fet_exe_inst <= 32'h13; // @[pipeline.scala 42:30]
    end else if (~stall) begin // @[pipeline.scala 80:17]
      if (notstarted | io_ctrl_inst_kill | cond_br_io_br_taken | csr_io_expt | _npc_T) begin // @[pipeline.scala 72:23]
        fet_exe_inst <= 32'h13;
      end else begin
        fet_exe_inst <= io_ibus_inst;
      end
    end
    if (~stall) begin // @[pipeline.scala 80:17]
      if (!(io_ctrl_inst_kill | cond_br_io_br_taken | csr_io_expt)) begin // @[pipeline.scala 81:25]
        fet_exe_pc <= pc;
      end
    end
    if (reset) begin // @[pipeline.scala 46:33]
      exe_wb_inst <= 32'h13; // @[pipeline.scala 46:33]
    end else if (!(reset | _T & csr_io_expt)) begin // @[pipeline.scala 157:47]
      if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
        exe_wb_inst <= fet_exe_inst; // @[pipeline.scala 167:23]
      end
    end
    if (!(reset | _T & csr_io_expt)) begin // @[pipeline.scala 157:47]
      if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
        exe_wb_pc <= fet_exe_pc; // @[pipeline.scala 166:23]
      end
    end
    if (!(reset | _T & csr_io_expt)) begin // @[pipeline.scala 157:47]
      if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
        exe_wb_alu <= alu_io_out; // @[pipeline.scala 168:23]
      end
    end
    if (!(reset | _T & csr_io_expt)) begin // @[pipeline.scala 157:47]
      if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
        if (io_ctrl_imm_sel == 3'h6) begin // @[pipeline.scala 170:29]
          csr_in <= gen_imm_io_imm_out;
        end else if (ctrl_wb_mux_sel == 2'h0 & rs1hazard) begin // @[pipeline.scala 107:27]
          csr_in <= exe_wb_alu;
        end else begin
          csr_in <= reg_file_io_rdata_1;
        end
      end
    end
    if (reset | _T & csr_io_expt) begin // @[pipeline.scala 157:47]
      ctrl_st_type <= 2'h0; // @[pipeline.scala 158:23]
    end else if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
      ctrl_st_type <= io_ctrl_st_type; // @[pipeline.scala 171:23]
    end else if (hazard_stall) begin // @[pipeline.scala 178:28]
      ctrl_st_type <= 2'h0; // @[pipeline.scala 182:23]
    end
    if (reset | _T & csr_io_expt) begin // @[pipeline.scala 157:47]
      ctrl_ld_type <= 3'h0; // @[pipeline.scala 159:23]
    end else if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
      ctrl_ld_type <= io_ctrl_ld_type; // @[pipeline.scala 172:23]
    end else if (hazard_stall) begin // @[pipeline.scala 178:28]
      ctrl_ld_type <= 3'h0; // @[pipeline.scala 183:23]
    end
    if (!(reset | _T & csr_io_expt)) begin // @[pipeline.scala 157:47]
      if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
        ctrl_wb_mux_sel <= io_ctrl_wb_mux_sel; // @[pipeline.scala 173:23]
      end
    end
    if (reset | _T & csr_io_expt) begin // @[pipeline.scala 157:47]
      ctrl_wb_en <= 1'h0; // @[pipeline.scala 160:23]
    end else if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
      ctrl_wb_en <= io_ctrl_wb_en; // @[pipeline.scala 174:23]
    end else if (hazard_stall) begin // @[pipeline.scala 178:28]
      ctrl_wb_en <= 1'h0; // @[pipeline.scala 184:23]
    end
    if (reset | _T & csr_io_expt) begin // @[pipeline.scala 157:47]
      ctrl_csr_cmd <= 3'h0; // @[pipeline.scala 161:23]
    end else if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
      ctrl_csr_cmd <= io_ctrl_csr_cmd; // @[pipeline.scala 175:23]
    end else if (hazard_stall) begin // @[pipeline.scala 178:28]
      ctrl_csr_cmd <= 3'h0; // @[pipeline.scala 185:23]
    end
    if (reset | _T & csr_io_expt) begin // @[pipeline.scala 157:47]
      ctrl_illegal <= 1'h0; // @[pipeline.scala 162:23]
    end else if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
      ctrl_illegal <= io_ctrl_illegal; // @[pipeline.scala 176:23]
    end
    if (reset | _T & csr_io_expt) begin // @[pipeline.scala 157:47]
      ctrl_pc_check <= 1'h0; // @[pipeline.scala 163:23]
    end else if (_T & ~csr_io_expt) begin // @[pipeline.scala 164:38]
      ctrl_pc_check <= _npc_T_3; // @[pipeline.scala 177:23]
    end
    notstarted <= reset; // @[pipeline.scala 61:34]
    if (reset) begin // @[pipeline.scala 64:27]
      pc <= _pc_T_1; // @[pipeline.scala 64:27]
    end else begin
      pc <= npc; // @[pipeline.scala 74:18]
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fet_exe_inst = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  fet_exe_pc = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  exe_wb_inst = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  exe_wb_pc = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  exe_wb_alu = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  csr_in = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  ctrl_st_type = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  ctrl_ld_type = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  ctrl_wb_mux_sel = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  ctrl_wb_en = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  ctrl_csr_cmd = _RAND_10[2:0];
  _RAND_11 = {1{`RANDOM}};
  ctrl_illegal = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  ctrl_pc_check = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  notstarted = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  pc = _RAND_14[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Control(
  input  [31:0] io_inst,
  output [1:0]  io_pc_sel,
  output        io_inst_kill,
  output        io_a_sel,
  output        io_b_sel,
  output [2:0]  io_imm_sel,
  output [4:0]  io_alu_op,
  output [2:0]  io_br_type,
  output [1:0]  io_st_type,
  output [2:0]  io_ld_type,
  output [1:0]  io_wb_mux_sel,
  output        io_wb_en,
  output [2:0]  io_csr_cmd,
  output        io_illegal,
  output        io_en_rs1,
  output        io_en_rs2
);
  wire [31:0] _ctrlSignals_T = io_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_1 = 32'h37 == _ctrlSignals_T; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_3 = 32'h17 == _ctrlSignals_T; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_5 = 32'h6f == _ctrlSignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _ctrlSignals_T_6 = io_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_7 = 32'h67 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_9 = 32'h63 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_11 = 32'h1063 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_13 = 32'h4063 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_15 = 32'h5063 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_17 = 32'h6063 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_19 = 32'h7063 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_21 = 32'h3 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_23 = 32'h1003 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_25 = 32'h2003 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_27 = 32'h4003 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_29 = 32'h5003 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_31 = 32'h23 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_33 = 32'h1023 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_35 = 32'h2023 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_37 = 32'h13 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_39 = 32'h2013 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_41 = 32'h3013 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_43 = 32'h4013 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_45 = 32'h6013 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_47 = 32'h7013 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire [31:0] _ctrlSignals_T_48 = io_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_49 = 32'h1013 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_51 = 32'h5013 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_53 = 32'h40005013 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_55 = 32'h33 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_57 = 32'h40000033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_59 = 32'h1033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_61 = 32'h2033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_63 = 32'h3033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_65 = 32'h4033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_67 = 32'h5033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_69 = 32'h40005033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_71 = 32'h6033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_73 = 32'h7033 == _ctrlSignals_T_48; // @[Lookup.scala 31:38]
  wire [31:0] _ctrlSignals_T_74 = io_inst & 32'hf00fffff; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_75 = 32'hf == _ctrlSignals_T_74; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_77 = 32'h100f == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_79 = 32'h1073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_81 = 32'h2073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_83 = 32'h3073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_85 = 32'h5073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_87 = 32'h6073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_89 = 32'h7073 == _ctrlSignals_T_6; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_91 = 32'h73 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_93 = 32'h100073 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_95 = 32'h30200073 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrlSignals_T_97 = 32'h10500073 == io_inst; // @[Lookup.scala 31:38]
  wire [1:0] _ctrlSignals_T_99 = _ctrlSignals_T_95 ? 2'h3 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_100 = _ctrlSignals_T_93 ? 2'h0 : _ctrlSignals_T_99; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_101 = _ctrlSignals_T_91 ? 2'h0 : _ctrlSignals_T_100; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_102 = _ctrlSignals_T_89 ? 2'h0 : _ctrlSignals_T_101; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_103 = _ctrlSignals_T_87 ? 2'h0 : _ctrlSignals_T_102; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_104 = _ctrlSignals_T_85 ? 2'h0 : _ctrlSignals_T_103; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_105 = _ctrlSignals_T_83 ? 2'h0 : _ctrlSignals_T_104; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_106 = _ctrlSignals_T_81 ? 2'h0 : _ctrlSignals_T_105; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_107 = _ctrlSignals_T_79 ? 2'h0 : _ctrlSignals_T_106; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_108 = _ctrlSignals_T_77 ? 2'h2 : _ctrlSignals_T_107; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_109 = _ctrlSignals_T_75 ? 2'h0 : _ctrlSignals_T_108; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_110 = _ctrlSignals_T_73 ? 2'h0 : _ctrlSignals_T_109; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_111 = _ctrlSignals_T_71 ? 2'h0 : _ctrlSignals_T_110; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_112 = _ctrlSignals_T_69 ? 2'h0 : _ctrlSignals_T_111; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_113 = _ctrlSignals_T_67 ? 2'h0 : _ctrlSignals_T_112; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_114 = _ctrlSignals_T_65 ? 2'h0 : _ctrlSignals_T_113; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_115 = _ctrlSignals_T_63 ? 2'h0 : _ctrlSignals_T_114; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_116 = _ctrlSignals_T_61 ? 2'h0 : _ctrlSignals_T_115; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_117 = _ctrlSignals_T_59 ? 2'h0 : _ctrlSignals_T_116; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_118 = _ctrlSignals_T_57 ? 2'h0 : _ctrlSignals_T_117; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_119 = _ctrlSignals_T_55 ? 2'h0 : _ctrlSignals_T_118; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_120 = _ctrlSignals_T_53 ? 2'h0 : _ctrlSignals_T_119; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_121 = _ctrlSignals_T_51 ? 2'h0 : _ctrlSignals_T_120; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_122 = _ctrlSignals_T_49 ? 2'h0 : _ctrlSignals_T_121; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_123 = _ctrlSignals_T_47 ? 2'h0 : _ctrlSignals_T_122; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_124 = _ctrlSignals_T_45 ? 2'h0 : _ctrlSignals_T_123; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_125 = _ctrlSignals_T_43 ? 2'h0 : _ctrlSignals_T_124; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_126 = _ctrlSignals_T_41 ? 2'h0 : _ctrlSignals_T_125; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_127 = _ctrlSignals_T_39 ? 2'h0 : _ctrlSignals_T_126; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_128 = _ctrlSignals_T_37 ? 2'h0 : _ctrlSignals_T_127; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_129 = _ctrlSignals_T_35 ? 2'h0 : _ctrlSignals_T_128; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_130 = _ctrlSignals_T_33 ? 2'h0 : _ctrlSignals_T_129; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_131 = _ctrlSignals_T_31 ? 2'h0 : _ctrlSignals_T_130; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_132 = _ctrlSignals_T_29 ? 2'h0 : _ctrlSignals_T_131; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_133 = _ctrlSignals_T_27 ? 2'h0 : _ctrlSignals_T_132; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_134 = _ctrlSignals_T_25 ? 2'h0 : _ctrlSignals_T_133; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_135 = _ctrlSignals_T_23 ? 2'h0 : _ctrlSignals_T_134; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_136 = _ctrlSignals_T_21 ? 2'h0 : _ctrlSignals_T_135; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_137 = _ctrlSignals_T_19 ? 2'h0 : _ctrlSignals_T_136; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_138 = _ctrlSignals_T_17 ? 2'h0 : _ctrlSignals_T_137; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_139 = _ctrlSignals_T_15 ? 2'h0 : _ctrlSignals_T_138; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_140 = _ctrlSignals_T_13 ? 2'h0 : _ctrlSignals_T_139; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_141 = _ctrlSignals_T_11 ? 2'h0 : _ctrlSignals_T_140; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_142 = _ctrlSignals_T_9 ? 2'h0 : _ctrlSignals_T_141; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_143 = _ctrlSignals_T_7 ? 2'h1 : _ctrlSignals_T_142; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_144 = _ctrlSignals_T_5 ? 2'h1 : _ctrlSignals_T_143; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_145 = _ctrlSignals_T_3 ? 2'h0 : _ctrlSignals_T_144; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_156 = _ctrlSignals_T_77 ? 1'h0 : _ctrlSignals_T_79 | (_ctrlSignals_T_81 | _ctrlSignals_T_83); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_157 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_156; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_185 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_21 | (_ctrlSignals_T_23 | (_ctrlSignals_T_25 | (
    _ctrlSignals_T_27 | (_ctrlSignals_T_29 | (_ctrlSignals_T_31 | (_ctrlSignals_T_33 | (_ctrlSignals_T_35 | (
    _ctrlSignals_T_37 | (_ctrlSignals_T_39 | (_ctrlSignals_T_41 | (_ctrlSignals_T_43 | (_ctrlSignals_T_45 | (
    _ctrlSignals_T_47 | (_ctrlSignals_T_49 | (_ctrlSignals_T_51 | (_ctrlSignals_T_53 | (_ctrlSignals_T_55 | (
    _ctrlSignals_T_57 | (_ctrlSignals_T_59 | (_ctrlSignals_T_61 | (_ctrlSignals_T_63 | (_ctrlSignals_T_65 | (
    _ctrlSignals_T_67 | (_ctrlSignals_T_69 | (_ctrlSignals_T_71 | (_ctrlSignals_T_73 | _ctrlSignals_T_157)))))))))))))))
    ))))))))))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_186 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_185; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_187 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_186; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_188 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_187; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_189 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_188; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_190 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_189; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_192 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_7 | _ctrlSignals_T_190; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_193 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_192; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_216 = _ctrlSignals_T_53 ? 1'h0 : _ctrlSignals_T_55 | (_ctrlSignals_T_57 | (_ctrlSignals_T_59 | (
    _ctrlSignals_T_61 | (_ctrlSignals_T_63 | (_ctrlSignals_T_65 | (_ctrlSignals_T_67 | (_ctrlSignals_T_69 | (
    _ctrlSignals_T_71 | _ctrlSignals_T_73)))))))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_217 = _ctrlSignals_T_51 ? 1'h0 : _ctrlSignals_T_216; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_218 = _ctrlSignals_T_49 ? 1'h0 : _ctrlSignals_T_217; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_219 = _ctrlSignals_T_47 ? 1'h0 : _ctrlSignals_T_218; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_220 = _ctrlSignals_T_45 ? 1'h0 : _ctrlSignals_T_219; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_221 = _ctrlSignals_T_43 ? 1'h0 : _ctrlSignals_T_220; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_222 = _ctrlSignals_T_41 ? 1'h0 : _ctrlSignals_T_221; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_223 = _ctrlSignals_T_39 ? 1'h0 : _ctrlSignals_T_222; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_224 = _ctrlSignals_T_37 ? 1'h0 : _ctrlSignals_T_223; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_225 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_224; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_226 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_225; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_227 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_226; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_228 = _ctrlSignals_T_29 ? 1'h0 : _ctrlSignals_T_227; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_229 = _ctrlSignals_T_27 ? 1'h0 : _ctrlSignals_T_228; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_230 = _ctrlSignals_T_25 ? 1'h0 : _ctrlSignals_T_229; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_231 = _ctrlSignals_T_23 ? 1'h0 : _ctrlSignals_T_230; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_232 = _ctrlSignals_T_21 ? 1'h0 : _ctrlSignals_T_231; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_233 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_232; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_234 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_233; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_235 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_234; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_236 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_235; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_237 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_236; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_238 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_237; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_239 = _ctrlSignals_T_7 ? 1'h0 : _ctrlSignals_T_238; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_240 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_239; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_241 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_240; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_246 = _ctrlSignals_T_89 ? 3'h6 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_247 = _ctrlSignals_T_87 ? 3'h6 : _ctrlSignals_T_246; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_248 = _ctrlSignals_T_85 ? 3'h6 : _ctrlSignals_T_247; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_249 = _ctrlSignals_T_83 ? 3'h0 : _ctrlSignals_T_248; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_250 = _ctrlSignals_T_81 ? 3'h0 : _ctrlSignals_T_249; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_251 = _ctrlSignals_T_79 ? 3'h0 : _ctrlSignals_T_250; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_252 = _ctrlSignals_T_77 ? 3'h0 : _ctrlSignals_T_251; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_253 = _ctrlSignals_T_75 ? 3'h0 : _ctrlSignals_T_252; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_254 = _ctrlSignals_T_73 ? 3'h0 : _ctrlSignals_T_253; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_255 = _ctrlSignals_T_71 ? 3'h0 : _ctrlSignals_T_254; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_256 = _ctrlSignals_T_69 ? 3'h0 : _ctrlSignals_T_255; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_257 = _ctrlSignals_T_67 ? 3'h0 : _ctrlSignals_T_256; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_258 = _ctrlSignals_T_65 ? 3'h0 : _ctrlSignals_T_257; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_259 = _ctrlSignals_T_63 ? 3'h0 : _ctrlSignals_T_258; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_260 = _ctrlSignals_T_61 ? 3'h0 : _ctrlSignals_T_259; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_261 = _ctrlSignals_T_59 ? 3'h0 : _ctrlSignals_T_260; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_262 = _ctrlSignals_T_57 ? 3'h0 : _ctrlSignals_T_261; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_263 = _ctrlSignals_T_55 ? 3'h0 : _ctrlSignals_T_262; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_264 = _ctrlSignals_T_53 ? 3'h1 : _ctrlSignals_T_263; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_265 = _ctrlSignals_T_51 ? 3'h1 : _ctrlSignals_T_264; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_266 = _ctrlSignals_T_49 ? 3'h1 : _ctrlSignals_T_265; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_267 = _ctrlSignals_T_47 ? 3'h1 : _ctrlSignals_T_266; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_268 = _ctrlSignals_T_45 ? 3'h1 : _ctrlSignals_T_267; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_269 = _ctrlSignals_T_43 ? 3'h1 : _ctrlSignals_T_268; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_270 = _ctrlSignals_T_41 ? 3'h1 : _ctrlSignals_T_269; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_271 = _ctrlSignals_T_39 ? 3'h1 : _ctrlSignals_T_270; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_272 = _ctrlSignals_T_37 ? 3'h1 : _ctrlSignals_T_271; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_273 = _ctrlSignals_T_35 ? 3'h2 : _ctrlSignals_T_272; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_274 = _ctrlSignals_T_33 ? 3'h2 : _ctrlSignals_T_273; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_275 = _ctrlSignals_T_31 ? 3'h2 : _ctrlSignals_T_274; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_276 = _ctrlSignals_T_29 ? 3'h1 : _ctrlSignals_T_275; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_277 = _ctrlSignals_T_27 ? 3'h1 : _ctrlSignals_T_276; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_278 = _ctrlSignals_T_25 ? 3'h1 : _ctrlSignals_T_277; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_279 = _ctrlSignals_T_23 ? 3'h1 : _ctrlSignals_T_278; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_280 = _ctrlSignals_T_21 ? 3'h1 : _ctrlSignals_T_279; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_281 = _ctrlSignals_T_19 ? 3'h5 : _ctrlSignals_T_280; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_282 = _ctrlSignals_T_17 ? 3'h5 : _ctrlSignals_T_281; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_283 = _ctrlSignals_T_15 ? 3'h5 : _ctrlSignals_T_282; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_284 = _ctrlSignals_T_13 ? 3'h5 : _ctrlSignals_T_283; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_285 = _ctrlSignals_T_11 ? 3'h5 : _ctrlSignals_T_284; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_286 = _ctrlSignals_T_9 ? 3'h5 : _ctrlSignals_T_285; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_287 = _ctrlSignals_T_7 ? 3'h1 : _ctrlSignals_T_286; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_288 = _ctrlSignals_T_5 ? 3'h4 : _ctrlSignals_T_287; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_289 = _ctrlSignals_T_3 ? 3'h3 : _ctrlSignals_T_288; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_297 = _ctrlSignals_T_83 ? 4'ha : 4'hf; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_298 = _ctrlSignals_T_81 ? 4'ha : _ctrlSignals_T_297; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_299 = _ctrlSignals_T_79 ? 4'ha : _ctrlSignals_T_298; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_300 = _ctrlSignals_T_77 ? 4'hf : _ctrlSignals_T_299; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_301 = _ctrlSignals_T_75 ? 4'hf : _ctrlSignals_T_300; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_302 = _ctrlSignals_T_73 ? 4'h2 : _ctrlSignals_T_301; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_303 = _ctrlSignals_T_71 ? 4'h3 : _ctrlSignals_T_302; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_304 = _ctrlSignals_T_69 ? 4'h9 : _ctrlSignals_T_303; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_305 = _ctrlSignals_T_67 ? 4'h8 : _ctrlSignals_T_304; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_306 = _ctrlSignals_T_65 ? 4'h4 : _ctrlSignals_T_305; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_307 = _ctrlSignals_T_63 ? 4'h7 : _ctrlSignals_T_306; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_308 = _ctrlSignals_T_61 ? 4'h5 : _ctrlSignals_T_307; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_309 = _ctrlSignals_T_59 ? 4'h6 : _ctrlSignals_T_308; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_310 = _ctrlSignals_T_57 ? 4'h1 : _ctrlSignals_T_309; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_311 = _ctrlSignals_T_55 ? 4'h0 : _ctrlSignals_T_310; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_312 = _ctrlSignals_T_53 ? 4'h9 : _ctrlSignals_T_311; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_313 = _ctrlSignals_T_51 ? 4'h8 : _ctrlSignals_T_312; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_314 = _ctrlSignals_T_49 ? 4'h6 : _ctrlSignals_T_313; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_315 = _ctrlSignals_T_47 ? 4'h2 : _ctrlSignals_T_314; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_316 = _ctrlSignals_T_45 ? 4'h3 : _ctrlSignals_T_315; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_317 = _ctrlSignals_T_43 ? 4'h4 : _ctrlSignals_T_316; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_318 = _ctrlSignals_T_41 ? 4'h7 : _ctrlSignals_T_317; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_319 = _ctrlSignals_T_39 ? 4'h5 : _ctrlSignals_T_318; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_320 = _ctrlSignals_T_37 ? 4'h0 : _ctrlSignals_T_319; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_321 = _ctrlSignals_T_35 ? 4'h0 : _ctrlSignals_T_320; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_322 = _ctrlSignals_T_33 ? 4'h0 : _ctrlSignals_T_321; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_323 = _ctrlSignals_T_31 ? 4'h0 : _ctrlSignals_T_322; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_324 = _ctrlSignals_T_29 ? 4'h0 : _ctrlSignals_T_323; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_325 = _ctrlSignals_T_27 ? 4'h0 : _ctrlSignals_T_324; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_326 = _ctrlSignals_T_25 ? 4'h0 : _ctrlSignals_T_325; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_327 = _ctrlSignals_T_23 ? 4'h0 : _ctrlSignals_T_326; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_328 = _ctrlSignals_T_21 ? 4'h0 : _ctrlSignals_T_327; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_329 = _ctrlSignals_T_19 ? 4'h0 : _ctrlSignals_T_328; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_330 = _ctrlSignals_T_17 ? 4'h0 : _ctrlSignals_T_329; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_331 = _ctrlSignals_T_15 ? 4'h0 : _ctrlSignals_T_330; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_332 = _ctrlSignals_T_13 ? 4'h0 : _ctrlSignals_T_331; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_333 = _ctrlSignals_T_11 ? 4'h0 : _ctrlSignals_T_332; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_334 = _ctrlSignals_T_9 ? 4'h0 : _ctrlSignals_T_333; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_335 = _ctrlSignals_T_7 ? 4'h0 : _ctrlSignals_T_334; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_336 = _ctrlSignals_T_5 ? 4'h0 : _ctrlSignals_T_335; // @[Lookup.scala 34:39]
  wire [3:0] _ctrlSignals_T_337 = _ctrlSignals_T_3 ? 4'h0 : _ctrlSignals_T_336; // @[Lookup.scala 34:39]
  wire [3:0] ctrlSignals_4 = _ctrlSignals_T_1 ? 4'hb : _ctrlSignals_T_337; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_377 = _ctrlSignals_T_19 ? 3'h4 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_378 = _ctrlSignals_T_17 ? 3'h1 : _ctrlSignals_T_377; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_379 = _ctrlSignals_T_15 ? 3'h5 : _ctrlSignals_T_378; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_380 = _ctrlSignals_T_13 ? 3'h2 : _ctrlSignals_T_379; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_381 = _ctrlSignals_T_11 ? 3'h6 : _ctrlSignals_T_380; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_382 = _ctrlSignals_T_9 ? 3'h3 : _ctrlSignals_T_381; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_383 = _ctrlSignals_T_7 ? 3'h0 : _ctrlSignals_T_382; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_384 = _ctrlSignals_T_5 ? 3'h0 : _ctrlSignals_T_383; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_385 = _ctrlSignals_T_3 ? 3'h0 : _ctrlSignals_T_384; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_388 = _ctrlSignals_T_93 ? 1'h0 : _ctrlSignals_T_95; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_389 = _ctrlSignals_T_91 ? 1'h0 : _ctrlSignals_T_388; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_390 = _ctrlSignals_T_89 ? 1'h0 : _ctrlSignals_T_389; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_391 = _ctrlSignals_T_87 ? 1'h0 : _ctrlSignals_T_390; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_392 = _ctrlSignals_T_85 ? 1'h0 : _ctrlSignals_T_391; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_393 = _ctrlSignals_T_83 ? 1'h0 : _ctrlSignals_T_392; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_394 = _ctrlSignals_T_81 ? 1'h0 : _ctrlSignals_T_393; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_395 = _ctrlSignals_T_79 ? 1'h0 : _ctrlSignals_T_394; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_397 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_77 | _ctrlSignals_T_395; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_398 = _ctrlSignals_T_73 ? 1'h0 : _ctrlSignals_T_397; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_399 = _ctrlSignals_T_71 ? 1'h0 : _ctrlSignals_T_398; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_400 = _ctrlSignals_T_69 ? 1'h0 : _ctrlSignals_T_399; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_401 = _ctrlSignals_T_67 ? 1'h0 : _ctrlSignals_T_400; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_402 = _ctrlSignals_T_65 ? 1'h0 : _ctrlSignals_T_401; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_403 = _ctrlSignals_T_63 ? 1'h0 : _ctrlSignals_T_402; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_404 = _ctrlSignals_T_61 ? 1'h0 : _ctrlSignals_T_403; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_405 = _ctrlSignals_T_59 ? 1'h0 : _ctrlSignals_T_404; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_406 = _ctrlSignals_T_57 ? 1'h0 : _ctrlSignals_T_405; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_407 = _ctrlSignals_T_55 ? 1'h0 : _ctrlSignals_T_406; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_408 = _ctrlSignals_T_53 ? 1'h0 : _ctrlSignals_T_407; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_409 = _ctrlSignals_T_51 ? 1'h0 : _ctrlSignals_T_408; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_410 = _ctrlSignals_T_49 ? 1'h0 : _ctrlSignals_T_409; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_411 = _ctrlSignals_T_47 ? 1'h0 : _ctrlSignals_T_410; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_412 = _ctrlSignals_T_45 ? 1'h0 : _ctrlSignals_T_411; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_413 = _ctrlSignals_T_43 ? 1'h0 : _ctrlSignals_T_412; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_414 = _ctrlSignals_T_41 ? 1'h0 : _ctrlSignals_T_413; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_415 = _ctrlSignals_T_39 ? 1'h0 : _ctrlSignals_T_414; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_416 = _ctrlSignals_T_37 ? 1'h0 : _ctrlSignals_T_415; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_417 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_416; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_418 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_417; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_419 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_418; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_420 = _ctrlSignals_T_29 ? 1'h0 : _ctrlSignals_T_419; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_421 = _ctrlSignals_T_27 ? 1'h0 : _ctrlSignals_T_420; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_422 = _ctrlSignals_T_25 ? 1'h0 : _ctrlSignals_T_421; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_423 = _ctrlSignals_T_23 ? 1'h0 : _ctrlSignals_T_422; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_424 = _ctrlSignals_T_21 ? 1'h0 : _ctrlSignals_T_423; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_425 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_424; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_426 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_425; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_427 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_426; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_428 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_427; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_429 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_428; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_430 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_429; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_433 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_5 | (_ctrlSignals_T_7 | _ctrlSignals_T_430); // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_465 = _ctrlSignals_T_35 ? 2'h1 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_466 = _ctrlSignals_T_33 ? 2'h2 : _ctrlSignals_T_465; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_467 = _ctrlSignals_T_31 ? 2'h3 : _ctrlSignals_T_466; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_468 = _ctrlSignals_T_29 ? 2'h0 : _ctrlSignals_T_467; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_469 = _ctrlSignals_T_27 ? 2'h0 : _ctrlSignals_T_468; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_470 = _ctrlSignals_T_25 ? 2'h0 : _ctrlSignals_T_469; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_471 = _ctrlSignals_T_23 ? 2'h0 : _ctrlSignals_T_470; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_472 = _ctrlSignals_T_21 ? 2'h0 : _ctrlSignals_T_471; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_473 = _ctrlSignals_T_19 ? 2'h0 : _ctrlSignals_T_472; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_474 = _ctrlSignals_T_17 ? 2'h0 : _ctrlSignals_T_473; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_475 = _ctrlSignals_T_15 ? 2'h0 : _ctrlSignals_T_474; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_476 = _ctrlSignals_T_13 ? 2'h0 : _ctrlSignals_T_475; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_477 = _ctrlSignals_T_11 ? 2'h0 : _ctrlSignals_T_476; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_478 = _ctrlSignals_T_9 ? 2'h0 : _ctrlSignals_T_477; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_479 = _ctrlSignals_T_7 ? 2'h0 : _ctrlSignals_T_478; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_480 = _ctrlSignals_T_5 ? 2'h0 : _ctrlSignals_T_479; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_481 = _ctrlSignals_T_3 ? 2'h0 : _ctrlSignals_T_480; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_516 = _ctrlSignals_T_29 ? 3'h4 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_517 = _ctrlSignals_T_27 ? 3'h5 : _ctrlSignals_T_516; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_518 = _ctrlSignals_T_25 ? 3'h1 : _ctrlSignals_T_517; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_519 = _ctrlSignals_T_23 ? 3'h2 : _ctrlSignals_T_518; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_520 = _ctrlSignals_T_21 ? 3'h3 : _ctrlSignals_T_519; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_521 = _ctrlSignals_T_19 ? 3'h0 : _ctrlSignals_T_520; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_522 = _ctrlSignals_T_17 ? 3'h0 : _ctrlSignals_T_521; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_523 = _ctrlSignals_T_15 ? 3'h0 : _ctrlSignals_T_522; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_524 = _ctrlSignals_T_13 ? 3'h0 : _ctrlSignals_T_523; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_525 = _ctrlSignals_T_11 ? 3'h0 : _ctrlSignals_T_524; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_526 = _ctrlSignals_T_9 ? 3'h0 : _ctrlSignals_T_525; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_527 = _ctrlSignals_T_7 ? 3'h0 : _ctrlSignals_T_526; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_528 = _ctrlSignals_T_5 ? 3'h0 : _ctrlSignals_T_527; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_529 = _ctrlSignals_T_3 ? 3'h0 : _ctrlSignals_T_528; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_532 = _ctrlSignals_T_93 ? 2'h3 : _ctrlSignals_T_99; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_533 = _ctrlSignals_T_91 ? 2'h3 : _ctrlSignals_T_532; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_534 = _ctrlSignals_T_89 ? 2'h3 : _ctrlSignals_T_533; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_535 = _ctrlSignals_T_87 ? 2'h3 : _ctrlSignals_T_534; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_536 = _ctrlSignals_T_85 ? 2'h3 : _ctrlSignals_T_535; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_537 = _ctrlSignals_T_83 ? 2'h3 : _ctrlSignals_T_536; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_538 = _ctrlSignals_T_81 ? 2'h3 : _ctrlSignals_T_537; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_539 = _ctrlSignals_T_79 ? 2'h3 : _ctrlSignals_T_538; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_540 = _ctrlSignals_T_77 ? 2'h0 : _ctrlSignals_T_539; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_541 = _ctrlSignals_T_75 ? 2'h0 : _ctrlSignals_T_540; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_542 = _ctrlSignals_T_73 ? 2'h0 : _ctrlSignals_T_541; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_543 = _ctrlSignals_T_71 ? 2'h0 : _ctrlSignals_T_542; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_544 = _ctrlSignals_T_69 ? 2'h0 : _ctrlSignals_T_543; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_545 = _ctrlSignals_T_67 ? 2'h0 : _ctrlSignals_T_544; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_546 = _ctrlSignals_T_65 ? 2'h0 : _ctrlSignals_T_545; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_547 = _ctrlSignals_T_63 ? 2'h0 : _ctrlSignals_T_546; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_548 = _ctrlSignals_T_61 ? 2'h0 : _ctrlSignals_T_547; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_549 = _ctrlSignals_T_59 ? 2'h0 : _ctrlSignals_T_548; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_550 = _ctrlSignals_T_57 ? 2'h0 : _ctrlSignals_T_549; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_551 = _ctrlSignals_T_55 ? 2'h0 : _ctrlSignals_T_550; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_552 = _ctrlSignals_T_53 ? 2'h0 : _ctrlSignals_T_551; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_553 = _ctrlSignals_T_51 ? 2'h0 : _ctrlSignals_T_552; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_554 = _ctrlSignals_T_49 ? 2'h0 : _ctrlSignals_T_553; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_555 = _ctrlSignals_T_47 ? 2'h0 : _ctrlSignals_T_554; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_556 = _ctrlSignals_T_45 ? 2'h0 : _ctrlSignals_T_555; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_557 = _ctrlSignals_T_43 ? 2'h0 : _ctrlSignals_T_556; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_558 = _ctrlSignals_T_41 ? 2'h0 : _ctrlSignals_T_557; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_559 = _ctrlSignals_T_39 ? 2'h0 : _ctrlSignals_T_558; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_560 = _ctrlSignals_T_37 ? 2'h0 : _ctrlSignals_T_559; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_561 = _ctrlSignals_T_35 ? 2'h0 : _ctrlSignals_T_560; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_562 = _ctrlSignals_T_33 ? 2'h0 : _ctrlSignals_T_561; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_563 = _ctrlSignals_T_31 ? 2'h0 : _ctrlSignals_T_562; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_564 = _ctrlSignals_T_29 ? 2'h1 : _ctrlSignals_T_563; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_565 = _ctrlSignals_T_27 ? 2'h1 : _ctrlSignals_T_564; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_566 = _ctrlSignals_T_25 ? 2'h1 : _ctrlSignals_T_565; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_567 = _ctrlSignals_T_23 ? 2'h1 : _ctrlSignals_T_566; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_568 = _ctrlSignals_T_21 ? 2'h1 : _ctrlSignals_T_567; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_569 = _ctrlSignals_T_19 ? 2'h0 : _ctrlSignals_T_568; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_570 = _ctrlSignals_T_17 ? 2'h0 : _ctrlSignals_T_569; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_571 = _ctrlSignals_T_15 ? 2'h0 : _ctrlSignals_T_570; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_572 = _ctrlSignals_T_13 ? 2'h0 : _ctrlSignals_T_571; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_573 = _ctrlSignals_T_11 ? 2'h0 : _ctrlSignals_T_572; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_574 = _ctrlSignals_T_9 ? 2'h0 : _ctrlSignals_T_573; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_575 = _ctrlSignals_T_7 ? 2'h2 : _ctrlSignals_T_574; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_576 = _ctrlSignals_T_5 ? 2'h2 : _ctrlSignals_T_575; // @[Lookup.scala 34:39]
  wire [1:0] _ctrlSignals_T_577 = _ctrlSignals_T_3 ? 2'h0 : _ctrlSignals_T_576; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_588 = _ctrlSignals_T_77 ? 1'h0 : _ctrlSignals_T_79 | (_ctrlSignals_T_81 | (_ctrlSignals_T_83 | (
    _ctrlSignals_T_85 | (_ctrlSignals_T_87 | _ctrlSignals_T_89)))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_589 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_588; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_609 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_37 | (_ctrlSignals_T_39 | (_ctrlSignals_T_41 | (
    _ctrlSignals_T_43 | (_ctrlSignals_T_45 | (_ctrlSignals_T_47 | (_ctrlSignals_T_49 | (_ctrlSignals_T_51 | (
    _ctrlSignals_T_53 | (_ctrlSignals_T_55 | (_ctrlSignals_T_57 | (_ctrlSignals_T_59 | (_ctrlSignals_T_61 | (
    _ctrlSignals_T_63 | (_ctrlSignals_T_65 | (_ctrlSignals_T_67 | (_ctrlSignals_T_69 | (_ctrlSignals_T_71 | (
    _ctrlSignals_T_73 | _ctrlSignals_T_589)))))))))))))))))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_610 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_609; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_611 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_610; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_617 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_21 | (_ctrlSignals_T_23 | (_ctrlSignals_T_25 | (
    _ctrlSignals_T_27 | (_ctrlSignals_T_29 | _ctrlSignals_T_611)))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_618 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_617; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_619 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_618; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_620 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_619; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_621 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_620; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_622 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_621; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_627 = _ctrlSignals_T_95 ? 3'h4 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_628 = _ctrlSignals_T_93 ? 3'h4 : _ctrlSignals_T_627; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_629 = _ctrlSignals_T_91 ? 3'h4 : _ctrlSignals_T_628; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_630 = _ctrlSignals_T_89 ? 3'h3 : _ctrlSignals_T_629; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_631 = _ctrlSignals_T_87 ? 3'h2 : _ctrlSignals_T_630; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_632 = _ctrlSignals_T_85 ? 3'h1 : _ctrlSignals_T_631; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_633 = _ctrlSignals_T_83 ? 3'h3 : _ctrlSignals_T_632; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_634 = _ctrlSignals_T_81 ? 3'h2 : _ctrlSignals_T_633; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_635 = _ctrlSignals_T_79 ? 3'h1 : _ctrlSignals_T_634; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_636 = _ctrlSignals_T_77 ? 3'h0 : _ctrlSignals_T_635; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_637 = _ctrlSignals_T_75 ? 3'h0 : _ctrlSignals_T_636; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_638 = _ctrlSignals_T_73 ? 3'h0 : _ctrlSignals_T_637; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_639 = _ctrlSignals_T_71 ? 3'h0 : _ctrlSignals_T_638; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_640 = _ctrlSignals_T_69 ? 3'h0 : _ctrlSignals_T_639; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_641 = _ctrlSignals_T_67 ? 3'h0 : _ctrlSignals_T_640; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_642 = _ctrlSignals_T_65 ? 3'h0 : _ctrlSignals_T_641; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_643 = _ctrlSignals_T_63 ? 3'h0 : _ctrlSignals_T_642; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_644 = _ctrlSignals_T_61 ? 3'h0 : _ctrlSignals_T_643; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_645 = _ctrlSignals_T_59 ? 3'h0 : _ctrlSignals_T_644; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_646 = _ctrlSignals_T_57 ? 3'h0 : _ctrlSignals_T_645; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_647 = _ctrlSignals_T_55 ? 3'h0 : _ctrlSignals_T_646; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_648 = _ctrlSignals_T_53 ? 3'h0 : _ctrlSignals_T_647; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_649 = _ctrlSignals_T_51 ? 3'h0 : _ctrlSignals_T_648; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_650 = _ctrlSignals_T_49 ? 3'h0 : _ctrlSignals_T_649; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_651 = _ctrlSignals_T_47 ? 3'h0 : _ctrlSignals_T_650; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_652 = _ctrlSignals_T_45 ? 3'h0 : _ctrlSignals_T_651; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_653 = _ctrlSignals_T_43 ? 3'h0 : _ctrlSignals_T_652; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_654 = _ctrlSignals_T_41 ? 3'h0 : _ctrlSignals_T_653; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_655 = _ctrlSignals_T_39 ? 3'h0 : _ctrlSignals_T_654; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_656 = _ctrlSignals_T_37 ? 3'h0 : _ctrlSignals_T_655; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_657 = _ctrlSignals_T_35 ? 3'h0 : _ctrlSignals_T_656; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_658 = _ctrlSignals_T_33 ? 3'h0 : _ctrlSignals_T_657; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_659 = _ctrlSignals_T_31 ? 3'h0 : _ctrlSignals_T_658; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_660 = _ctrlSignals_T_29 ? 3'h0 : _ctrlSignals_T_659; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_661 = _ctrlSignals_T_27 ? 3'h0 : _ctrlSignals_T_660; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_662 = _ctrlSignals_T_25 ? 3'h0 : _ctrlSignals_T_661; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_663 = _ctrlSignals_T_23 ? 3'h0 : _ctrlSignals_T_662; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_664 = _ctrlSignals_T_21 ? 3'h0 : _ctrlSignals_T_663; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_665 = _ctrlSignals_T_19 ? 3'h0 : _ctrlSignals_T_664; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_666 = _ctrlSignals_T_17 ? 3'h0 : _ctrlSignals_T_665; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_667 = _ctrlSignals_T_15 ? 3'h0 : _ctrlSignals_T_666; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_668 = _ctrlSignals_T_13 ? 3'h0 : _ctrlSignals_T_667; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_669 = _ctrlSignals_T_11 ? 3'h0 : _ctrlSignals_T_668; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_670 = _ctrlSignals_T_9 ? 3'h0 : _ctrlSignals_T_669; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_671 = _ctrlSignals_T_7 ? 3'h0 : _ctrlSignals_T_670; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_672 = _ctrlSignals_T_5 ? 3'h0 : _ctrlSignals_T_671; // @[Lookup.scala 34:39]
  wire [2:0] _ctrlSignals_T_673 = _ctrlSignals_T_3 ? 3'h0 : _ctrlSignals_T_672; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_674 = _ctrlSignals_T_97 ? 1'h0 : 1'h1; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_675 = _ctrlSignals_T_95 ? 1'h0 : _ctrlSignals_T_674; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_676 = _ctrlSignals_T_93 ? 1'h0 : _ctrlSignals_T_675; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_677 = _ctrlSignals_T_91 ? 1'h0 : _ctrlSignals_T_676; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_678 = _ctrlSignals_T_89 ? 1'h0 : _ctrlSignals_T_677; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_679 = _ctrlSignals_T_87 ? 1'h0 : _ctrlSignals_T_678; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_680 = _ctrlSignals_T_85 ? 1'h0 : _ctrlSignals_T_679; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_681 = _ctrlSignals_T_83 ? 1'h0 : _ctrlSignals_T_680; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_682 = _ctrlSignals_T_81 ? 1'h0 : _ctrlSignals_T_681; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_683 = _ctrlSignals_T_79 ? 1'h0 : _ctrlSignals_T_682; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_684 = _ctrlSignals_T_77 ? 1'h0 : _ctrlSignals_T_683; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_685 = _ctrlSignals_T_75 ? 1'h0 : _ctrlSignals_T_684; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_686 = _ctrlSignals_T_73 ? 1'h0 : _ctrlSignals_T_685; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_687 = _ctrlSignals_T_71 ? 1'h0 : _ctrlSignals_T_686; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_688 = _ctrlSignals_T_69 ? 1'h0 : _ctrlSignals_T_687; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_689 = _ctrlSignals_T_67 ? 1'h0 : _ctrlSignals_T_688; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_690 = _ctrlSignals_T_65 ? 1'h0 : _ctrlSignals_T_689; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_691 = _ctrlSignals_T_63 ? 1'h0 : _ctrlSignals_T_690; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_692 = _ctrlSignals_T_61 ? 1'h0 : _ctrlSignals_T_691; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_693 = _ctrlSignals_T_59 ? 1'h0 : _ctrlSignals_T_692; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_694 = _ctrlSignals_T_57 ? 1'h0 : _ctrlSignals_T_693; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_695 = _ctrlSignals_T_55 ? 1'h0 : _ctrlSignals_T_694; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_696 = _ctrlSignals_T_53 ? 1'h0 : _ctrlSignals_T_695; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_697 = _ctrlSignals_T_51 ? 1'h0 : _ctrlSignals_T_696; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_698 = _ctrlSignals_T_49 ? 1'h0 : _ctrlSignals_T_697; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_699 = _ctrlSignals_T_47 ? 1'h0 : _ctrlSignals_T_698; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_700 = _ctrlSignals_T_45 ? 1'h0 : _ctrlSignals_T_699; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_701 = _ctrlSignals_T_43 ? 1'h0 : _ctrlSignals_T_700; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_702 = _ctrlSignals_T_41 ? 1'h0 : _ctrlSignals_T_701; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_703 = _ctrlSignals_T_39 ? 1'h0 : _ctrlSignals_T_702; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_704 = _ctrlSignals_T_37 ? 1'h0 : _ctrlSignals_T_703; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_705 = _ctrlSignals_T_35 ? 1'h0 : _ctrlSignals_T_704; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_706 = _ctrlSignals_T_33 ? 1'h0 : _ctrlSignals_T_705; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_707 = _ctrlSignals_T_31 ? 1'h0 : _ctrlSignals_T_706; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_708 = _ctrlSignals_T_29 ? 1'h0 : _ctrlSignals_T_707; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_709 = _ctrlSignals_T_27 ? 1'h0 : _ctrlSignals_T_708; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_710 = _ctrlSignals_T_25 ? 1'h0 : _ctrlSignals_T_709; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_711 = _ctrlSignals_T_23 ? 1'h0 : _ctrlSignals_T_710; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_712 = _ctrlSignals_T_21 ? 1'h0 : _ctrlSignals_T_711; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_713 = _ctrlSignals_T_19 ? 1'h0 : _ctrlSignals_T_712; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_714 = _ctrlSignals_T_17 ? 1'h0 : _ctrlSignals_T_713; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_715 = _ctrlSignals_T_15 ? 1'h0 : _ctrlSignals_T_714; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_716 = _ctrlSignals_T_13 ? 1'h0 : _ctrlSignals_T_715; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_717 = _ctrlSignals_T_11 ? 1'h0 : _ctrlSignals_T_716; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_718 = _ctrlSignals_T_9 ? 1'h0 : _ctrlSignals_T_717; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_719 = _ctrlSignals_T_7 ? 1'h0 : _ctrlSignals_T_718; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_720 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_719; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_721 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_720; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_763 = _ctrlSignals_T_15 | (_ctrlSignals_T_17 | (_ctrlSignals_T_19 | (_ctrlSignals_T_21 | (
    _ctrlSignals_T_23 | (_ctrlSignals_T_25 | (_ctrlSignals_T_27 | (_ctrlSignals_T_29 | (_ctrlSignals_T_31 | (
    _ctrlSignals_T_33 | (_ctrlSignals_T_35 | (_ctrlSignals_T_37 | (_ctrlSignals_T_39 | (_ctrlSignals_T_41 | (
    _ctrlSignals_T_43 | (_ctrlSignals_T_45 | (_ctrlSignals_T_47 | (_ctrlSignals_T_49 | (_ctrlSignals_T_51 | (
    _ctrlSignals_T_53 | (_ctrlSignals_T_55 | (_ctrlSignals_T_57 | (_ctrlSignals_T_59 | (_ctrlSignals_T_61 | (
    _ctrlSignals_T_63 | (_ctrlSignals_T_65 | (_ctrlSignals_T_67 | (_ctrlSignals_T_69 | (_ctrlSignals_T_71 | (
    _ctrlSignals_T_73 | _ctrlSignals_T_157))))))))))))))))))))))))))))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_768 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_7 | (_ctrlSignals_T_9 | (_ctrlSignals_T_11 | (
    _ctrlSignals_T_13 | _ctrlSignals_T_763))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_769 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_768; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_804 = _ctrlSignals_T_29 ? 1'h0 : _ctrlSignals_T_31 | (_ctrlSignals_T_33 | (_ctrlSignals_T_35 |
    _ctrlSignals_T_224)); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_805 = _ctrlSignals_T_27 ? 1'h0 : _ctrlSignals_T_804; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_806 = _ctrlSignals_T_25 ? 1'h0 : _ctrlSignals_T_805; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_807 = _ctrlSignals_T_23 ? 1'h0 : _ctrlSignals_T_806; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_808 = _ctrlSignals_T_21 ? 1'h0 : _ctrlSignals_T_807; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_815 = _ctrlSignals_T_7 ? 1'h0 : _ctrlSignals_T_9 | (_ctrlSignals_T_11 | (_ctrlSignals_T_13 | (
    _ctrlSignals_T_15 | (_ctrlSignals_T_17 | (_ctrlSignals_T_19 | _ctrlSignals_T_808))))); // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_816 = _ctrlSignals_T_5 ? 1'h0 : _ctrlSignals_T_815; // @[Lookup.scala 34:39]
  wire  _ctrlSignals_T_817 = _ctrlSignals_T_3 ? 1'h0 : _ctrlSignals_T_816; // @[Lookup.scala 34:39]
  assign io_pc_sel = _ctrlSignals_T_1 ? 2'h0 : _ctrlSignals_T_145; // @[Lookup.scala 34:39]
  assign io_inst_kill = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_433; // @[Lookup.scala 34:39]
  assign io_a_sel = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_193; // @[Lookup.scala 34:39]
  assign io_b_sel = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_241; // @[Lookup.scala 34:39]
  assign io_imm_sel = _ctrlSignals_T_1 ? 3'h3 : _ctrlSignals_T_289; // @[Lookup.scala 34:39]
  assign io_alu_op = {{1'd0}, ctrlSignals_4}; // @[pipeline_control.scala 119:17]
  assign io_br_type = _ctrlSignals_T_1 ? 3'h0 : _ctrlSignals_T_385; // @[Lookup.scala 34:39]
  assign io_st_type = _ctrlSignals_T_1 ? 2'h0 : _ctrlSignals_T_481; // @[Lookup.scala 34:39]
  assign io_ld_type = _ctrlSignals_T_1 ? 3'h0 : _ctrlSignals_T_529; // @[Lookup.scala 34:39]
  assign io_wb_mux_sel = _ctrlSignals_T_1 ? 2'h0 : _ctrlSignals_T_577; // @[Lookup.scala 34:39]
  assign io_wb_en = _ctrlSignals_T_1 | (_ctrlSignals_T_3 | (_ctrlSignals_T_5 | (_ctrlSignals_T_7 | _ctrlSignals_T_622)))
    ; // @[Lookup.scala 34:39]
  assign io_csr_cmd = _ctrlSignals_T_1 ? 3'h0 : _ctrlSignals_T_673; // @[Lookup.scala 34:39]
  assign io_illegal = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_721; // @[Lookup.scala 34:39]
  assign io_en_rs1 = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_769; // @[Lookup.scala 34:39]
  assign io_en_rs2 = _ctrlSignals_T_1 ? 1'h0 : _ctrlSignals_T_817; // @[Lookup.scala 34:39]
endmodule
module Core(
  input         clock,
  input         reset,
  input         io_irq_uart_irq,
  input         io_irq_spi_irq,
  input         io_irq_m1_irq,
  input         io_irq_m2_irq,
  input         io_irq_m3_irq,
  output [31:0] io_ibus_addr,
  input  [31:0] io_ibus_inst,
  input         io_ibus_valid,
  output [31:0] io_dbus_addr,
  output [31:0] io_dbus_wdata,
  input  [31:0] io_dbus_rdata,
  output        io_dbus_rd_en,
  output        io_dbus_wr_en,
  output [1:0]  io_dbus_st_type,
  output [2:0]  io_dbus_ld_type,
  input         io_dbus_valid
);
  wire  dpath_clock; // @[core.scala 58:25]
  wire  dpath_reset; // @[core.scala 58:25]
  wire  dpath_io_irq_uart_irq; // @[core.scala 58:25]
  wire  dpath_io_irq_spi_irq; // @[core.scala 58:25]
  wire  dpath_io_irq_m1_irq; // @[core.scala 58:25]
  wire  dpath_io_irq_m2_irq; // @[core.scala 58:25]
  wire  dpath_io_irq_m3_irq; // @[core.scala 58:25]
  wire [31:0] dpath_io_ibus_addr; // @[core.scala 58:25]
  wire [31:0] dpath_io_ibus_inst; // @[core.scala 58:25]
  wire  dpath_io_ibus_valid; // @[core.scala 58:25]
  wire [31:0] dpath_io_dbus_addr; // @[core.scala 58:25]
  wire [31:0] dpath_io_dbus_wdata; // @[core.scala 58:25]
  wire [31:0] dpath_io_dbus_rdata; // @[core.scala 58:25]
  wire  dpath_io_dbus_rd_en; // @[core.scala 58:25]
  wire  dpath_io_dbus_wr_en; // @[core.scala 58:25]
  wire [1:0] dpath_io_dbus_st_type; // @[core.scala 58:25]
  wire [2:0] dpath_io_dbus_ld_type; // @[core.scala 58:25]
  wire  dpath_io_dbus_valid; // @[core.scala 58:25]
  wire [31:0] dpath_io_ctrl_inst; // @[core.scala 58:25]
  wire [1:0] dpath_io_ctrl_pc_sel; // @[core.scala 58:25]
  wire  dpath_io_ctrl_inst_kill; // @[core.scala 58:25]
  wire  dpath_io_ctrl_a_sel; // @[core.scala 58:25]
  wire  dpath_io_ctrl_b_sel; // @[core.scala 58:25]
  wire [2:0] dpath_io_ctrl_imm_sel; // @[core.scala 58:25]
  wire [4:0] dpath_io_ctrl_alu_op; // @[core.scala 58:25]
  wire [2:0] dpath_io_ctrl_br_type; // @[core.scala 58:25]
  wire [1:0] dpath_io_ctrl_st_type; // @[core.scala 58:25]
  wire [2:0] dpath_io_ctrl_ld_type; // @[core.scala 58:25]
  wire [1:0] dpath_io_ctrl_wb_mux_sel; // @[core.scala 58:25]
  wire  dpath_io_ctrl_wb_en; // @[core.scala 58:25]
  wire [2:0] dpath_io_ctrl_csr_cmd; // @[core.scala 58:25]
  wire  dpath_io_ctrl_illegal; // @[core.scala 58:25]
  wire  dpath_io_ctrl_en_rs1; // @[core.scala 58:25]
  wire  dpath_io_ctrl_en_rs2; // @[core.scala 58:25]
  wire [31:0] ctrl_io_inst; // @[core.scala 59:25]
  wire [1:0] ctrl_io_pc_sel; // @[core.scala 59:25]
  wire  ctrl_io_inst_kill; // @[core.scala 59:25]
  wire  ctrl_io_a_sel; // @[core.scala 59:25]
  wire  ctrl_io_b_sel; // @[core.scala 59:25]
  wire [2:0] ctrl_io_imm_sel; // @[core.scala 59:25]
  wire [4:0] ctrl_io_alu_op; // @[core.scala 59:25]
  wire [2:0] ctrl_io_br_type; // @[core.scala 59:25]
  wire [1:0] ctrl_io_st_type; // @[core.scala 59:25]
  wire [2:0] ctrl_io_ld_type; // @[core.scala 59:25]
  wire [1:0] ctrl_io_wb_mux_sel; // @[core.scala 59:25]
  wire  ctrl_io_wb_en; // @[core.scala 59:25]
  wire [2:0] ctrl_io_csr_cmd; // @[core.scala 59:25]
  wire  ctrl_io_illegal; // @[core.scala 59:25]
  wire  ctrl_io_en_rs1; // @[core.scala 59:25]
  wire  ctrl_io_en_rs2; // @[core.scala 59:25]
  Datapath dpath ( // @[core.scala 58:25]
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
  Control ctrl ( // @[core.scala 59:25]
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
  assign io_ibus_addr = dpath_io_ibus_addr; // @[core.scala 64:17]
  assign io_dbus_addr = dpath_io_dbus_addr; // @[core.scala 65:17]
  assign io_dbus_wdata = dpath_io_dbus_wdata; // @[core.scala 65:17]
  assign io_dbus_rd_en = dpath_io_dbus_rd_en; // @[core.scala 65:17]
  assign io_dbus_wr_en = dpath_io_dbus_wr_en; // @[core.scala 65:17]
  assign io_dbus_st_type = dpath_io_dbus_st_type; // @[core.scala 65:17]
  assign io_dbus_ld_type = dpath_io_dbus_ld_type; // @[core.scala 65:17]
  assign dpath_clock = clock;
  assign dpath_reset = reset;
  assign dpath_io_irq_uart_irq = io_irq_uart_irq; // @[core.scala 63:17]
  assign dpath_io_irq_spi_irq = io_irq_spi_irq; // @[core.scala 63:17]
  assign dpath_io_irq_m1_irq = io_irq_m1_irq; // @[core.scala 63:17]
  assign dpath_io_irq_m2_irq = io_irq_m2_irq; // @[core.scala 63:17]
  assign dpath_io_irq_m3_irq = io_irq_m3_irq; // @[core.scala 63:17]
  assign dpath_io_ibus_inst = io_ibus_inst; // @[core.scala 64:17]
  assign dpath_io_ibus_valid = io_ibus_valid; // @[core.scala 64:17]
  assign dpath_io_dbus_rdata = io_dbus_rdata; // @[core.scala 65:17]
  assign dpath_io_dbus_valid = io_dbus_valid; // @[core.scala 65:17]
  assign dpath_io_ctrl_pc_sel = ctrl_io_pc_sel; // @[core.scala 66:17]
  assign dpath_io_ctrl_inst_kill = ctrl_io_inst_kill; // @[core.scala 66:17]
  assign dpath_io_ctrl_a_sel = ctrl_io_a_sel; // @[core.scala 66:17]
  assign dpath_io_ctrl_b_sel = ctrl_io_b_sel; // @[core.scala 66:17]
  assign dpath_io_ctrl_imm_sel = ctrl_io_imm_sel; // @[core.scala 66:17]
  assign dpath_io_ctrl_alu_op = ctrl_io_alu_op; // @[core.scala 66:17]
  assign dpath_io_ctrl_br_type = ctrl_io_br_type; // @[core.scala 66:17]
  assign dpath_io_ctrl_st_type = ctrl_io_st_type; // @[core.scala 66:17]
  assign dpath_io_ctrl_ld_type = ctrl_io_ld_type; // @[core.scala 66:17]
  assign dpath_io_ctrl_wb_mux_sel = ctrl_io_wb_mux_sel; // @[core.scala 66:17]
  assign dpath_io_ctrl_wb_en = ctrl_io_wb_en; // @[core.scala 66:17]
  assign dpath_io_ctrl_csr_cmd = ctrl_io_csr_cmd; // @[core.scala 66:17]
  assign dpath_io_ctrl_illegal = ctrl_io_illegal; // @[core.scala 66:17]
  assign dpath_io_ctrl_en_rs1 = ctrl_io_en_rs1; // @[core.scala 66:17]
  assign dpath_io_ctrl_en_rs2 = ctrl_io_en_rs2; // @[core.scala 66:17]
  assign ctrl_io_inst = dpath_io_ctrl_inst; // @[core.scala 66:17]
endmodule
module DMem_Interface(
  input   clock,
  input   reset,
  input   io_wbs_m2s_stb,
  output  io_wbs_ack_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  ack2; // @[dmem_interface.scala 48:28]
  wire  dmem_res_en = ack2 ^ io_wbs_m2s_stb; // @[dmem_interface.scala 49:49]
  reg  ack; // @[dmem_interface.scala 55:28]
  assign io_wbs_ack_o = ack | ack2; // @[dmem_interface.scala 57:25]
  always @(posedge clock) begin
    if (reset) begin // @[dmem_interface.scala 48:28]
      ack2 <= 1'h0; // @[dmem_interface.scala 48:28]
    end else if (dmem_res_en) begin // @[dmem_interface.scala 51:21]
      ack2 <= io_wbs_m2s_stb; // @[dmem_interface.scala 52:10]
    end
    if (reset) begin // @[dmem_interface.scala 55:28]
      ack <= 1'h0; // @[dmem_interface.scala 55:28]
    end else begin
      ack <= io_wbs_m2s_stb; // @[dmem_interface.scala 56:18]
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ack2 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  ack = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IMem( // @[:@2003.2]
  input         clock, // @[:@2004.4]
  input  [31:0] io_imem_addr, // @[:@2006.4]
  output [31:0] io_imem_rdata, // @[:@2006.4]
  input  [31:0] io_imem_wdata, // @[:@2006.4]
  input         io_wr_en // @[:@2006.4]
);
  // reg [31:0] imem [0:2047]; // @[memory.scala 32:25:@2008.4]
  wire [11:0] inst_address;
  
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
  // assign imem__T_24_data = imem[imem__T_24_addr]; // @[memory.scala 32:25:@2008.4]
  assign imem__T_20_data = io_imem_wdata;
  assign imem__T_20_addr = _T_18[10:0];
  assign imem__T_20_mask = 1'h1;
  assign imem__T_20_en = io_wr_en;
  assign _T_18 = io_imem_addr / 32'h4; // @[memory.scala 43:23:@2010.6]
  assign _T_19 = _T_18[10:0]; // @[memory.scala 43:9:@2011.6]
  assign _GEN_3 = 1'h1; // @[memory.scala 42:19:@2009.4]
  assign io_imem_rdata = imem__T_24_data; // @[memory.scala 61:17:@2018.4]

  assign inst_address = io_imem_addr/4;                                                 // ADDRESS INDEX CHANGED
  instr_mem IM(inst_address, clock,io_wr_en, reset, io_imem_rdata );
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
    // if(imem__T_20_en & imem__T_20_mask) begin
    //   imem[imem__T_20_addr] <= imem__T_20_data; // @[memory.scala 32:25:@2008.4]
    // end
    if (_GEN_3) begin
      imem__T_24_addr_pipe_0 <= _T_19;
    end
  end
endmodule
module BMem(
  input         clock,
  input         reset,
  input  [31:0] io_bmem_addr,
  output [31:0] io_bmem_rdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [9:0] addr = io_bmem_addr[9:0] / 3'h4; // @[bmem.scala 24:33]
  reg [31:0] bmem_data; // @[bmem.scala 25:26]
  wire [31:0] _GEN_0 = 10'hd9 == addr ? 32'h8067 : bmem_data; // @[bmem.scala 27:17 245:26 25:26]
  wire [31:0] _GEN_1 = 10'hd8 == addr ? 32'h3010113 : _GEN_0; // @[bmem.scala 27:17 244:26]
  wire [31:0] _GEN_2 = 10'hd7 == addr ? 32'h2812403 : _GEN_1; // @[bmem.scala 27:17 243:26]
  wire [31:0] _GEN_3 = 10'hd6 == addr ? 32'h2c12083 : _GEN_2; // @[bmem.scala 27:17 242:26]
  wire [31:0] _GEN_4 = 10'hd5 == addr ? 32'h13 : _GEN_3; // @[bmem.scala 27:17 241:26]
  wire [31:0] _GEN_5 = 10'hd4 == addr ? 32'hfc07dce3 : _GEN_4; // @[bmem.scala 27:17 240:26]
  wire [31:0] _GEN_6 = 10'hd3 == addr ? 32'hfec42783 : _GEN_5; // @[bmem.scala 27:17 239:26]
  wire [31:0] _GEN_7 = 10'hd2 == addr ? 32'hfef42623 : _GEN_6; // @[bmem.scala 27:17 238:26]
  wire [31:0] _GEN_8 = 10'hd1 == addr ? 32'hfff78793 : _GEN_7; // @[bmem.scala 27:17 237:26]
  wire [31:0] _GEN_9 = 10'hd0 == addr ? 32'hfec42783 : _GEN_8; // @[bmem.scala 27:17 236:26]
  wire [31:0] _GEN_10 = 10'hcf == addr ? 32'hd9dff0ef : _GEN_9; // @[bmem.scala 27:17 235:26]
  wire [31:0] _GEN_11 = 10'hce == addr ? 32'h78513 : _GEN_10; // @[bmem.scala 27:17 234:26]
  wire [31:0] _GEN_12 = 10'hcd == addr ? 32'hff87c783 : _GEN_11; // @[bmem.scala 27:17 233:26]
  wire [31:0] _GEN_13 = 10'hcc == addr ? 32'hf707b3 : _GEN_12; // @[bmem.scala 27:17 232:26]
  wire [31:0] _GEN_14 = 10'hcb == addr ? 32'hff040713 : _GEN_13; // @[bmem.scala 27:17 231:26]
  wire [31:0] _GEN_15 = 10'hca == addr ? 32'hfec42783 : _GEN_14; // @[bmem.scala 27:17 230:26]
  wire [31:0] _GEN_16 = 10'hc9 == addr ? 32'h280006f : _GEN_15; // @[bmem.scala 27:17 229:26]
  wire [31:0] _GEN_17 = 10'hc8 == addr ? 32'hfef42623 : _GEN_16; // @[bmem.scala 27:17 228:26]
  wire [31:0] _GEN_18 = 10'hc7 == addr ? 32'h200793 : _GEN_17; // @[bmem.scala 27:17 227:26]
  wire [31:0] _GEN_19 = 10'hc6 == addr ? 32'hfef42423 : _GEN_18; // @[bmem.scala 27:17 226:26]
  wire [31:0] _GEN_20 = 10'hc5 == addr ? 32'hfdc42783 : _GEN_19; // @[bmem.scala 27:17 225:26]
  wire [31:0] _GEN_21 = 10'hc4 == addr ? 32'hfca42e23 : _GEN_20; // @[bmem.scala 27:17 224:26]
  wire [31:0] _GEN_22 = 10'hc3 == addr ? 32'h3010413 : _GEN_21; // @[bmem.scala 27:17 223:26]
  wire [31:0] _GEN_23 = 10'hc2 == addr ? 32'h2812423 : _GEN_22; // @[bmem.scala 27:17 222:26]
  wire [31:0] _GEN_24 = 10'hc1 == addr ? 32'h2112623 : _GEN_23; // @[bmem.scala 27:17 221:26]
  wire [31:0] _GEN_25 = 10'hc0 == addr ? 32'hfd010113 : _GEN_24; // @[bmem.scala 27:17 220:26]
  wire [31:0] _GEN_26 = 10'hbf == addr ? 32'h8067 : _GEN_25; // @[bmem.scala 27:17 219:26]
  wire [31:0] _GEN_27 = 10'hbe == addr ? 32'h3010113 : _GEN_26; // @[bmem.scala 27:17 218:26]
  wire [31:0] _GEN_28 = 10'hbd == addr ? 32'h2812403 : _GEN_27; // @[bmem.scala 27:17 217:26]
  wire [31:0] _GEN_29 = 10'hbc == addr ? 32'h2c12083 : _GEN_28; // @[bmem.scala 27:17 216:26]
  wire [31:0] _GEN_30 = 10'hbb == addr ? 32'h78513 : _GEN_29; // @[bmem.scala 27:17 215:26]
  wire [31:0] _GEN_31 = 10'hba == addr ? 32'hfe842783 : _GEN_30; // @[bmem.scala 27:17 214:26]
  wire [31:0] _GEN_32 = 10'hb9 == addr ? 32'he782a3 : _GEN_31; // @[bmem.scala 27:17 213:26]
  wire [31:0] _GEN_33 = 10'hb8 == addr ? 32'hff77713 : _GEN_32; // @[bmem.scala 27:17 212:26]
  wire [31:0] _GEN_34 = 10'hb7 == addr ? 32'hffe77713 : _GEN_33; // @[bmem.scala 27:17 211:26]
  wire [31:0] _GEN_35 = 10'hb6 == addr ? 32'h37b7 : _GEN_34; // @[bmem.scala 27:17 210:26]
  wire [31:0] _GEN_36 = 10'hb5 == addr ? 32'hff7f713 : _GEN_35; // @[bmem.scala 27:17 209:26]
  wire [31:0] _GEN_37 = 10'hb4 == addr ? 32'h57c783 : _GEN_36; // @[bmem.scala 27:17 208:26]
  wire [31:0] _GEN_38 = 10'hb3 == addr ? 32'h37b7 : _GEN_37; // @[bmem.scala 27:17 207:26]
  wire [31:0] _GEN_39 = 10'hb2 == addr ? 32'hfce7f6e3 : _GEN_38; // @[bmem.scala 27:17 206:26]
  wire [31:0] _GEN_40 = 10'hb1 == addr ? 32'h300793 : _GEN_39; // @[bmem.scala 27:17 205:26]
  wire [31:0] _GEN_41 = 10'hb0 == addr ? 32'hfec42703 : _GEN_40; // @[bmem.scala 27:17 204:26]
  wire [31:0] _GEN_42 = 10'haf == addr ? 32'hfef42623 : _GEN_41; // @[bmem.scala 27:17 203:26]
  wire [31:0] _GEN_43 = 10'hae == addr ? 32'h178793 : _GEN_42; // @[bmem.scala 27:17 202:26]
  wire [31:0] _GEN_44 = 10'had == addr ? 32'hfec42783 : _GEN_43; // @[bmem.scala 27:17 201:26]
  wire [31:0] _GEN_45 = 10'hac == addr ? 32'hfee78c23 : _GEN_44; // @[bmem.scala 27:17 200:26]
  wire [31:0] _GEN_46 = 10'hab == addr ? 32'hf687b3 : _GEN_45; // @[bmem.scala 27:17 199:26]
  wire [31:0] _GEN_47 = 10'haa == addr ? 32'hff040693 : _GEN_46; // @[bmem.scala 27:17 198:26]
  wire [31:0] _GEN_48 = 10'ha9 == addr ? 32'hfec42783 : _GEN_47; // @[bmem.scala 27:17 197:26]
  wire [31:0] _GEN_49 = 10'ha8 == addr ? 32'h78713 : _GEN_48; // @[bmem.scala 27:17 196:26]
  wire [31:0] _GEN_50 = 10'ha7 == addr ? 32'h50793 : _GEN_49; // @[bmem.scala 27:17 195:26]
  wire [31:0] _GEN_51 = 10'ha6 == addr ? 32'he41ff0ef : _GEN_50; // @[bmem.scala 27:17 194:26]
  wire [31:0] _GEN_52 = 10'ha5 == addr ? 32'h513 : _GEN_51; // @[bmem.scala 27:17 193:26]
  wire [31:0] _GEN_53 = 10'ha4 == addr ? 32'h300006f : _GEN_52; // @[bmem.scala 27:17 192:26]
  wire [31:0] _GEN_54 = 10'ha3 == addr ? 32'hfe042623 : _GEN_53; // @[bmem.scala 27:17 191:26]
  wire [31:0] _GEN_55 = 10'ha2 == addr ? 32'h78000ef : _GEN_54; // @[bmem.scala 27:17 190:26]
  wire [31:0] _GEN_56 = 10'ha1 == addr ? 32'hfdc42503 : _GEN_55; // @[bmem.scala 27:17 189:26]
  wire [31:0] _GEN_57 = 10'ha0 == addr ? 32'he59ff0ef : _GEN_56; // @[bmem.scala 27:17 188:26]
  wire [31:0] _GEN_58 = 10'h9f == addr ? 32'h300513 : _GEN_57; // @[bmem.scala 27:17 187:26]
  wire [31:0] _GEN_59 = 10'h9e == addr ? 32'he782a3 : _GEN_58; // @[bmem.scala 27:17 186:26]
  wire [31:0] _GEN_60 = 10'h9d == addr ? 32'hff77713 : _GEN_59; // @[bmem.scala 27:17 185:26]
  wire [31:0] _GEN_61 = 10'h9c == addr ? 32'h176713 : _GEN_60; // @[bmem.scala 27:17 184:26]
  wire [31:0] _GEN_62 = 10'h9b == addr ? 32'h37b7 : _GEN_61; // @[bmem.scala 27:17 183:26]
  wire [31:0] _GEN_63 = 10'h9a == addr ? 32'hff7f713 : _GEN_62; // @[bmem.scala 27:17 182:26]
  wire [31:0] _GEN_64 = 10'h99 == addr ? 32'h57c783 : _GEN_63; // @[bmem.scala 27:17 181:26]
  wire [31:0] _GEN_65 = 10'h98 == addr ? 32'h37b7 : _GEN_64; // @[bmem.scala 27:17 180:26]
  wire [31:0] _GEN_66 = 10'h97 == addr ? 32'hfca42e23 : _GEN_65; // @[bmem.scala 27:17 179:26]
  wire [31:0] _GEN_67 = 10'h96 == addr ? 32'h3010413 : _GEN_66; // @[bmem.scala 27:17 178:26]
  wire [31:0] _GEN_68 = 10'h95 == addr ? 32'h2812423 : _GEN_67; // @[bmem.scala 27:17 177:26]
  wire [31:0] _GEN_69 = 10'h94 == addr ? 32'h2112623 : _GEN_68; // @[bmem.scala 27:17 176:26]
  wire [31:0] _GEN_70 = 10'h93 == addr ? 32'hfd010113 : _GEN_69; // @[bmem.scala 27:17 175:26]
  wire [31:0] _GEN_71 = 10'h92 == addr ? 32'h8067 : _GEN_70; // @[bmem.scala 27:17 174:26]
  wire [31:0] _GEN_72 = 10'h91 == addr ? 32'h3010113 : _GEN_71; // @[bmem.scala 27:17 173:26]
  wire [31:0] _GEN_73 = 10'h90 == addr ? 32'h2812403 : _GEN_72; // @[bmem.scala 27:17 172:26]
  wire [31:0] _GEN_74 = 10'h8f == addr ? 32'h2c12083 : _GEN_73; // @[bmem.scala 27:17 171:26]
  wire [31:0] _GEN_75 = 10'h8e == addr ? 32'h13 : _GEN_74; // @[bmem.scala 27:17 170:26]
  wire [31:0] _GEN_76 = 10'h8d == addr ? 32'hfaf76ee3 : _GEN_75; // @[bmem.scala 27:17 169:26]
  wire [31:0] _GEN_77 = 10'h8c == addr ? 32'hfe842703 : _GEN_76; // @[bmem.scala 27:17 168:26]
  wire [31:0] _GEN_78 = 10'h8b == addr ? 32'h27d793 : _GEN_77; // @[bmem.scala 27:17 167:26]
  wire [31:0] _GEN_79 = 10'h8a == addr ? 32'hfd842783 : _GEN_78; // @[bmem.scala 27:17 166:26]
  wire [31:0] _GEN_80 = 10'h89 == addr ? 32'hfef42623 : _GEN_79; // @[bmem.scala 27:17 165:26]
  wire [31:0] _GEN_81 = 10'h88 == addr ? 32'h478793 : _GEN_80; // @[bmem.scala 27:17 164:26]
  wire [31:0] _GEN_82 = 10'h87 == addr ? 32'hfec42783 : _GEN_81; // @[bmem.scala 27:17 163:26]
  wire [31:0] _GEN_83 = 10'h86 == addr ? 32'he7a023 : _GEN_82; // @[bmem.scala 27:17 162:26]
  wire [31:0] _GEN_84 = 10'h85 == addr ? 32'hfe042703 : _GEN_83; // @[bmem.scala 27:17 161:26]
  wire [31:0] _GEN_85 = 10'h84 == addr ? 32'hf707b3 : _GEN_84; // @[bmem.scala 27:17 160:26]
  wire [31:0] _GEN_86 = 10'h83 == addr ? 32'hfe442703 : _GEN_85; // @[bmem.scala 27:17 159:26]
  wire [31:0] _GEN_87 = 10'h82 == addr ? 32'h279793 : _GEN_86; // @[bmem.scala 27:17 158:26]
  wire [31:0] _GEN_88 = 10'h81 == addr ? 32'hfee42423 : _GEN_87; // @[bmem.scala 27:17 157:26]
  wire [31:0] _GEN_89 = 10'h80 == addr ? 32'h178713 : _GEN_88; // @[bmem.scala 27:17 156:26]
  wire [31:0] _GEN_90 = 10'h7f == addr ? 32'hfe842783 : _GEN_89; // @[bmem.scala 27:17 155:26]
  wire [31:0] _GEN_91 = 10'h7e == addr ? 32'hfea42023 : _GEN_90; // @[bmem.scala 27:17 154:26]
  wire [31:0] _GEN_92 = 10'h7d == addr ? 32'h58000ef : _GEN_91; // @[bmem.scala 27:17 153:26]
  wire [31:0] _GEN_93 = 10'h7c == addr ? 32'hfec42503 : _GEN_92; // @[bmem.scala 27:17 152:26]
  wire [31:0] _GEN_94 = 10'h7b == addr ? 32'h3c0006f : _GEN_93; // @[bmem.scala 27:17 151:26]
  wire [31:0] _GEN_95 = 10'h7a == addr ? 32'hfef42623 : _GEN_94; // @[bmem.scala 27:17 150:26]
  wire [31:0] _GEN_96 = 10'h79 == addr ? 32'h878793 : _GEN_95; // @[bmem.scala 27:17 149:26]
  wire [31:0] _GEN_97 = 10'h78 == addr ? 32'hfec42783 : _GEN_96; // @[bmem.scala 27:17 148:26]
  wire [31:0] _GEN_98 = 10'h77 == addr ? 32'hfca42c23 : _GEN_97; // @[bmem.scala 27:17 147:26]
  wire [31:0] _GEN_99 = 10'h76 == addr ? 32'h74000ef : _GEN_98; // @[bmem.scala 27:17 146:26]
  wire [31:0] _GEN_100 = 10'h75 == addr ? 32'h78513 : _GEN_99; // @[bmem.scala 27:17 145:26]
  wire [31:0] _GEN_101 = 10'h74 == addr ? 32'h478793 : _GEN_100; // @[bmem.scala 27:17 144:26]
  wire [31:0] _GEN_102 = 10'h73 == addr ? 32'hfec42783 : _GEN_101; // @[bmem.scala 27:17 143:26]
  wire [31:0] _GEN_103 = 10'h72 == addr ? 32'hfca42e23 : _GEN_102; // @[bmem.scala 27:17 142:26]
  wire [31:0] _GEN_104 = 10'h71 == addr ? 32'h88000ef : _GEN_103; // @[bmem.scala 27:17 141:26]
  wire [31:0] _GEN_105 = 10'h70 == addr ? 32'hfec42503 : _GEN_104; // @[bmem.scala 27:17 140:26]
  wire [31:0] _GEN_106 = 10'h6f == addr ? 32'hfe042423 : _GEN_105; // @[bmem.scala 27:17 139:26]
  wire [31:0] _GEN_107 = 10'h6e == addr ? 32'hfe042023 : _GEN_106; // @[bmem.scala 27:17 138:26]
  wire [31:0] _GEN_108 = 10'h6d == addr ? 32'hfe042223 : _GEN_107; // @[bmem.scala 27:17 137:26]
  wire [31:0] _GEN_109 = 10'h6c == addr ? 32'hfe042623 : _GEN_108; // @[bmem.scala 27:17 136:26]
  wire [31:0] _GEN_110 = 10'h6b == addr ? 32'h3010413 : _GEN_109; // @[bmem.scala 27:17 135:26]
  wire [31:0] _GEN_111 = 10'h6a == addr ? 32'h2812423 : _GEN_110; // @[bmem.scala 27:17 134:26]
  wire [31:0] _GEN_112 = 10'h69 == addr ? 32'h2112623 : _GEN_111; // @[bmem.scala 27:17 133:26]
  wire [31:0] _GEN_113 = 10'h68 == addr ? 32'hfd010113 : _GEN_112; // @[bmem.scala 27:17 132:26]
  wire [31:0] _GEN_114 = 10'h67 == addr ? 32'h8067 : _GEN_113; // @[bmem.scala 27:17 131:26]
  wire [31:0] _GEN_115 = 10'h66 == addr ? 32'h1010113 : _GEN_114; // @[bmem.scala 27:17 130:26]
  wire [31:0] _GEN_116 = 10'h65 == addr ? 32'hc12403 : _GEN_115; // @[bmem.scala 27:17 129:26]
  wire [31:0] _GEN_117 = 10'h64 == addr ? 32'h13 : _GEN_116; // @[bmem.scala 27:17 128:26]
  wire [31:0] _GEN_118 = 10'h63 == addr ? 32'h28067 : _GEN_117; // @[bmem.scala 27:17 127:25]
  wire [31:0] _GEN_119 = 10'h62 == addr ? 32'h2b7 : _GEN_118; // @[bmem.scala 27:17 126:25]
  wire [31:0] _GEN_120 = 10'h61 == addr ? 32'h1010413 : _GEN_119; // @[bmem.scala 27:17 125:25]
  wire [31:0] _GEN_121 = 10'h60 == addr ? 32'h812623 : _GEN_120; // @[bmem.scala 27:17 124:25]
  wire [31:0] _GEN_122 = 10'h5f == addr ? 32'hff010113 : _GEN_121; // @[bmem.scala 27:17 123:25]
  wire [31:0] _GEN_123 = 10'h5e == addr ? 32'h8067 : _GEN_122; // @[bmem.scala 27:17 122:25]
  wire [31:0] _GEN_124 = 10'h5d == addr ? 32'h1010113 : _GEN_123; // @[bmem.scala 27:17 121:25]
  wire [31:0] _GEN_125 = 10'h5c == addr ? 32'h812403 : _GEN_124; // @[bmem.scala 27:17 120:25]
  wire [31:0] _GEN_126 = 10'h5b == addr ? 32'hc12083 : _GEN_125; // @[bmem.scala 27:17 119:25]
  wire [31:0] _GEN_127 = 10'h5a == addr ? 32'h78513 : _GEN_126; // @[bmem.scala 27:17 118:25]
  wire [31:0] _GEN_128 = 10'h59 == addr ? 32'h793 : _GEN_127; // @[bmem.scala 27:17 117:25]
  wire [31:0] _GEN_129 = 10'h58 == addr ? 32'h1c000ef : _GEN_128; // @[bmem.scala 27:17 116:25]
  wire [31:0] _GEN_130 = 10'h57 == addr ? 32'hef1ff0ef : _GEN_129; // @[bmem.scala 27:17 115:25]
  wire [31:0] _GEN_131 = 10'h56 == addr ? 32'h6b00513 : _GEN_130; // @[bmem.scala 27:17 114:25]
  wire [31:0] _GEN_132 = 10'h55 == addr ? 32'hef9ff0ef : _GEN_131; // @[bmem.scala 27:17 113:25]
  wire [31:0] _GEN_133 = 10'h54 == addr ? 32'h4f00513 : _GEN_132; // @[bmem.scala 27:17 112:25]
  wire [31:0] _GEN_134 = 10'h53 == addr ? 32'h54000ef : _GEN_133; // @[bmem.scala 27:17 111:25]
  wire [31:0] _GEN_135 = 10'h52 == addr ? 32'hf4dff0ef : _GEN_134; // @[bmem.scala 27:17 110:25]
  wire [31:0] _GEN_136 = 10'h51 == addr ? 32'h800513 : _GEN_135; // @[bmem.scala 27:17 109:25]
  wire [31:0] _GEN_137 = 10'h50 == addr ? 32'heddff0ef : _GEN_136; // @[bmem.scala 27:17 108:25]
  wire [31:0] _GEN_138 = 10'h4f == addr ? 32'h1000513 : _GEN_137; // @[bmem.scala 27:17 107:25]
  wire [31:0] _GEN_139 = 10'h4e == addr ? 32'h1010413 : _GEN_138; // @[bmem.scala 27:17 106:25]
  wire [31:0] _GEN_140 = 10'h4d == addr ? 32'h812423 : _GEN_139; // @[bmem.scala 27:17 105:25]
  wire [31:0] _GEN_141 = 10'h4c == addr ? 32'h112623 : _GEN_140; // @[bmem.scala 27:17 104:25]
  wire [31:0] _GEN_142 = 10'h4b == addr ? 32'hff010113 : _GEN_141; // @[bmem.scala 27:17 103:25]
  wire [31:0] _GEN_143 = 10'h4a == addr ? 32'h8067 : _GEN_142; // @[bmem.scala 27:17 102:25]
  wire [31:0] _GEN_144 = 10'h49 == addr ? 32'h2010113 : _GEN_143; // @[bmem.scala 27:17 101:25]
  wire [31:0] _GEN_145 = 10'h48 == addr ? 32'h1c12403 : _GEN_144; // @[bmem.scala 27:17 100:25]
  wire [31:0] _GEN_146 = 10'h47 == addr ? 32'h78513 : _GEN_145; // @[bmem.scala 27:17 99:25]
  wire [31:0] _GEN_147 = 10'h46 == addr ? 32'hff7f793 : _GEN_146; // @[bmem.scala 27:17 98:25]
  wire [31:0] _GEN_148 = 10'h45 == addr ? 32'h7c783 : _GEN_147; // @[bmem.scala 27:17 97:25]
  wire [31:0] _GEN_149 = 10'h44 == addr ? 32'h37b7 : _GEN_148; // @[bmem.scala 27:17 96:25]
  wire [31:0] _GEN_150 = 10'h43 == addr ? 32'hfe0788e3 : _GEN_149; // @[bmem.scala 27:17 95:25]
  wire [31:0] _GEN_151 = 10'h42 == addr ? 32'h107f793 : _GEN_150; // @[bmem.scala 27:17 94:25]
  wire [31:0] _GEN_152 = 10'h41 == addr ? 32'hff7f793 : _GEN_151; // @[bmem.scala 27:17 93:25]
  wire [31:0] _GEN_153 = 10'h40 == addr ? 32'h47c783 : _GEN_152; // @[bmem.scala 27:17 92:25]
  wire [31:0] _GEN_154 = 10'h3f == addr ? 32'h37b7 : _GEN_153; // @[bmem.scala 27:17 91:25]
  wire [31:0] _GEN_155 = 10'h3e == addr ? 32'h13 : _GEN_154; // @[bmem.scala 27:17 90:25]
  wire [31:0] _GEN_156 = 10'h3d == addr ? 32'he780a3 : _GEN_155; // @[bmem.scala 27:17 89:25]
  wire [31:0] _GEN_157 = 10'h3c == addr ? 32'hfef44703 : _GEN_156; // @[bmem.scala 27:17 88:25]
  wire [31:0] _GEN_158 = 10'h3b == addr ? 32'h37b7 : _GEN_157; // @[bmem.scala 27:17 87:25]
  wire [31:0] _GEN_159 = 10'h3a == addr ? 32'hfef407a3 : _GEN_158; // @[bmem.scala 27:17 86:25]
  wire [31:0] _GEN_160 = 10'h39 == addr ? 32'h50793 : _GEN_159; // @[bmem.scala 27:17 85:25]
  wire [31:0] _GEN_161 = 10'h38 == addr ? 32'h2010413 : _GEN_160; // @[bmem.scala 27:17 84:25]
  wire [31:0] _GEN_162 = 10'h37 == addr ? 32'h812e23 : _GEN_161; // @[bmem.scala 27:17 83:25]
  wire [31:0] _GEN_163 = 10'h36 == addr ? 32'hfe010113 : _GEN_162; // @[bmem.scala 27:17 82:25]
  wire [31:0] _GEN_164 = 10'h35 == addr ? 32'h8067 : _GEN_163; // @[bmem.scala 27:17 81:25]
  wire [31:0] _GEN_165 = 10'h34 == addr ? 32'h2010113 : _GEN_164; // @[bmem.scala 27:17 80:25]
  wire [31:0] _GEN_166 = 10'h33 == addr ? 32'h1c12403 : _GEN_165; // @[bmem.scala 27:17 79:25]
  wire [31:0] _GEN_167 = 10'h32 == addr ? 32'h13 : _GEN_166; // @[bmem.scala 27:17 78:25]
  wire [31:0] _GEN_168 = 10'h31 == addr ? 32'he78123 : _GEN_167; // @[bmem.scala 27:17 77:25]
  wire [31:0] _GEN_169 = 10'h30 == addr ? 32'hff77713 : _GEN_168; // @[bmem.scala 27:17 76:25]
  wire [31:0] _GEN_170 = 10'h2f == addr ? 32'he6e733 : _GEN_169; // @[bmem.scala 27:17 75:25]
  wire [31:0] _GEN_171 = 10'h2e == addr ? 32'hfef44703 : _GEN_170; // @[bmem.scala 27:17 74:25]
  wire [31:0] _GEN_172 = 10'h2d == addr ? 32'h37b7 : _GEN_171; // @[bmem.scala 27:17 73:25]
  wire [31:0] _GEN_173 = 10'h2c == addr ? 32'hff7f693 : _GEN_172; // @[bmem.scala 27:17 72:25]
  wire [31:0] _GEN_174 = 10'h2b == addr ? 32'h27c783 : _GEN_173; // @[bmem.scala 27:17 71:25]
  wire [31:0] _GEN_175 = 10'h2a == addr ? 32'h37b7 : _GEN_174; // @[bmem.scala 27:17 70:25]
  wire [31:0] _GEN_176 = 10'h29 == addr ? 32'hfef407a3 : _GEN_175; // @[bmem.scala 27:17 69:25]
  wire [31:0] _GEN_177 = 10'h28 == addr ? 32'h50793 : _GEN_176; // @[bmem.scala 27:17 68:25]
  wire [31:0] _GEN_178 = 10'h27 == addr ? 32'h2010413 : _GEN_177; // @[bmem.scala 27:17 67:25]
  wire [31:0] _GEN_179 = 10'h26 == addr ? 32'h812e23 : _GEN_178; // @[bmem.scala 27:17 66:25]
  wire [31:0] _GEN_180 = 10'h25 == addr ? 32'hfe010113 : _GEN_179; // @[bmem.scala 27:17 65:25]
  wire [31:0] _GEN_181 = 10'h24 == addr ? 32'h8067 : _GEN_180; // @[bmem.scala 27:17 64:25]
  wire [31:0] _GEN_182 = 10'h23 == addr ? 32'h2010113 : _GEN_181; // @[bmem.scala 27:17 63:25]
  wire [31:0] _GEN_183 = 10'h22 == addr ? 32'h1c12403 : _GEN_182; // @[bmem.scala 27:17 62:25]
  wire [31:0] _GEN_184 = 10'h21 == addr ? 32'h13 : _GEN_183; // @[bmem.scala 27:17 61:25]
  wire [31:0] _GEN_185 = 10'h20 == addr ? 32'he780a3 : _GEN_184; // @[bmem.scala 27:17 60:25]
  wire [31:0] _GEN_186 = 10'h1f == addr ? 32'hfef44703 : _GEN_185; // @[bmem.scala 27:17 59:25]
  wire [31:0] _GEN_187 = 10'h1e == addr ? 32'h27b7 : _GEN_186; // @[bmem.scala 27:17 58:25]
  wire [31:0] _GEN_188 = 10'h1d == addr ? 32'hfe0788e3 : _GEN_187; // @[bmem.scala 27:17 57:25]
  wire [31:0] _GEN_189 = 10'h1c == addr ? 32'h27f793 : _GEN_188; // @[bmem.scala 27:17 56:25]
  wire [31:0] _GEN_190 = 10'h1b == addr ? 32'hff7f793 : _GEN_189; // @[bmem.scala 27:17 55:25]
  wire [31:0] _GEN_191 = 10'h1a == addr ? 32'h47c783 : _GEN_190; // @[bmem.scala 27:17 54:25]
  wire [31:0] _GEN_192 = 10'h19 == addr ? 32'h27b7 : _GEN_191; // @[bmem.scala 27:17 53:25]
  wire [31:0] _GEN_193 = 10'h18 == addr ? 32'h13 : _GEN_192; // @[bmem.scala 27:17 52:25]
  wire [31:0] _GEN_194 = 10'h17 == addr ? 32'hfef407a3 : _GEN_193; // @[bmem.scala 27:17 51:25]
  wire [31:0] _GEN_195 = 10'h16 == addr ? 32'h50793 : _GEN_194; // @[bmem.scala 27:17 50:25]
  wire [31:0] _GEN_196 = 10'h15 == addr ? 32'h2010413 : _GEN_195; // @[bmem.scala 27:17 49:25]
  wire [31:0] _GEN_197 = 10'h14 == addr ? 32'h812e23 : _GEN_196; // @[bmem.scala 27:17 48:25]
  wire [31:0] _GEN_198 = 10'h13 == addr ? 32'hfe010113 : _GEN_197; // @[bmem.scala 27:17 47:25]
  wire [31:0] _GEN_199 = 10'h12 == addr ? 32'h8067 : _GEN_198; // @[bmem.scala 27:17 46:25]
  wire [31:0] _GEN_200 = 10'h11 == addr ? 32'h2010113 : _GEN_199; // @[bmem.scala 27:17 45:25]
  wire [31:0] _GEN_201 = 10'h10 == addr ? 32'h1c12403 : _GEN_200; // @[bmem.scala 27:17 44:25]
  wire [31:0] _GEN_202 = 10'hf == addr ? 32'h13 : _GEN_201; // @[bmem.scala 27:17 43:25]
  wire [31:0] _GEN_203 = 10'he == addr ? 32'he78123 : _GEN_202; // @[bmem.scala 27:17 42:25]
  wire [31:0] _GEN_204 = 10'hd == addr ? 32'hfef44703 : _GEN_203; // @[bmem.scala 27:17 41:25]
  wire [31:0] _GEN_205 = 10'hc == addr ? 32'h27b7 : _GEN_204; // @[bmem.scala 27:17 40:25]
  wire [31:0] _GEN_206 = 10'hb == addr ? 32'hfef407a3 : _GEN_205; // @[bmem.scala 27:17 39:25]
  wire [31:0] _GEN_207 = 10'ha == addr ? 32'h50793 : _GEN_206; // @[bmem.scala 27:17 38:25]
  wire [31:0] _GEN_208 = 10'h9 == addr ? 32'h2010413 : _GEN_207; // @[bmem.scala 27:17 37:24]
  wire [31:0] _GEN_209 = 10'h8 == addr ? 32'h812e23 : _GEN_208; // @[bmem.scala 27:17 36:24]
  wire [31:0] _GEN_210 = 10'h7 == addr ? 32'hfe010113 : _GEN_209; // @[bmem.scala 27:17 35:24]
  wire [31:0] _GEN_211 = 10'h6 == addr ? 32'h114000ef : _GEN_210; // @[bmem.scala 27:17 34:24]
  wire [31:0] _GEN_212 = 10'h5 == addr ? 32'h593 : _GEN_211; // @[bmem.scala 27:17 33:24]
  wire [31:0] _GEN_213 = 10'h4 == addr ? 32'h513 : _GEN_212; // @[bmem.scala 27:17 32:24]
  wire [31:0] _GEN_214 = 10'h3 == addr ? 32'hf810113 : _GEN_213; // @[bmem.scala 27:17 31:24]
  assign io_bmem_rdata = bmem_data; // @[bmem.scala 248:17]
  always @(posedge clock) begin
    if (reset) begin // @[bmem.scala 25:26]
      bmem_data <= 32'h0; // @[bmem.scala 25:26]
    end else if (10'h0 == addr) begin // @[bmem.scala 27:17]
      bmem_data <= 32'h13; // @[bmem.scala 28:24]
    end else if (10'h1 == addr) begin // @[bmem.scala 27:17]
      bmem_data <= 32'h40006f; // @[bmem.scala 29:24]
    end else if (10'h2 == addr) begin // @[bmem.scala 27:17]
      bmem_data <= 32'hffffa117; // @[bmem.scala 30:24]
    end else begin
      bmem_data <= _GEN_214;
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  bmem_data = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IMem_Interface(
  input         clock,
  input         reset,
  input  [31:0] io_ibus_addr,
  output [31:0] io_ibus_inst,
  output        io_ibus_valid,
  input  [15:0] io_wbs_m2s_addr,
  input  [31:0] io_wbs_m2s_data,
  input         io_wbs_m2s_we,
  input  [3:0]  io_wbs_m2s_sel,
  input         io_wbs_m2s_stb,
  output        io_wbs_ack_o,
  output [31:0] io_wbs_data_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  imem_clock; // @[imem_interface.scala 40:20]
  wire [31:0] imem_io_imem_addr; // @[imem_interface.scala 40:20]
  wire [31:0] imem_io_imem_rdata; // @[imem_interface.scala 40:20]
  wire [31:0] imem_io_imem_wdata; // @[imem_interface.scala 40:20]
  wire  imem_io_wr_en; // @[imem_interface.scala 40:20]
  wire  bmem_clock; // @[imem_interface.scala 41:20]
  wire  bmem_reset; // @[imem_interface.scala 41:20]
  wire [31:0] bmem_io_bmem_addr; // @[imem_interface.scala 41:20]
  wire [31:0] bmem_io_bmem_rdata; // @[imem_interface.scala 41:20]
  wire [10:0] ibus_imem_addr = io_ibus_addr[10:0]; // @[imem_interface.scala 47:41]
  wire [9:0] ibus_bmem_addr = io_ibus_addr[9:0]; // @[imem_interface.scala 48:41]
  wire [10:0] wbs_imem_addr = io_wbs_m2s_addr[10:0]; // @[imem_interface.scala 49:44]
  reg  ack; // @[imem_interface.scala 54:31]
  reg [3:0] wb_select; // @[imem_interface.scala 55:27]
  wire  wb_rd_en = ~io_wbs_m2s_we & io_wbs_m2s_stb; // @[imem_interface.scala 57:39]
  wire  wb_wr_en = io_wbs_m2s_we & io_wbs_m2s_stb; // @[imem_interface.scala 58:38]
  wire  imem_wbs_addr_match = ~(|io_wbs_m2s_addr[15:12]); // @[imem_interface.scala 63:29]
  wire  imem_wbs_sel = (wb_rd_en | wb_wr_en) & imem_wbs_addr_match; // @[imem_interface.scala 70:46]
  reg  imem_ibus_valid; // @[imem_interface.scala 71:32]
  wire [10:0] imem_addr = imem_wbs_sel ? wbs_imem_addr : ibus_imem_addr; // @[imem_interface.scala 80:27]
  wire [31:0] rd_imem_inst = imem_ibus_valid ? imem_io_imem_rdata : 32'h0; // @[imem_interface.scala 92:23 93:16]
  wire [31:0] rd_imem_const = imem_ibus_valid ? 32'h0 : imem_io_imem_rdata; // @[imem_interface.scala 92:23 95:17]
  wire  _GEN_2 = imem_wbs_sel ? io_wbs_m2s_stb : ack; // @[imem_interface.scala 98:20 99:12 54:31]
  wire [31:0] _GEN_3 = wb_select == 4'hc ? {{16'd0}, rd_imem_const[31:16]} : rd_imem_const; // @[imem_interface.scala 116:54 117:17 119:17]
  wire [31:0] _GEN_4 = wb_select == 4'h3 ? {{16'd0}, rd_imem_const[15:0]} : _GEN_3; // @[imem_interface.scala 114:52 115:17]
  wire [31:0] _GEN_5 = wb_select == 4'h8 ? {{24'd0}, rd_imem_const[31:24]} : _GEN_4; // @[imem_interface.scala 112:52 113:17]
  wire [31:0] _GEN_6 = wb_select == 4'h4 ? {{24'd0}, rd_imem_const[23:16]} : _GEN_5; // @[imem_interface.scala 110:52 111:17]
  wire [31:0] _GEN_7 = wb_select == 4'h2 ? {{24'd0}, rd_imem_const[15:8]} : _GEN_6; // @[imem_interface.scala 108:52 109:17]
  reg  bmem_ibus_sel; // @[imem_interface.scala 127:31]
  IMem imem ( // @[imem_interface.scala 40:20]
    .clock(imem_clock),
    .io_imem_addr(imem_io_imem_addr),
    .io_imem_rdata(imem_io_imem_rdata),
    .io_imem_wdata(imem_io_imem_wdata),
    .io_wr_en(imem_io_wr_en)
  );
  BMem bmem ( // @[imem_interface.scala 41:20]
    .clock(bmem_clock),
    .reset(bmem_reset),
    .io_bmem_addr(bmem_io_bmem_addr),
    .io_bmem_rdata(bmem_io_bmem_rdata)
  );
  assign io_ibus_inst = bmem_ibus_sel ? bmem_io_bmem_rdata : rd_imem_inst; // @[imem_interface.scala 137:25]
  assign io_ibus_valid = bmem_ibus_sel | imem_ibus_valid; // @[imem_interface.scala 138:25]
  assign io_wbs_ack_o = ack; // @[imem_interface.scala 123:18]
  assign io_wbs_data_o = wb_select == 4'h1 ? {{24'd0}, rd_imem_const[7:0]} : _GEN_7; // @[imem_interface.scala 106:45 107:17]
  assign imem_clock = clock;
  assign imem_io_imem_addr = {{21'd0}, imem_addr}; // @[imem_interface.scala 81:21]
  assign imem_io_imem_wdata = io_wbs_m2s_data; // @[imem_interface.scala 87:22]
  assign imem_io_wr_en = imem_wbs_addr_match & wb_wr_en; // @[imem_interface.scala 64:46]
  assign bmem_clock = clock;
  assign bmem_reset = reset;
  assign bmem_io_bmem_addr = {{22'd0}, ibus_bmem_addr}; // @[imem_interface.scala 130:21]
  always @(posedge clock) begin
    ack <= reset | _GEN_2; // @[imem_interface.scala 54:{31,31}]
    wb_select <= io_wbs_m2s_sel; // @[imem_interface.scala 104:16]
    imem_ibus_valid <= reset | ~imem_wbs_sel; // @[imem_interface.scala 71:{32,32} 72:19]
    if (reset) begin // @[imem_interface.scala 127:31]
      bmem_ibus_sel <= 1'h0; // @[imem_interface.scala 127:31]
    end else begin
      bmem_ibus_sel <= io_ibus_addr[15:12] == 4'h7; // @[imem_interface.scala 128:18]
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ack = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  wb_select = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  imem_ibus_valid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  bmem_ibus_sel = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WBM_DBus(
  input  [31:0] io_dbus_addr,
  input  [31:0] io_dbus_wdata,
  output [31:0] io_dbus_rdata,
  input         io_dbus_rd_en,
  input         io_dbus_wr_en,
  input  [1:0]  io_dbus_st_type,
  input  [2:0]  io_dbus_ld_type,
  output        io_dbus_valid,
  output [15:0] io_wbm_m2s_addr,
  output [31:0] io_wbm_m2s_data,
  output        io_wbm_m2s_we,
  output [3:0]  io_wbm_m2s_sel,
  output        io_wbm_m2s_stb,
  input         io_wbm_ack_i,
  input  [31:0] io_wbm_data_i
);
  wire [3:0] _GEN_0 = io_dbus_st_type == 2'h3 ? 4'h1 : 4'h0; // @[wbm_dbus.scala 41:46 42:18]
  wire [3:0] _GEN_1 = io_dbus_st_type == 2'h2 ? 4'h3 : _GEN_0; // @[wbm_dbus.scala 38:47 39:18]
  wire [3:0] st_sel_vec = io_dbus_st_type == 2'h1 ? 4'hf : _GEN_1; // @[wbm_dbus.scala 35:40 36:18]
  wire [1:0] ld_align = io_dbus_addr[1:0]; // @[wbm_dbus.scala 46:30]
  wire [3:0] _ld_sel_vec_T_1 = ld_align[1] ? 4'hc : 4'h3; // @[wbm_dbus.scala 55:25]
  wire [3:0] _GEN_3 = ld_align == 2'h1 ? 4'h2 : 4'h1; // @[wbm_dbus.scala 62:37 63:20 65:20]
  wire [3:0] _GEN_4 = ld_align == 2'h2 ? 4'h4 : _GEN_3; // @[wbm_dbus.scala 60:37 61:20]
  wire [3:0] _GEN_5 = ld_align == 2'h3 ? 4'h8 : _GEN_4; // @[wbm_dbus.scala 58:32 59:20]
  wire [3:0] _GEN_6 = io_dbus_ld_type == 3'h3 | io_dbus_ld_type == 3'h5 ? _GEN_5 : 4'h0; // @[wbm_dbus.scala 57:75]
  wire [3:0] _GEN_7 = io_dbus_ld_type == 3'h2 | io_dbus_ld_type == 3'h4 ? _ld_sel_vec_T_1 : _GEN_6; // @[wbm_dbus.scala 54:76 55:18]
  wire [3:0] ld_sel_vec = io_dbus_ld_type == 3'h1 ? 4'hf : _GEN_7; // @[wbm_dbus.scala 51:37 52:16]
  assign io_dbus_rdata = io_wbm_data_i; // @[wbm_dbus.scala 78:19]
  assign io_dbus_valid = io_wbm_ack_i; // @[wbm_dbus.scala 79:19]
  assign io_wbm_m2s_addr = io_dbus_addr[15:0]; // @[wbm_dbus.scala 71:34]
  assign io_wbm_m2s_data = io_dbus_wdata; // @[wbm_dbus.scala 72:19]
  assign io_wbm_m2s_we = io_dbus_wr_en; // @[wbm_dbus.scala 73:19]
  assign io_wbm_m2s_sel = |io_dbus_st_type ? st_sel_vec : ld_sel_vec; // @[wbm_dbus.scala 74:25]
  assign io_wbm_m2s_stb = io_dbus_rd_en | io_dbus_wr_en; // @[wbm_dbus.scala 75:43]
endmodule
module UARTTx(
  input        clock,
  input        reset,
  output       io_in_ready,
  input        io_in_valid,
  input  [7:0] io_in_bits,
  output       io_out,
  input  [9:0] io_div
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] prescaler; // @[uart_tx.scala 23:26]
  wire  pulse = prescaler == 10'h0; // @[uart_tx.scala 24:30]
  reg [3:0] counter; // @[uart_tx.scala 27:26]
  reg [8:0] shifter; // @[uart_tx.scala 28:22]
  reg  out; // @[uart_tx.scala 29:26]
  wire  busy = counter != 4'h0; // @[uart_tx.scala 32:28]
  wire  state1 = io_in_valid & ~busy; // @[uart_tx.scala 33:31]
  wire [8:0] _shifter_T = {io_in_bits,1'h0}; // @[Cat.scala 33:92]
  wire [8:0] _GEN_0 = state1 ? _shifter_T : shifter; // @[uart_tx.scala 37:16 38:14 28:22]
  wire [3:0] _GEN_1 = state1 ? 4'hb : counter; // @[uart_tx.scala 37:16 39:14 27:26]
  wire [9:0] _prescaler_T_1 = io_div - 10'h1; // @[uart_tx.scala 45:37]
  wire [9:0] _prescaler_T_3 = prescaler - 10'h1; // @[uart_tx.scala 45:55]
  wire [3:0] _counter_T_6 = counter - 4'h1; // @[uart_tx.scala 48:26]
  wire [8:0] _shifter_T_2 = {1'h1,shifter[8:1]}; // @[Cat.scala 33:92]
  wire  _GEN_4 = pulse ? shifter[0] : out; // @[uart_tx.scala 47:17 50:15 29:26]
  wire  _GEN_8 = busy ? _GEN_4 : out; // @[uart_tx.scala 44:16 29:26]
  assign io_in_ready = ~busy; // @[uart_tx.scala 35:20]
  assign io_out = out; // @[uart_tx.scala 30:17]
  always @(posedge clock) begin
    if (reset) begin // @[uart_tx.scala 23:26]
      prescaler <= 10'h0; // @[uart_tx.scala 23:26]
    end else if (busy) begin // @[uart_tx.scala 44:16]
      if (pulse) begin // @[uart_tx.scala 45:21]
        prescaler <= _prescaler_T_1;
      end else begin
        prescaler <= _prescaler_T_3;
      end
    end
    if (reset) begin // @[uart_tx.scala 27:26]
      counter <= 4'h0; // @[uart_tx.scala 27:26]
    end else if (busy) begin // @[uart_tx.scala 44:16]
      if (pulse) begin // @[uart_tx.scala 47:17]
        counter <= _counter_T_6; // @[uart_tx.scala 48:15]
      end else begin
        counter <= _GEN_1;
      end
    end else begin
      counter <= _GEN_1;
    end
    if (busy) begin // @[uart_tx.scala 44:16]
      if (pulse) begin // @[uart_tx.scala 47:17]
        shifter <= _shifter_T_2; // @[uart_tx.scala 49:15]
      end else begin
        shifter <= _GEN_0;
      end
    end else begin
      shifter <= _GEN_0;
    end
    out <= reset | _GEN_8; // @[uart_tx.scala 29:{26,26}]
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  prescaler = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  counter = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  shifter = _RAND_2[8:0];
  _RAND_3 = {1{`RANDOM}};
  out = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module UARTRx(
  input        clock,
  input        reset,
  input        io_in,
  output       io_out_valid,
  output [7:0] io_out_bits,
  input  [9:0] io_div
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] data_count; // @[uart_rx.scala 23:34]
  wire  data_last = data_count == 4'h0; // @[uart_rx.scala 24:43]
  reg [9:0] prescaler; // @[uart_rx.scala 27:38]
  wire  pulse = prescaler == 10'h0; // @[uart_rx.scala 28:42]
  wire [9:0] _prescaler_next_T_1 = io_div - 10'h1; // @[uart_rx.scala 29:50]
  wire [9:0] _prescaler_next_T_3 = prescaler - 10'h1; // @[uart_rx.scala 29:68]
  wire [9:0] prescaler_next = pulse ? _prescaler_next_T_1 : _prescaler_next_T_3; // @[uart_rx.scala 29:34]
  reg [8:0] debounce; // @[uart_rx.scala 32:38]
  wire [9:0] _debounce_max_T = io_div / 2'h2; // @[uart_rx.scala 33:52]
  wire [9:0] _GEN_28 = {{1'd0}, debounce}; // @[uart_rx.scala 33:41]
  wire  debounce_max = _GEN_28 == _debounce_max_T; // @[uart_rx.scala 33:41]
  reg [7:0] shifter; // @[uart_rx.scala 36:27]
  reg  valid; // @[uart_rx.scala 37:23]
  reg  state; // @[uart_rx.scala 44:27]
  wire [8:0] _debounce_T_1 = debounce + 9'h1; // @[uart_rx.scala 50:30]
  wire  _GEN_0 = debounce_max | state; // @[uart_rx.scala 51:29 52:22 44:27]
  wire [3:0] _data_count_T_1 = data_count - 4'h1; // @[uart_rx.scala 62:34]
  wire [7:0] _shifter_T_1 = {io_in,shifter[7:1]}; // @[Cat.scala 33:92]
  wire  _GEN_7 = data_last ? 1'h0 : state; // @[uart_rx.scala 64:26 65:22 44:27]
  wire [8:0] _GEN_9 = data_last ? 9'h0 : debounce; // @[uart_rx.scala 64:26 67:22 32:38]
  wire [7:0] _GEN_10 = data_last ? shifter : _shifter_T_1; // @[uart_rx.scala 64:26 36:27 70:22]
  wire  _GEN_13 = pulse & data_last; // @[uart_rx.scala 38:18 61:20]
  assign io_out_valid = valid; // @[uart_rx.scala 39:18]
  assign io_out_bits = shifter; // @[uart_rx.scala 40:18]
  always @(posedge clock) begin
    if (~state) begin // @[uart_rx.scala 46:18]
      if (~io_in) begin // @[uart_rx.scala 48:21]
        if (debounce_max) begin // @[uart_rx.scala 51:29]
          data_count <= 4'h8; // @[uart_rx.scala 53:22]
        end
      end
    end else if (state) begin // @[uart_rx.scala 46:18]
      if (pulse) begin // @[uart_rx.scala 61:20]
        data_count <= _data_count_T_1; // @[uart_rx.scala 62:20]
      end
    end
    if (reset) begin // @[uart_rx.scala 27:38]
      prescaler <= 10'h0; // @[uart_rx.scala 27:38]
    end else if (~state) begin // @[uart_rx.scala 46:18]
      if (~io_in) begin // @[uart_rx.scala 48:21]
        if (debounce_max) begin // @[uart_rx.scala 51:29]
          prescaler <= prescaler_next; // @[uart_rx.scala 54:22]
        end
      end
    end else if (state) begin // @[uart_rx.scala 46:18]
      prescaler <= prescaler_next; // @[uart_rx.scala 60:17]
    end
    if (reset) begin // @[uart_rx.scala 32:38]
      debounce <= 9'h0; // @[uart_rx.scala 32:38]
    end else if (~state) begin // @[uart_rx.scala 46:18]
      if (~io_in) begin // @[uart_rx.scala 48:21]
        debounce <= _debounce_T_1; // @[uart_rx.scala 50:18]
      end
    end else if (state) begin // @[uart_rx.scala 46:18]
      if (pulse) begin // @[uart_rx.scala 61:20]
        debounce <= _GEN_9;
      end
    end
    if (reset) begin // @[uart_rx.scala 36:27]
      shifter <= 8'h0; // @[uart_rx.scala 36:27]
    end else if (!(~state)) begin // @[uart_rx.scala 46:18]
      if (state) begin // @[uart_rx.scala 46:18]
        if (pulse) begin // @[uart_rx.scala 61:20]
          shifter <= _GEN_10;
        end
      end
    end
    if (~state) begin // @[uart_rx.scala 46:18]
      valid <= 1'h0; // @[uart_rx.scala 38:18]
    end else begin
      valid <= state & _GEN_13;
    end
    if (reset) begin // @[uart_rx.scala 44:27]
      state <= 1'h0; // @[uart_rx.scala 44:27]
    end else if (~state) begin // @[uart_rx.scala 46:18]
      if (~io_in) begin // @[uart_rx.scala 48:21]
        state <= _GEN_0;
      end
    end else if (state) begin // @[uart_rx.scala 46:18]
      if (pulse) begin // @[uart_rx.scala 61:20]
        state <= _GEN_7;
      end
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  data_count = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  prescaler = _RAND_1[9:0];
  _RAND_2 = {1{`RANDOM}};
  debounce = _RAND_2[8:0];
  _RAND_3 = {1{`RANDOM}};
  shifter = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  valid = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  state = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module UART(
  input         clock,
  input         reset,
  input         io_uart_select,
  output        io_txd,
  input         io_rxd,
  output        io_uartInt,
  input  [15:0] io_wbs_m2s_addr,
  input  [31:0] io_wbs_m2s_data,
  input         io_wbs_m2s_we,
  input         io_wbs_m2s_stb,
  output        io_wbs_ack_o,
  output [31:0] io_wbs_data_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  wire  txm_clock; // @[uart.scala 53:19]
  wire  txm_reset; // @[uart.scala 53:19]
  wire  txm_io_in_ready; // @[uart.scala 53:19]
  wire  txm_io_in_valid; // @[uart.scala 53:19]
  wire [7:0] txm_io_in_bits; // @[uart.scala 53:19]
  wire  txm_io_out; // @[uart.scala 53:19]
  wire [9:0] txm_io_div; // @[uart.scala 53:19]
  wire  rxm_clock; // @[uart.scala 54:19]
  wire  rxm_reset; // @[uart.scala 54:19]
  wire  rxm_io_in; // @[uart.scala 54:19]
  wire  rxm_io_out_valid; // @[uart.scala 54:19]
  wire [7:0] rxm_io_out_bits; // @[uart.scala 54:19]
  wire [9:0] rxm_io_div; // @[uart.scala 54:19]
  reg  txen; // @[uart.scala 57:27]
  reg [7:0] tx_data_r; // @[uart.scala 60:27]
  reg [7:0] rx_data_r; // @[uart.scala 61:27]
  reg [7:0] control_r; // @[uart.scala 62:27]
  reg [9:0] baud_r; // @[uart.scala 63:27]
  reg [7:0] status_r; // @[uart.scala 64:27]
  reg [7:0] int_mask_r; // @[uart.scala 65:27]
  wire [7:0] addr = io_wbs_m2s_addr[7:0]; // @[uart.scala 85:36]
  wire  rd_en = ~io_wbs_m2s_we & io_wbs_m2s_stb; // @[uart.scala 86:36]
  wire  wr_en = io_wbs_m2s_we & io_wbs_m2s_stb; // @[uart.scala 87:35]
  wire  sel_reg_rx = addr == 8'h0 & io_uart_select; // @[uart.scala 91:56]
  wire  sel_reg_tx = addr == 8'h1 & io_uart_select; // @[uart.scala 92:56]
  wire  sel_reg_baud = addr == 8'h2 & io_uart_select; // @[uart.scala 93:54]
  wire  sel_reg_control = addr == 8'h3 & io_uart_select; // @[uart.scala 94:57]
  wire  sel_reg_status = addr == 8'h4 & io_uart_select; // @[uart.scala 95:56]
  wire  sel_reg_int_mask = addr == 8'h5 & io_uart_select; // @[uart.scala 96:58]
  reg  ack; // @[uart.scala 99:28]
  reg [7:0] rd_data; // @[uart.scala 104:28]
  wire [7:0] _GEN_0 = rd_en & sel_reg_rx ? rx_data_r : 8'h0; // @[uart.scala 112:34 113:15 115:15]
  wire [7:0] _GEN_1 = rd_en & sel_reg_status ? status_r : _GEN_0; // @[uart.scala 110:38 111:15]
  wire [9:0] _GEN_2 = rd_en & sel_reg_baud ? baud_r : {{2'd0}, _GEN_1}; // @[uart.scala 108:36 109:15]
  wire [9:0] _GEN_3 = rd_en & sel_reg_control ? {{2'd0}, control_r} : _GEN_2; // @[uart.scala 106:33 107:15]
  wire [7:0] _io_uartInt_T = status_r & int_mask_r; // @[uart.scala 120:31]
  wire [7:0] _GEN_4 = sel_reg_int_mask ? io_wbs_m2s_data[7:0] : int_mask_r; // @[uart.scala 134:32 135:18 65:27]
  wire [7:0] _GEN_5 = sel_reg_control ? io_wbs_m2s_data[7:0] : control_r; // @[uart.scala 131:31 132:18 62:27]
  wire [7:0] _GEN_6 = sel_reg_control ? int_mask_r : _GEN_4; // @[uart.scala 131:31 65:27]
  wire  _GEN_16 = wr_en & sel_reg_tx; // @[uart.scala 123:15 73:19]
  wire [7:0] _status_r_T_1 = {status_r[7:1],1'h1}; // @[Cat.scala 33:92]
  wire [7:0] _status_r_T_5 = {status_r[7:2],txm_io_in_ready,status_r[0]}; // @[Cat.scala 33:92]
  wire [9:0] _GEN_23 = reset ? 10'h0 : _GEN_3; // @[uart.scala 104:{28,28}]
  UARTTx txm ( // @[uart.scala 53:19]
    .clock(txm_clock),
    .reset(txm_reset),
    .io_in_ready(txm_io_in_ready),
    .io_in_valid(txm_io_in_valid),
    .io_in_bits(txm_io_in_bits),
    .io_out(txm_io_out),
    .io_div(txm_io_div)
  );
  UARTRx rxm ( // @[uart.scala 54:19]
    .clock(rxm_clock),
    .reset(rxm_reset),
    .io_in(rxm_io_in),
    .io_out_valid(rxm_io_out_valid),
    .io_out_bits(rxm_io_out_bits),
    .io_div(rxm_io_div)
  );
  assign io_txd = txm_io_out; // @[uart.scala 82:19]
  assign io_uartInt = |_io_uartInt_T; // @[uart.scala 120:45]
  assign io_wbs_ack_o = ack; // @[uart.scala 100:19]
  assign io_wbs_data_o = {{24'd0}, rd_data}; // @[uart.scala 117:18]
  assign txm_clock = clock;
  assign txm_reset = reset;
  assign txm_io_in_valid = txen; // @[uart.scala 74:19]
  assign txm_io_in_bits = tx_data_r; // @[uart.scala 75:19]
  assign txm_io_div = baud_r; // @[uart.scala 76:19]
  assign rxm_clock = clock;
  assign rxm_reset = reset;
  assign rxm_io_in = io_rxd; // @[uart.scala 81:19]
  assign rxm_io_div = baud_r; // @[uart.scala 78:19]
  always @(posedge clock) begin
    if (reset) begin // @[uart.scala 57:27]
      txen <= 1'h0; // @[uart.scala 57:27]
    end else begin
      txen <= _GEN_16;
    end
    if (reset) begin // @[uart.scala 60:27]
      tx_data_r <= 8'h4a; // @[uart.scala 60:27]
    end else if (wr_en) begin // @[uart.scala 123:15]
      if (sel_reg_tx) begin // @[uart.scala 124:22]
        tx_data_r <= io_wbs_m2s_data[7:0]; // @[uart.scala 125:18]
      end
    end
    if (reset) begin // @[uart.scala 61:27]
      rx_data_r <= 8'h0; // @[uart.scala 61:27]
    end else if (rxm_io_out_valid) begin // @[uart.scala 140:25]
      rx_data_r <= rxm_io_out_bits; // @[uart.scala 141:18]
    end
    if (reset) begin // @[uart.scala 62:27]
      control_r <= 8'h0; // @[uart.scala 62:27]
    end else if (wr_en) begin // @[uart.scala 123:15]
      if (!(sel_reg_tx)) begin // @[uart.scala 124:22]
        if (!(sel_reg_baud)) begin // @[uart.scala 128:29]
          control_r <= _GEN_5;
        end
      end
    end
    if (reset) begin // @[uart.scala 63:27]
      baud_r <= 10'h8; // @[uart.scala 63:27]
    end else if (wr_en) begin // @[uart.scala 123:15]
      if (!(sel_reg_tx)) begin // @[uart.scala 124:22]
        if (sel_reg_baud) begin // @[uart.scala 128:29]
          baud_r <= {{2'd0}, io_wbs_m2s_data[7:0]}; // @[uart.scala 129:18]
        end
      end
    end
    if (reset) begin // @[uart.scala 64:27]
      status_r <= 8'h0; // @[uart.scala 64:27]
    end else if (rxm_io_out_valid) begin // @[uart.scala 140:25]
      status_r <= _status_r_T_1; // @[uart.scala 142:18]
    end else if (wr_en & sel_reg_status) begin // @[uart.scala 143:38]
      status_r <= io_wbs_m2s_data[7:0]; // @[uart.scala 144:18]
    end else begin
      status_r <= _status_r_T_5; // @[uart.scala 146:18]
    end
    if (reset) begin // @[uart.scala 65:27]
      int_mask_r <= 8'h0; // @[uart.scala 65:27]
    end else if (wr_en) begin // @[uart.scala 123:15]
      if (!(sel_reg_tx)) begin // @[uart.scala 124:22]
        if (!(sel_reg_baud)) begin // @[uart.scala 128:29]
          int_mask_r <= _GEN_6;
        end
      end
    end
    if (reset) begin // @[uart.scala 99:28]
      ack <= 1'h0; // @[uart.scala 99:28]
    end else begin
      ack <= io_wbs_m2s_stb; // @[uart.scala 101:19]
    end
    rd_data <= _GEN_23[7:0]; // @[uart.scala 104:{28,28}]
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  txen = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  tx_data_r = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  rx_data_r = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  control_r = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  baud_r = _RAND_4[9:0];
  _RAND_5 = {1{`RANDOM}};
  status_r = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  int_mask_r = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  ack = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  rd_data = _RAND_8[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SPI(
  input         clock,
  input         reset,
  input         io_spi_select,
  output        io_spi_cs,
  output        io_spi_clk,
  output        io_spi_mosi,
  input         io_spi_miso,
  output        io_spi_intr,
  input  [15:0] io_wbs_m2s_addr,
  input  [31:0] io_wbs_m2s_data,
  input         io_wbs_m2s_we,
  input         io_wbs_m2s_stb,
  output        io_wbs_ack_o,
  output [31:0] io_wbs_data_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
`endif // RANDOMIZE_REG_INIT
  reg  ack_o; // @[spi.scala 65:25]
  reg [7:0] rd_data; // @[spi.scala 66:25]
  reg  sclk_r; // @[spi.scala 69:23]
  reg  mosi_r; // @[spi.scala 70:23]
  reg  read_wait_done; // @[spi.scala 75:31]
  reg [7:0] reg_rxdata; // @[spi.scala 78:28]
  reg [7:0] reg_txdata; // @[spi.scala 79:28]
  reg  reg_ssmask; // @[spi.scala 80:28]
  reg [7:0] rx_shift_data; // @[spi.scala 82:30]
  reg [7:0] tx_shift_data; // @[spi.scala 83:30]
  reg  rx_latch_flag; // @[spi.scala 84:30]
  reg  bit_iroe; // @[spi.scala 87:27]
  reg  bit_itoe; // @[spi.scala 88:27]
  reg  bit_itrdy; // @[spi.scala 89:27]
  reg  bit_irrdy; // @[spi.scala 90:27]
  reg  bit_ie; // @[spi.scala 91:27]
  reg  bit_sso; // @[spi.scala 92:27]
  reg  bit_toe; // @[spi.scala 95:27]
  reg  bit_roe; // @[spi.scala 96:27]
  reg  bit_trdy; // @[spi.scala 97:27]
  reg  bit_rrdy; // @[spi.scala 98:27]
  reg  bit_tmt; // @[spi.scala 99:27]
  reg  bit_e; // @[spi.scala 100:27]
  wire [7:0] addr = io_wbs_m2s_addr[7:0]; // @[spi.scala 106:33]
  wire  _rd_en_T = ~io_wbs_m2s_we; // @[spi.scala 108:19]
  wire  rd_en = ~io_wbs_m2s_we & io_wbs_m2s_stb; // @[spi.scala 108:34]
  wire  wr_en = io_wbs_m2s_we & io_wbs_m2s_stb; // @[spi.scala 109:33]
  wire  sel_reg_rx = addr == 8'h0 & io_spi_select; // @[spi.scala 113:54]
  wire  sel_reg_tx = addr == 8'h1 & io_spi_select; // @[spi.scala 114:54]
  wire  sel_reg_control = addr == 8'h3 & io_spi_select; // @[spi.scala 116:55]
  wire  sel_reg_status = addr == 8'h4 & io_spi_select; // @[spi.scala 117:54]
  wire  sel_reg_ssmask = addr == 8'h5 & io_spi_select; // @[spi.scala 118:55]
  wire  _T = wr_en & sel_reg_tx; // @[spi.scala 126:14]
  wire [7:0] latch_s_data = io_wbs_m2s_data[7:0];
  wire [7:0] reg_status = {bit_e,bit_rrdy,bit_trdy,bit_tmt,bit_toe,bit_roe,2'h0}; // @[Cat.scala 33:92]
  wire [7:0] reg_control = {bit_sso,1'h0,bit_ie,bit_irrdy,bit_itrdy,1'h0,bit_itoe,bit_iroe}; // @[Cat.scala 33:92]
  wire  _GEN_7 = wr_en & sel_reg_control ? latch_s_data[7] : bit_sso; // @[spi.scala 138:34 144:15 92:27]
  wire  _GEN_8 = io_wbs_m2s_stb & (io_wbs_m2s_we | read_wait_done) | ack_o; // @[spi.scala 154:59 155:10 65:25]
  wire  _GEN_10 = io_wbs_m2s_stb & _rd_en_T | read_wait_done; // @[spi.scala 161:43 162:20 75:31]
  reg [4:0] clock_cnt; // @[spi.scala 166:31]
  reg [5:0] data_cnt; // @[spi.scala 167:31]
  reg  pending_data; // @[spi.scala 168:31]
  reg [2:0] n_status; // @[spi.scala 170:31]
  reg [2:0] p_status; // @[spi.scala 171:31]
  wire  _T_10 = n_status == 3'h1; // @[spi.scala 175:27]
  wire  _GEN_12 = n_status == 3'h1 ? 1'h0 : pending_data; // @[spi.scala 175:40 176:20 168:31]
  wire  _GEN_13 = _T | _GEN_12; // @[spi.scala 173:32 174:20]
  wire [7:0] _rd_data_T = sel_reg_ssmask ? {{7'd0}, reg_ssmask} : 8'h0; // @[spi.scala 181:78]
  wire [7:0] _rd_data_T_1 = sel_reg_control ? reg_control : _rd_data_T; // @[spi.scala 181:44]
  wire [7:0] _rd_data_T_2 = sel_reg_status ? reg_status : _rd_data_T_1; // @[spi.scala 181:12]
  wire  _T_12 = n_status == 3'h3; // @[spi.scala 201:21]
  wire  _T_13 = clock_cnt == 5'h3; // @[spi.scala 201:49]
  wire  _T_14 = n_status == 3'h3 & clock_cnt == 5'h3; // @[spi.scala 201:35]
  wire  _sclk_r_T = ~sclk_r; // @[spi.scala 202:18]
  wire [8:0] _rx_shift_data_T_2 = {rx_shift_data,io_spi_miso}; // @[Cat.scala 33:92]
  wire [8:0] _GEN_18 = _T_13 & _sclk_r_T & _T_12 ? _rx_shift_data_T_2 : {{1'd0}, rx_shift_data}; // @[spi.scala 208:99 82:30]
  wire  _GEN_19 = rx_latch_flag ? 1'h0 : rx_latch_flag; // @[spi.scala 219:33 220:21 84:30]
  wire  _GEN_20 = p_status == 3'h3 & n_status != 3'h3 | _GEN_19; // @[spi.scala 217:62 218:21]
  wire  _T_24 = n_status == 3'h0; // @[spi.scala 223:49]
  wire [4:0] _clock_cnt_T_1 = clock_cnt + 5'h1; // @[spi.scala 226:30]
  wire  _T_29 = n_status == 3'h2; // @[spi.scala 246:27]
  wire  _T_31 = data_cnt == 6'h1; // @[spi.scala 247:53]
  wire [2:0] _GEN_24 = _T_13 & data_cnt == 6'h1 ? 3'h3 : 3'h2; // @[spi.scala 247:76 248:18 250:18]
  wire  _T_35 = data_cnt == 6'h7; // @[spi.scala 253:53]
  wire [2:0] _GEN_25 = _T_13 & data_cnt == 6'h7 & sclk_r ? 3'h4 : 3'h3; // @[spi.scala 253:105 254:18 256:18]
  wire  _T_39 = n_status == 3'h4; // @[spi.scala 258:27]
  wire [2:0] _GEN_27 = _T_13 ? 3'h5 : n_status; // @[spi.scala 170:31 259:39]
  wire  _T_41 = n_status == 3'h5; // @[spi.scala 266:27]
  wire  _T_43 = data_cnt == 6'h2; // @[spi.scala 267:53]
  wire [2:0] _GEN_28 = _T_13 & data_cnt == 6'h2 ? 3'h0 : 3'h5; // @[spi.scala 267:77 268:18 270:18]
  wire [2:0] _GEN_29 = n_status == 3'h5 ? _GEN_28 : 3'h0; // @[spi.scala 266:44 273:16]
  wire [2:0] _GEN_30 = n_status == 3'h4 ? _GEN_27 : _GEN_29; // @[spi.scala 258:46]
  wire [2:0] _GEN_31 = _T_12 ? _GEN_25 : _GEN_30; // @[spi.scala 252:41]
  wire  _T_47 = _T_29 & _T_13; // @[spi.scala 276:32]
  wire  _T_59 = _T_41 & _T_13; // @[spi.scala 280:45]
  wire  _T_70 = _T_14 & sclk_r; // @[spi.scala 282:133]
  wire [5:0] _data_cnt_T_1 = data_cnt + 6'h1; // @[spi.scala 283:28]
  wire [5:0] _GEN_35 = _T_47 | _T_14 & sclk_r | _T_59 ? _data_cnt_T_1 : data_cnt; // @[spi.scala 282:238 283:16 167:31]
  reg  wait_one_tick_done; // @[spi.scala 286:37]
  wire [8:0] _tx_shift_data_T_2 = {reg_txdata,1'h0}; // @[Cat.scala 33:92]
  wire [8:0] _tx_shift_data_T_6 = {tx_shift_data,1'h0}; // @[Cat.scala 33:92]
  wire [8:0] _GEN_43 = wait_one_tick_done ? _tx_shift_data_T_6 : {{1'd0}, tx_shift_data}; // @[spi.scala 301:32 303:23 83:30]
  wire [8:0] _GEN_45 = _T_70 ? _GEN_43 : {{1'd0}, tx_shift_data}; // @[spi.scala 300:114 83:30]
  wire [8:0] _GEN_47 = _T_29 ? _tx_shift_data_T_2 : _GEN_45; // @[spi.scala 297:37 299:21]
  wire  _GEN_48 = _T ? 1'h0 : bit_trdy; // @[spi.scala 310:39 311:16 97:27]
  wire  _GEN_49 = _T_12 | _GEN_48; // @[spi.scala 308:36 309:16]
  wire  _GEN_50 = wr_en & sel_reg_status ? 1'h0 : bit_toe; // @[spi.scala 316:43 317:15 95:27]
  wire  _GEN_51 = ~bit_trdy & wr_en & sel_reg_tx | _GEN_50; // @[spi.scala 314:46 315:15]
  wire  _GEN_52 = bit_rrdy | bit_roe; // @[spi.scala 321:22 322:17 96:27]
  wire  _GEN_58 = n_status != 3'h0 | pending_data ? 1'h0 : 1'h1; // @[spi.scala 331:51 332:15 334:15]
  wire [8:0] _GEN_59 = reset ? 9'h0 : _GEN_18; // @[spi.scala 82:{30,30}]
  wire [8:0] _GEN_60 = reset ? 9'h0 : _GEN_47; // @[spi.scala 83:{30,30}]
  assign io_spi_cs = ~reg_ssmask; // @[spi.scala 198:16]
  assign io_spi_clk = sclk_r; // @[spi.scala 204:16]
  assign io_spi_mosi = mosi_r; // @[spi.scala 306:15]
  assign io_spi_intr = bit_ie & (bit_iroe & bit_roe | bit_itoe & bit_toe) | bit_itrdy & bit_trdy | bit_irrdy & bit_rrdy; // @[spi.scala 147:95]
  assign io_wbs_ack_o = ack_o; // @[spi.scala 157:15]
  assign io_wbs_data_o = {{24'd0}, rd_data}; // @[spi.scala 183:18]
  always @(posedge clock) begin
    if (reset) begin // @[spi.scala 65:25]
      ack_o <= 1'h0; // @[spi.scala 65:25]
    end else if (ack_o) begin // @[spi.scala 152:15]
      ack_o <= 1'h0; // @[spi.scala 153:10]
    end else begin
      ack_o <= _GEN_8;
    end
    if (reset) begin // @[spi.scala 66:25]
      rd_data <= 8'h0; // @[spi.scala 66:25]
    end else if (rd_en) begin // @[spi.scala 179:18]
      if (sel_reg_rx) begin // @[spi.scala 180:21]
        rd_data <= reg_rxdata;
      end else if (sel_reg_tx) begin // @[spi.scala 180:49]
        rd_data <= reg_txdata;
      end else begin
        rd_data <= _rd_data_T_2;
      end
    end
    if (reset) begin // @[spi.scala 69:23]
      sclk_r <= 1'h0; // @[spi.scala 69:23]
    end else if (n_status == 3'h3 & clock_cnt == 5'h3) begin // @[spi.scala 201:67]
      sclk_r <= ~sclk_r; // @[spi.scala 202:14]
    end
    if (reset) begin // @[spi.scala 70:23]
      mosi_r <= 1'h0; // @[spi.scala 70:23]
    end else if (_T_29) begin // @[spi.scala 297:37]
      mosi_r <= reg_txdata[7]; // @[spi.scala 298:14]
    end else if (_T_70) begin // @[spi.scala 300:114]
      if (wait_one_tick_done) begin // @[spi.scala 301:32]
        mosi_r <= tx_shift_data[7]; // @[spi.scala 302:16]
      end
    end
    if (reset) begin // @[spi.scala 75:31]
      read_wait_done <= 1'h0; // @[spi.scala 75:31]
    end else if (ack_o) begin // @[spi.scala 159:15]
      read_wait_done <= 1'h0; // @[spi.scala 160:19]
    end else begin
      read_wait_done <= _GEN_10;
    end
    if (reset) begin // @[spi.scala 78:28]
      reg_rxdata <= 8'h0; // @[spi.scala 78:28]
    end else if (rx_latch_flag) begin // @[spi.scala 121:23]
      reg_rxdata <= rx_shift_data; // @[spi.scala 122:16]
    end
    if (reset) begin // @[spi.scala 79:28]
      reg_txdata <= 8'h35; // @[spi.scala 79:28]
    end else if (wr_en & sel_reg_tx & bit_trdy) begin // @[spi.scala 126:41]
      reg_txdata <= latch_s_data; // @[spi.scala 127:16]
    end
    if (reset) begin // @[spi.scala 80:28]
      reg_ssmask <= 1'h0; // @[spi.scala 80:28]
    end else if (wr_en & sel_reg_ssmask) begin // @[spi.scala 185:35]
      reg_ssmask <= latch_s_data[0]; // @[spi.scala 186:18]
    end
    rx_shift_data <= _GEN_59[7:0]; // @[spi.scala 82:{30,30}]
    tx_shift_data <= _GEN_60[7:0]; // @[spi.scala 83:{30,30}]
    if (reset) begin // @[spi.scala 84:30]
      rx_latch_flag <= 1'h0; // @[spi.scala 84:30]
    end else begin
      rx_latch_flag <= _GEN_20;
    end
    if (reset) begin // @[spi.scala 87:27]
      bit_iroe <= 1'h0; // @[spi.scala 87:27]
    end else if (wr_en & sel_reg_control) begin // @[spi.scala 138:34]
      bit_iroe <= latch_s_data[0]; // @[spi.scala 139:15]
    end
    if (reset) begin // @[spi.scala 88:27]
      bit_itoe <= 1'h0; // @[spi.scala 88:27]
    end else if (wr_en & sel_reg_control) begin // @[spi.scala 138:34]
      bit_itoe <= latch_s_data[1]; // @[spi.scala 140:15]
    end
    if (reset) begin // @[spi.scala 89:27]
      bit_itrdy <= 1'h0; // @[spi.scala 89:27]
    end else if (wr_en & sel_reg_control) begin // @[spi.scala 138:34]
      bit_itrdy <= latch_s_data[3]; // @[spi.scala 141:15]
    end
    if (reset) begin // @[spi.scala 90:27]
      bit_irrdy <= 1'h0; // @[spi.scala 90:27]
    end else if (wr_en & sel_reg_control) begin // @[spi.scala 138:34]
      bit_irrdy <= latch_s_data[4]; // @[spi.scala 142:15]
    end
    if (reset) begin // @[spi.scala 91:27]
      bit_ie <= 1'h0; // @[spi.scala 91:27]
    end else if (wr_en & sel_reg_control) begin // @[spi.scala 138:34]
      bit_ie <= latch_s_data[5]; // @[spi.scala 143:15]
    end
    bit_sso <= reset | _GEN_7; // @[spi.scala 92:{27,27}]
    if (reset) begin // @[spi.scala 95:27]
      bit_toe <= 1'h0; // @[spi.scala 95:27]
    end else begin
      bit_toe <= _GEN_51;
    end
    if (reset) begin // @[spi.scala 96:27]
      bit_roe <= 1'h0; // @[spi.scala 96:27]
    end else if (_T_39 & _T_13) begin // @[spi.scala 320:72]
      bit_roe <= _GEN_52;
    end else if (rd_en & sel_reg_rx) begin // @[spi.scala 326:39]
      bit_roe <= 1'h0; // @[spi.scala 328:15]
    end
    bit_trdy <= reset | _GEN_49; // @[spi.scala 97:{27,27}]
    if (reset) begin // @[spi.scala 98:27]
      bit_rrdy <= 1'h0; // @[spi.scala 98:27]
    end else if (_T_39 & _T_13) begin // @[spi.scala 320:72]
      if (!(bit_rrdy)) begin // @[spi.scala 321:22]
        bit_rrdy <= 1'h1; // @[spi.scala 324:18]
      end
    end else if (rd_en & sel_reg_rx) begin // @[spi.scala 326:39]
      bit_rrdy <= 1'h0; // @[spi.scala 327:16]
    end
    bit_tmt <= reset | _GEN_58; // @[spi.scala 99:{27,27}]
    if (reset) begin // @[spi.scala 100:27]
      bit_e <= 1'h0; // @[spi.scala 100:27]
    end else begin
      bit_e <= bit_toe | bit_roe; // @[spi.scala 131:8]
    end
    if (reset) begin // @[spi.scala 166:31]
      clock_cnt <= 5'h0; // @[spi.scala 166:31]
    end else if (_T_13 | n_status == 3'h0) begin // @[spi.scala 223:63]
      clock_cnt <= 5'h0; // @[spi.scala 224:17]
    end else begin
      clock_cnt <= _clock_cnt_T_1; // @[spi.scala 226:17]
    end
    if (reset) begin // @[spi.scala 167:31]
      data_cnt <= 6'h0; // @[spi.scala 167:31]
    end else if (_T_29 & _T_13 & _T_31) begin // @[spi.scala 276:99]
      data_cnt <= 6'h0; // @[spi.scala 277:16]
    end else if (_T_14 & _T_35 & sclk_r) begin // @[spi.scala 278:138]
      data_cnt <= 6'h0; // @[spi.scala 279:16]
    end else if (_T_41 & _T_13 & _T_43) begin // @[spi.scala 280:113]
      data_cnt <= 6'h0; // @[spi.scala 281:16]
    end else begin
      data_cnt <= _GEN_35;
    end
    if (reset) begin // @[spi.scala 168:31]
      pending_data <= 1'h0; // @[spi.scala 168:31]
    end else begin
      pending_data <= _GEN_13;
    end
    if (reset) begin // @[spi.scala 170:31]
      n_status <= 3'h0; // @[spi.scala 170:31]
    end else if (_T_24) begin // @[spi.scala 234:32]
      if (pending_data) begin // @[spi.scala 235:26]
        n_status <= 3'h1; // @[spi.scala 236:18]
      end else begin
        n_status <= 3'h0; // @[spi.scala 238:18]
      end
    end else if (_T_10) begin // @[spi.scala 240:40]
      n_status <= 3'h2;
    end else if (n_status == 3'h2) begin // @[spi.scala 246:40]
      n_status <= _GEN_24;
    end else begin
      n_status <= _GEN_31;
    end
    if (reset) begin // @[spi.scala 171:31]
      p_status <= 3'h0; // @[spi.scala 171:31]
    end else begin
      p_status <= n_status; // @[spi.scala 230:13]
    end
    if (reset) begin // @[spi.scala 286:37]
      wait_one_tick_done <= 1'h0; // @[spi.scala 286:37]
    end else begin
      wait_one_tick_done <= 1'h1;
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ack_o = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rd_data = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  sclk_r = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  mosi_r = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  read_wait_done = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_rxdata = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  reg_txdata = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  reg_ssmask = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  rx_shift_data = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  tx_shift_data = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  rx_latch_flag = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  bit_iroe = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  bit_itoe = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  bit_itrdy = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  bit_irrdy = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  bit_ie = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  bit_sso = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  bit_toe = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  bit_roe = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  bit_trdy = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  bit_rrdy = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  bit_tmt = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  bit_e = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  clock_cnt = _RAND_23[4:0];
  _RAND_24 = {1{`RANDOM}};
  data_cnt = _RAND_24[5:0];
  _RAND_25 = {1{`RANDOM}};
  pending_data = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  n_status = _RAND_26[2:0];
  _RAND_27 = {1{`RANDOM}};
  p_status = _RAND_27[2:0];
  _RAND_28 = {1{`RANDOM}};
  wait_one_tick_done = _RAND_28[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Interlink_Module(
  input         clock,
  input         reset,
  input  [31:0] io_bus_adr_i,
  input  [3:0]  io_bus_sel_i,
  input         io_bus_we_i,
  input         io_bus_stb_i,
  output        io_bus_ack_o,
  output [31:0] io_bus_dat_o,
  output        io_tmr_val_we,
  input  [31:0] io_tmr_val_do,
  output        io_tmr_dat_we,
  input  [31:0] io_tmr_dat_do,
  output        io_tmr_duty_we,
  input  [31:0] io_tmr_duty_do,
  output        io_tmr_cfg_we,
  input  [31:0] io_tmr_cfg_do,
  output        io_tmr_step_we,
  input  [31:0] io_tmr_step_do,
  output        io_qei_count_we,
  input  [31:0] io_qei_count_do,
  output        io_qei_cfg_we,
  input  [31:0] io_qei_cfg_do,
  input  [15:0] io_qei_speed_do,
  output        io_pid_kp_we,
  input  [15:0] io_pid_kp_do,
  output        io_pid_ki_we,
  input  [15:0] io_pid_ki_do,
  output        io_pid_kd_we,
  input  [15:0] io_pid_kd_do,
  output        io_pid_ref_we,
  input  [15:0] io_pid_ref_do,
  output        io_pid_fb_we,
  input  [15:0] io_pid_fb_do,
  output        io_pid_cfg_we,
  input  [15:0] io_pid_cfg_do,
  input         io_motor_select
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [11:0] reg_offset = io_bus_adr_i[11:0]; // @[interlink.scala 102:35]
  wire  _tmr_cfg_sel_T = io_bus_stb_i & io_motor_select; // @[interlink.scala 104:50]
  wire  tmr_cfg_sel = io_bus_stb_i & io_motor_select & reg_offset == 12'h0; // @[interlink.scala 104:66]
  wire  tmr_val_sel = _tmr_cfg_sel_T & reg_offset == 12'h4; // @[interlink.scala 105:66]
  wire  tmr_dat_sel = _tmr_cfg_sel_T & reg_offset == 12'h8; // @[interlink.scala 106:66]
  wire  tmr_duty_sel = _tmr_cfg_sel_T & reg_offset == 12'hc; // @[interlink.scala 107:66]
  wire  tmr_step_sel = _tmr_cfg_sel_T & reg_offset == 12'h10; // @[interlink.scala 108:66]
  wire  _tmr_cfg_we_T_1 = io_bus_sel_i[0] & io_bus_we_i; // @[interlink.scala 110:76]
  wire  tmr_sel = tmr_cfg_sel | tmr_val_sel | tmr_dat_sel | tmr_duty_sel | tmr_step_sel; // @[interlink.scala 118:81]
  wire [31:0] _tmr_do_T = tmr_step_sel ? io_tmr_step_do : io_tmr_dat_do; // @[interlink.scala 120:57]
  wire [31:0] _tmr_do_T_1 = tmr_duty_sel ? io_tmr_duty_do : _tmr_do_T; // @[interlink.scala 120:26]
  wire  qei_count_sel = _tmr_cfg_sel_T & reg_offset == 12'h100; // @[interlink.scala 124:66]
  wire  qei_cfg_sel = _tmr_cfg_sel_T & reg_offset == 12'h108; // @[interlink.scala 128:66]
  wire  qei_speed_sel = _tmr_cfg_sel_T & reg_offset == 12'h104; // @[interlink.scala 132:66]
  wire  qei_sel = qei_count_sel | qei_cfg_sel | qei_speed_sel; // @[interlink.scala 136:52]
  wire [31:0] _qei_do_T = qei_cfg_sel ? io_qei_cfg_do : io_qei_count_do; // @[interlink.scala 137:59]
  wire [15:0] _qei_speed_do_T = io_qei_speed_do; // @[interlink.scala 195:46]
  wire [31:0] qei_speed_do = {{16'd0}, _qei_speed_do_T}; // @[interlink.scala 131:27 195:21]
  wire  pid_kp_sel = _tmr_cfg_sel_T & reg_offset == 12'h200; // @[interlink.scala 141:66]
  wire  pid_ki_sel = _tmr_cfg_sel_T & reg_offset == 12'h204; // @[interlink.scala 145:66]
  wire  pid_kd_sel = _tmr_cfg_sel_T & reg_offset == 12'h208; // @[interlink.scala 149:66]
  wire  pid_ref_sel = _tmr_cfg_sel_T & reg_offset == 12'h20c; // @[interlink.scala 153:66]
  wire  pid_fb_sel = _tmr_cfg_sel_T & reg_offset == 12'h210; // @[interlink.scala 157:66]
  wire  pid_cfg_sel = _tmr_cfg_sel_T & reg_offset == 12'h214; // @[interlink.scala 161:66]
  wire  pid_sel = pid_kp_sel | pid_ki_sel | pid_kd_sel | pid_ref_sel | pid_fb_sel | pid_cfg_sel; // @[interlink.scala 164:91]
  wire [15:0] _pid_do_T = pid_fb_sel ? $signed(io_pid_fb_do) : $signed(io_pid_cfg_do); // @[interlink.scala 168:46]
  wire [15:0] _pid_do_T_1 = pid_ref_sel ? $signed(io_pid_ref_do) : $signed(_pid_do_T); // @[interlink.scala 167:46]
  wire [15:0] _pid_do_T_2 = pid_kd_sel ? $signed(io_pid_kd_do) : $signed(_pid_do_T_1); // @[interlink.scala 166:46]
  wire [15:0] _pid_do_T_3 = pid_ki_sel ? $signed(io_pid_ki_do) : $signed(_pid_do_T_2); // @[interlink.scala 165:53]
  reg  wb_ack_o; // @[interlink.scala 171:30]
  reg [31:0] wb_data_o; // @[interlink.scala 172:30]
  wire [15:0] _wb_data_o_T = pid_kp_sel ? $signed(io_pid_kp_do) : $signed(_pid_do_T_3); // @[interlink.scala 173:92]
  wire [15:0] _wb_data_o_T_1 = pid_sel ? _wb_data_o_T : 16'h0; // @[interlink.scala 173:69]
  assign io_bus_ack_o = wb_ack_o; // @[interlink.scala 177:21]
  assign io_bus_dat_o = wb_data_o; // @[interlink.scala 176:21]
  assign io_tmr_val_we = tmr_val_sel & _tmr_cfg_we_T_1; // @[interlink.scala 111:43]
  assign io_tmr_dat_we = tmr_dat_sel & _tmr_cfg_we_T_1; // @[interlink.scala 112:43]
  assign io_tmr_duty_we = tmr_duty_sel & _tmr_cfg_we_T_1; // @[interlink.scala 113:43]
  assign io_tmr_cfg_we = tmr_cfg_sel & (io_bus_sel_i[0] & io_bus_we_i); // @[interlink.scala 110:43]
  assign io_tmr_step_we = tmr_step_sel & _tmr_cfg_we_T_1; // @[interlink.scala 114:43]
  assign io_qei_count_we = qei_count_sel & _tmr_cfg_we_T_1; // @[interlink.scala 125:43]
  assign io_qei_cfg_we = qei_cfg_sel & _tmr_cfg_we_T_1; // @[interlink.scala 129:43]
  assign io_pid_kp_we = pid_kp_sel & _tmr_cfg_we_T_1; // @[interlink.scala 142:43]
  assign io_pid_ki_we = pid_ki_sel & _tmr_cfg_we_T_1; // @[interlink.scala 146:43]
  assign io_pid_kd_we = pid_kd_sel & _tmr_cfg_we_T_1; // @[interlink.scala 150:43]
  assign io_pid_ref_we = pid_ref_sel & _tmr_cfg_we_T_1; // @[interlink.scala 154:43]
  assign io_pid_fb_we = pid_fb_sel & _tmr_cfg_we_T_1; // @[interlink.scala 158:43]
  assign io_pid_cfg_we = pid_cfg_sel & _tmr_cfg_we_T_1; // @[interlink.scala 162:43]
  always @(posedge clock) begin
    if (reset) begin // @[interlink.scala 171:30]
      wb_ack_o <= 1'h0; // @[interlink.scala 171:30]
    end else begin
      wb_ack_o <= tmr_sel | qei_sel | pid_sel; // @[interlink.scala 174:21]
    end
    if (reset) begin // @[interlink.scala 172:30]
      wb_data_o <= 32'h0; // @[interlink.scala 172:30]
    end else if (tmr_sel) begin // @[interlink.scala 173:27]
      if (tmr_cfg_sel) begin // @[interlink.scala 119:26]
        wb_data_o <= io_tmr_cfg_do;
      end else if (tmr_val_sel) begin // @[interlink.scala 119:57]
        wb_data_o <= io_tmr_val_do;
      end else begin
        wb_data_o <= _tmr_do_T_1;
      end
    end else if (qei_sel) begin // @[interlink.scala 173:48]
      if (qei_speed_sel) begin // @[interlink.scala 137:26]
        wb_data_o <= qei_speed_do;
      end else begin
        wb_data_o <= _qei_do_T;
      end
    end else begin
      wb_data_o <= {{16'd0}, _wb_data_o_T_1};
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  wb_ack_o = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  wb_data_o = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PWM(
  input         clock,
  input         reset,
  input         io_reg_val_we,
  input  [31:0] io_reg_val_di,
  output [31:0] io_reg_val_do,
  input         io_reg_cfg_we,
  input  [31:0] io_reg_cfg_di,
  output [31:0] io_reg_cfg_do,
  input         io_reg_dat_we,
  input  [31:0] io_reg_dat_di,
  output [31:0] io_reg_dat_do,
  input         io_reg_duty_we,
  input  [31:0] io_reg_duty_di,
  output [31:0] io_reg_duty_do,
  input         io_reg_step_we,
  output [31:0] io_reg_step_do,
  input  [15:0] io_reg_pid_out,
  output        io_pwm_h,
  output        io_pwm_l,
  output        io_irq_out,
  output        io_rawirq_out,
  input         io_x_homed,
  input         io_y_homed
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] value_cur; // @[pwm.scala 51:32]
  reg [31:0] value_reload; // @[pwm.scala 52:32]
  reg [31:0] pwm_duty; // @[pwm.scala 53:32]
  reg [31:0] reg_duty; // @[pwm.scala 54:32]
  reg  enable; // @[pwm.scala 60:32]
  reg  stop_out; // @[pwm.scala 62:32]
  reg  irq_out; // @[pwm.scala 63:32]
  reg  lastenable; // @[pwm.scala 66:28]
  reg  updown; // @[pwm.scala 69:32]
  reg  irq_ena; // @[pwm.scala 72:32]
  reg  pid_out_sel; // @[pwm.scala 75:32]
  reg [3:0] pwm_db; // @[pwm.scala 78:32]
  reg  step1step; // @[pwm.scala 81:32]
  reg  step1dir; // @[pwm.scala 82:32]
  reg  step2step; // @[pwm.scala 83:32]
  reg  step2dir; // @[pwm.scala 84:32]
  wire [2:0] io_reg_step_do_lo = {step2dir,io_x_homed,io_y_homed}; // @[Cat.scala 33:92]
  wire [28:0] io_reg_step_do_hi = {26'h0,step1step,step1dir,step2step}; // @[Cat.scala 33:92]
  wire  _GEN_1 = io_reg_step_we ? io_reg_cfg_di[5] : step1step; // @[pwm.scala 93:24 94:23 81:32]
  wire  _GEN_2 = io_reg_step_we ? io_reg_cfg_di[4] : step1dir; // @[pwm.scala 93:24 95:23 82:32]
  wire  _GEN_3 = io_reg_step_we ? io_reg_cfg_di[3] : step2step; // @[pwm.scala 93:24 96:23 83:32]
  wire  _GEN_4 = io_reg_step_we ? io_reg_cfg_di[2] : step2dir; // @[pwm.scala 93:24 97:23 84:32]
  wire [15:0] _pwm_duty_T = io_reg_pid_out; // @[pwm.scala 102:40]
  reg [31:0] proc_offset; // @[pwm.scala 108:24]
  reg  pwm_ld; // @[pwm.scala 109:24]
  reg  pwm_hd; // @[pwm.scala 110:24]
  wire [4:0] pwm_db_twice = {pwm_db, 1'h0}; // @[pwm.scala 113:30]
  wire [31:0] _GEN_29 = {{27'd0}, pwm_db_twice}; // @[pwm.scala 115:37]
  wire [31:0] _proc_offset_T_2 = value_reload - _GEN_29; // @[pwm.scala 115:84]
  wire [31:0] _GEN_33 = {{28'd0}, pwm_db}; // @[pwm.scala 117:48]
  wire [31:0] _pwm_hd_T_1 = proc_offset - _GEN_33; // @[pwm.scala 117:48]
  wire [31:0] _pwm_ld_T_2 = value_reload - _GEN_33; // @[pwm.scala 118:79]
  wire  _io_rawirq_out_T_1 = stop_out & ~irq_out; // @[pwm.scala 124:32]
  wire [2:0] io_reg_cfg_do_lo = {irq_ena,updown,enable}; // @[Cat.scala 33:92]
  wire [28:0] io_reg_cfg_do_hi = {24'h0,pwm_db,pid_out_sel}; // @[Cat.scala 33:92]
  wire [3:0] _pwm_db_T_2 = io_reg_cfg_di[7:4] + 4'h2; // @[pwm.scala 133:42]
  wire [31:0] value_cur_plus = value_cur + 32'h1; // @[pwm.scala 144:39]
  wire [31:0] value_cur_minus = value_cur - 32'h1; // @[pwm.scala 145:39]
  wire  _T_4 = ~lastenable; // @[pwm.scala 158:25]
  wire  _T_5 = value_cur == value_reload; // @[pwm.scala 163:33]
  wire [31:0] _GEN_13 = value_cur == value_reload ? 32'h0 : value_cur_plus; // @[pwm.scala 163:58 164:23 167:23]
  wire [31:0] _GEN_15 = ~lastenable ? 32'h0 : _GEN_13; // @[pwm.scala 158:38 159:21]
  wire  _GEN_16 = ~lastenable ? 1'h0 : _T_5; // @[pwm.scala 158:38 160:21]
  wire  _T_7 = value_cur == 32'h0; // @[pwm.scala 178:35]
  wire [31:0] _GEN_17 = value_cur == 32'h0 ? value_reload : value_cur_minus; // @[pwm.scala 178:50 179:25 182:25]
  wire [31:0] _GEN_19 = _T_4 ? value_reload : _GEN_17; // @[pwm.scala 173:38 174:23]
  wire  _GEN_20 = _T_4 ? 1'h0 : _T_7; // @[pwm.scala 173:38 175:23]
  assign io_reg_val_do = value_reload; // @[pwm.scala 137:19]
  assign io_reg_cfg_do = {io_reg_cfg_do_hi,io_reg_cfg_do_lo}; // @[Cat.scala 33:92]
  assign io_reg_dat_do = value_cur; // @[pwm.scala 143:19]
  assign io_reg_duty_do = pwm_duty; // @[pwm.scala 87:23]
  assign io_reg_step_do = {io_reg_step_do_hi,io_reg_step_do_lo}; // @[Cat.scala 33:92]
  assign io_pwm_h = pwm_hd & enable; // @[pwm.scala 119:30]
  assign io_pwm_l = pwm_ld & enable; // @[pwm.scala 120:30]
  assign io_irq_out = irq_out; // @[pwm.scala 123:20]
  assign io_rawirq_out = stop_out & ~irq_out; // @[pwm.scala 124:32]
  always @(posedge clock) begin
    if (reset) begin // @[pwm.scala 51:32]
      value_cur <= 32'h0; // @[pwm.scala 51:32]
    end else if (|io_reg_dat_we) begin // @[pwm.scala 150:29]
      value_cur <= io_reg_dat_di; // @[pwm.scala 151:19]
    end else if (enable) begin // @[pwm.scala 152:39]
      if (updown) begin // @[pwm.scala 157:31]
        value_cur <= _GEN_15;
      end else begin
        value_cur <= _GEN_19;
      end
    end
    if (reset) begin // @[pwm.scala 52:32]
      value_reload <= 32'hff; // @[pwm.scala 52:32]
    end else if (|io_reg_val_we) begin // @[pwm.scala 138:29]
      value_reload <= io_reg_val_di; // @[pwm.scala 139:19]
    end
    if (reset) begin // @[pwm.scala 53:32]
      pwm_duty <= 32'h0; // @[pwm.scala 53:32]
    end else if (stop_out) begin // @[pwm.scala 100:18]
      if (pid_out_sel) begin // @[pwm.scala 101:22]
        pwm_duty <= {{16'd0}, _pwm_duty_T}; // @[pwm.scala 102:16]
      end else begin
        pwm_duty <= reg_duty; // @[pwm.scala 104:16]
      end
    end
    if (reset) begin // @[pwm.scala 54:32]
      reg_duty <= 32'h0; // @[pwm.scala 54:32]
    end else if (io_reg_duty_we) begin // @[pwm.scala 88:24]
      reg_duty <= io_reg_duty_di; // @[pwm.scala 89:14]
    end
    if (reset) begin // @[pwm.scala 60:32]
      enable <= 1'h0; // @[pwm.scala 60:32]
    end else if (io_reg_cfg_we) begin // @[pwm.scala 128:23]
      enable <= io_reg_cfg_di[0]; // @[pwm.scala 129:19]
    end
    if (reset) begin // @[pwm.scala 62:32]
      stop_out <= 1'h0; // @[pwm.scala 62:32]
    end else if (!(|io_reg_dat_we)) begin // @[pwm.scala 150:29]
      if (enable) begin // @[pwm.scala 152:39]
        if (updown) begin // @[pwm.scala 157:31]
          stop_out <= _GEN_16;
        end else begin
          stop_out <= _GEN_20;
        end
      end
    end
    if (reset) begin // @[pwm.scala 63:32]
      irq_out <= 1'h0; // @[pwm.scala 63:32]
    end else if (!(|io_reg_dat_we)) begin // @[pwm.scala 150:29]
      if (enable) begin // @[pwm.scala 152:39]
        irq_out <= irq_ena & _io_rawirq_out_T_1; // @[pwm.scala 155:17]
      end
    end
    lastenable <= enable; // @[pwm.scala 146:19 59:29]
    if (reset) begin // @[pwm.scala 69:32]
      updown <= 1'h0; // @[pwm.scala 69:32]
    end else if (io_reg_cfg_we) begin // @[pwm.scala 128:23]
      updown <= io_reg_cfg_di[1]; // @[pwm.scala 130:19]
    end
    if (reset) begin // @[pwm.scala 72:32]
      irq_ena <= 1'h0; // @[pwm.scala 72:32]
    end else if (io_reg_cfg_we) begin // @[pwm.scala 128:23]
      irq_ena <= io_reg_cfg_di[2]; // @[pwm.scala 131:19]
    end
    if (reset) begin // @[pwm.scala 75:32]
      pid_out_sel <= 1'h0; // @[pwm.scala 75:32]
    end else if (io_reg_cfg_we) begin // @[pwm.scala 128:23]
      pid_out_sel <= io_reg_cfg_di[3]; // @[pwm.scala 132:19]
    end
    if (reset) begin // @[pwm.scala 78:32]
      pwm_db <= 4'h2; // @[pwm.scala 78:32]
    end else if (io_reg_cfg_we) begin // @[pwm.scala 128:23]
      pwm_db <= _pwm_db_T_2; // @[pwm.scala 133:19]
    end
    step1step <= reset | _GEN_1; // @[pwm.scala 81:{32,32}]
    step1dir <= reset | _GEN_2; // @[pwm.scala 82:{32,32}]
    step2step <= reset | _GEN_3; // @[pwm.scala 83:{32,32}]
    step2dir <= reset | _GEN_4; // @[pwm.scala 84:{32,32}]
    if (pwm_duty >= _GEN_29 & pwm_duty <= _proc_offset_T_2) begin // @[pwm.scala 115:26]
      proc_offset <= pwm_duty;
    end else if (pwm_duty < _GEN_29) begin // @[pwm.scala 116:26]
      proc_offset <= {{27'd0}, pwm_db_twice};
    end else begin
      proc_offset <= _proc_offset_T_2;
    end
    pwm_ld <= value_cur > proc_offset & value_cur < _pwm_ld_T_2; // @[pwm.scala 118:49]
    pwm_hd <= value_cur < _pwm_hd_T_1; // @[pwm.scala 117:33]
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value_cur = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  value_reload = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  pwm_duty = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  reg_duty = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  enable = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  stop_out = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  irq_out = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  lastenable = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  updown = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  irq_ena = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  pid_out_sel = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  pwm_db = _RAND_11[3:0];
  _RAND_12 = {1{`RANDOM}};
  step1step = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  step1dir = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  step2step = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  step2dir = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  proc_offset = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  pwm_ld = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  pwm_hd = _RAND_18[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Quad_Encoder(
  input         clock,
  input         reset,
  input         io_quad_a,
  input         io_quad_b,
  input         io_raw_irq,
  input         io_reg_count_we,
  input  [31:0] io_reg_count_di,
  output [31:0] io_reg_count_do,
  input         io_reg_cfg_we,
  input  [31:0] io_reg_cfg_di,
  output [31:0] io_reg_cfg_do,
  output [15:0] io_reg_speed_do,
  output        io_fb_period
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] quad_a_delayed; // @[qei.scala 35:33]
  reg [2:0] quad_b_delayed; // @[qei.scala 36:33]
  reg [31:0] count_reg; // @[qei.scala 37:33]
  reg [15:0] count_reg_2; // @[qei.scala 38:33]
  reg [15:0] period_count; // @[qei.scala 39:33]
  reg  speed_enable; // @[qei.scala 41:33]
  reg  count_sel_2x; // @[qei.scala 42:33]
  reg [15:0] qei_output; // @[qei.scala 44:33]
  reg [15:0] qei_speed_count; // @[qei.scala 45:33]
  reg [15:0] qei_period_count; // @[qei.scala 46:33]
  reg  period_sel; // @[qei.scala 47:33]
  wire [2:0] _quad_a_delayed_T_2 = {quad_a_delayed[1],quad_a_delayed[0],io_quad_a}; // @[Cat.scala 33:92]
  wire [2:0] _quad_b_delayed_T_2 = {quad_b_delayed[1],quad_b_delayed[0],io_quad_b}; // @[Cat.scala 33:92]
  wire  count_2x = quad_a_delayed[1] ^ quad_a_delayed[2]; // @[qei.scala 54:60]
  wire  count_4x = count_2x ^ quad_b_delayed[1] ^ quad_b_delayed[2]; // @[qei.scala 55:96]
  wire  count_direction = quad_a_delayed[1] ^ quad_b_delayed[2]; // @[qei.scala 56:60]
  wire  count_pulses = count_sel_2x ? count_2x : count_4x; // @[qei.scala 57:29]
  wire [31:0] _count_reg_T_1 = count_reg + 32'h1; // @[qei.scala 64:36]
  wire [31:0] _count_reg_T_3 = count_reg - 32'h1; // @[qei.scala 66:36]
  wire [15:0] _count_reg_2_T_1 = count_reg_2 + 16'h1; // @[qei.scala 76:38]
  wire [15:0] _period_count_T_1 = period_count + 16'h1; // @[qei.scala 89:40]
  wire [1:0] io_reg_cfg_do_lo = {speed_enable,count_sel_2x}; // @[Cat.scala 33:92]
  wire [29:0] io_reg_cfg_do_hi = {29'h0,period_sel}; // @[Cat.scala 33:92]
  wire  _GEN_12 = io_reg_cfg_we ? io_reg_cfg_di[0] : count_sel_2x; // @[qei.scala 105:28 106:24 42:33]
  wire  _GEN_13 = io_reg_cfg_we ? io_reg_cfg_di[1] : speed_enable; // @[qei.scala 105:28 107:24 41:33]
  wire  _GEN_16 = io_reg_count_we ? count_sel_2x : _GEN_12; // @[qei.scala 103:25 42:33]
  wire  _GEN_17 = io_reg_count_we ? speed_enable : _GEN_13; // @[qei.scala 103:25 41:33]
  assign io_reg_count_do = count_reg; // @[qei.scala 49:23]
  assign io_reg_cfg_do = {io_reg_cfg_do_hi,io_reg_cfg_do_lo}; // @[Cat.scala 33:92]
  assign io_reg_speed_do = qei_output; // @[qei.scala 100:50]
  assign io_fb_period = period_sel; // @[qei.scala 101:24]
  always @(posedge clock) begin
    if (reset) begin // @[qei.scala 35:33]
      quad_a_delayed <= 3'h0; // @[qei.scala 35:33]
    end else begin
      quad_a_delayed <= _quad_a_delayed_T_2; // @[qei.scala 51:23]
    end
    if (reset) begin // @[qei.scala 36:33]
      quad_b_delayed <= 3'h0; // @[qei.scala 36:33]
    end else begin
      quad_b_delayed <= _quad_b_delayed_T_2; // @[qei.scala 52:23]
    end
    if (reset) begin // @[qei.scala 37:33]
      count_reg <= 32'h0; // @[qei.scala 37:33]
    end else if (io_reg_count_we) begin // @[qei.scala 103:25]
      count_reg <= io_reg_count_di; // @[qei.scala 104:24]
    end else if (count_pulses) begin // @[qei.scala 62:22]
      if (count_direction) begin // @[qei.scala 63:27]
        count_reg <= _count_reg_T_1; // @[qei.scala 64:23]
      end else begin
        count_reg <= _count_reg_T_3; // @[qei.scala 66:23]
      end
    end
    if (reset) begin // @[qei.scala 38:33]
      count_reg_2 <= 16'h0; // @[qei.scala 38:33]
    end else if (io_raw_irq | count_pulses) begin // @[qei.scala 71:37]
      if (io_raw_irq) begin // @[qei.scala 72:23]
        count_reg_2 <= 16'h0; // @[qei.scala 74:23]
      end else begin
        count_reg_2 <= _count_reg_2_T_1; // @[qei.scala 76:23]
      end
    end
    if (reset) begin // @[qei.scala 39:33]
      period_count <= 16'h0; // @[qei.scala 39:33]
    end else if (period_sel) begin // @[qei.scala 81:20]
      if (count_pulses) begin // @[qei.scala 82:24]
        period_count <= 16'h0; // @[qei.scala 84:24]
      end else if (period_count == 16'hff) begin // @[qei.scala 85:40]
        period_count <= 16'h0; // @[qei.scala 87:24]
      end else begin
        period_count <= _period_count_T_1; // @[qei.scala 89:24]
      end
    end
    speed_enable <= reset | _GEN_17; // @[qei.scala 41:{33,33}]
    count_sel_2x <= reset | _GEN_16; // @[qei.scala 42:{33,33}]
    if (reset) begin // @[qei.scala 44:33]
      qei_output <= 16'h0; // @[qei.scala 44:33]
    end else if (period_sel) begin // @[qei.scala 94:30]
      qei_output <= qei_period_count;
    end else begin
      qei_output <= qei_speed_count;
    end
    if (reset) begin // @[qei.scala 45:33]
      qei_speed_count <= 16'h0; // @[qei.scala 45:33]
    end else if (io_raw_irq | count_pulses) begin // @[qei.scala 71:37]
      if (io_raw_irq) begin // @[qei.scala 72:23]
        qei_speed_count <= count_reg_2; // @[qei.scala 73:23]
      end
    end
    if (reset) begin // @[qei.scala 46:33]
      qei_period_count <= 16'h1fff; // @[qei.scala 46:33]
    end else if (period_sel) begin // @[qei.scala 81:20]
      if (count_pulses) begin // @[qei.scala 82:24]
        qei_period_count <= period_count; // @[qei.scala 83:24]
      end else if (period_count == 16'hff) begin // @[qei.scala 85:40]
        qei_period_count <= period_count; // @[qei.scala 86:24]
      end
    end
    if (reset) begin // @[qei.scala 47:33]
      period_sel <= 1'h0; // @[qei.scala 47:33]
    end else if (!(io_reg_count_we)) begin // @[qei.scala 103:25]
      if (io_reg_cfg_we) begin // @[qei.scala 105:28]
        period_sel <= io_reg_cfg_di[2]; // @[qei.scala 108:24]
      end
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  quad_a_delayed = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  quad_b_delayed = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  count_reg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  count_reg_2 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  period_count = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  speed_enable = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  count_sel_2x = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  qei_output = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  qei_speed_count = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  qei_period_count = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  period_sel = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module vedic_2x2(
  input  [1:0] io_a,
  input  [1:0] io_b,
  output [3:0] io_c
);
  wire  result0 = io_a[0] & io_b[0]; // @[multiplier.scala 25:25]
  wire  a1b0 = io_a[1] & io_b[0]; // @[multiplier.scala 26:24]
  wire  a0b1 = io_a[0] & io_b[1]; // @[multiplier.scala 27:24]
  wire  a1b1 = io_a[1] & io_b[1]; // @[multiplier.scala 28:24]
  wire  result1 = a1b0 ^ a0b1; // @[multiplier.scala 31:22]
  wire  carry1 = a1b0 & a0b1; // @[multiplier.scala 32:23]
  wire  result2 = a1b1 ^ carry1; // @[multiplier.scala 34:22]
  wire  result3 = a1b1 & carry1; // @[multiplier.scala 35:22]
  wire [1:0] io_c_lo = {result1,result0}; // @[Cat.scala 33:92]
  wire [1:0] io_c_hi = {result3,result2}; // @[Cat.scala 33:92]
  assign io_c = {io_c_hi,io_c_lo}; // @[Cat.scala 33:92]
endmodule
module vedic_4x4(
  input  [3:0] io_a,
  input  [3:0] io_b,
  output [7:0] io_c
);
  wire [1:0] pp_1_io_a; // @[multiplier.scala 59:25]
  wire [1:0] pp_1_io_b; // @[multiplier.scala 59:25]
  wire [3:0] pp_1_io_c; // @[multiplier.scala 59:25]
  wire [1:0] pp_2_io_a; // @[multiplier.scala 64:25]
  wire [1:0] pp_2_io_b; // @[multiplier.scala 64:25]
  wire [3:0] pp_2_io_c; // @[multiplier.scala 64:25]
  wire [1:0] pp_3_io_a; // @[multiplier.scala 68:25]
  wire [1:0] pp_3_io_b; // @[multiplier.scala 68:25]
  wire [3:0] pp_3_io_c; // @[multiplier.scala 68:25]
  wire [1:0] pp_4_io_a; // @[multiplier.scala 73:25]
  wire [1:0] pp_4_io_b; // @[multiplier.scala 73:25]
  wire [3:0] pp_4_io_c; // @[multiplier.scala 73:25]
  wire [3:0] pp_hl = pp_2_io_c; // @[multiplier.scala 50:24 67:18]
  wire [3:0] pp_ll = pp_1_io_c; // @[multiplier.scala 49:24 62:18]
  wire [3:0] _psum_1_T_2 = {2'h0,pp_ll[3:2]}; // @[Cat.scala 33:92]
  wire [3:0] psum_1 = pp_hl + _psum_1_T_2; // @[multiplier.scala 79:31]
  wire [3:0] pp_hh = pp_4_io_c; // @[multiplier.scala 52:24 76:17]
  wire [5:0] _psum_2_T_1 = {pp_hh,2'h0}; // @[Cat.scala 33:92]
  wire [3:0] pp_lh = pp_3_io_c; // @[multiplier.scala 51:24 71:18]
  wire [5:0] _psum_2_T_3 = {2'h0,pp_lh}; // @[Cat.scala 33:92]
  wire [5:0] psum_2 = _psum_2_T_1 + _psum_2_T_3; // @[multiplier.scala 80:56]
  wire [5:0] _psum_3_T_1 = {2'h0,psum_1}; // @[Cat.scala 33:92]
  wire [5:0] psum_3 = _psum_3_T_1 + psum_2; // @[multiplier.scala 81:57]
  wire [1:0] result1 = pp_ll[1:0]; // @[multiplier.scala 83:22]
  vedic_2x2 pp_1 ( // @[multiplier.scala 59:25]
    .io_a(pp_1_io_a),
    .io_b(pp_1_io_b),
    .io_c(pp_1_io_c)
  );
  vedic_2x2 pp_2 ( // @[multiplier.scala 64:25]
    .io_a(pp_2_io_a),
    .io_b(pp_2_io_b),
    .io_c(pp_2_io_c)
  );
  vedic_2x2 pp_3 ( // @[multiplier.scala 68:25]
    .io_a(pp_3_io_a),
    .io_b(pp_3_io_b),
    .io_c(pp_3_io_c)
  );
  vedic_2x2 pp_4 ( // @[multiplier.scala 73:25]
    .io_a(pp_4_io_a),
    .io_b(pp_4_io_b),
    .io_c(pp_4_io_c)
  );
  assign io_c = {psum_3,result1}; // @[Cat.scala 33:92]
  assign pp_1_io_a = io_a[1:0]; // @[multiplier.scala 60:24]
  assign pp_1_io_b = io_b[1:0]; // @[multiplier.scala 61:24]
  assign pp_2_io_a = io_a[3:2]; // @[multiplier.scala 65:24]
  assign pp_2_io_b = io_b[1:0]; // @[multiplier.scala 66:24]
  assign pp_3_io_a = io_a[1:0]; // @[multiplier.scala 69:24]
  assign pp_3_io_b = io_b[3:2]; // @[multiplier.scala 70:24]
  assign pp_4_io_a = io_a[3:2]; // @[multiplier.scala 74:24]
  assign pp_4_io_b = io_b[3:2]; // @[multiplier.scala 75:24]
endmodule
module vedic_8x8(
  input  [7:0]  io_a,
  input  [7:0]  io_b,
  output [15:0] io_c
);
  wire [3:0] pp_1_io_a; // @[multiplier.scala 166:24]
  wire [3:0] pp_1_io_b; // @[multiplier.scala 166:24]
  wire [7:0] pp_1_io_c; // @[multiplier.scala 166:24]
  wire [3:0] pp_2_io_a; // @[multiplier.scala 171:24]
  wire [3:0] pp_2_io_b; // @[multiplier.scala 171:24]
  wire [7:0] pp_2_io_c; // @[multiplier.scala 171:24]
  wire [3:0] pp_3_io_a; // @[multiplier.scala 176:24]
  wire [3:0] pp_3_io_b; // @[multiplier.scala 176:24]
  wire [7:0] pp_3_io_c; // @[multiplier.scala 176:24]
  wire [3:0] pp_4_io_a; // @[multiplier.scala 181:24]
  wire [3:0] pp_4_io_b; // @[multiplier.scala 181:24]
  wire [7:0] pp_4_io_c; // @[multiplier.scala 181:24]
  wire [15:0] pp_hl = {{8'd0}, pp_2_io_c}; // @[multiplier.scala 155:23 174:17]
  wire [15:0] pp_ll = {{8'd0}, pp_1_io_c}; // @[multiplier.scala 154:23 169:17]
  wire [7:0] _psum_1_T_2 = {4'h0,pp_ll[7:4]}; // @[Cat.scala 33:92]
  wire [7:0] psum_1 = pp_hl[7:0] + _psum_1_T_2; // @[multiplier.scala 188:32]
  wire [15:0] pp_hh = {{8'd0}, pp_4_io_c}; // @[multiplier.scala 157:23 184:17]
  wire [11:0] _psum_2_T_1 = {pp_hh[7:0],4'h0}; // @[Cat.scala 33:92]
  wire [15:0] pp_lh = {{8'd0}, pp_3_io_c}; // @[multiplier.scala 156:23 179:17]
  wire [11:0] _psum_2_T_3 = {4'h0,pp_lh[7:0]}; // @[Cat.scala 33:92]
  wire [11:0] psum_2 = _psum_2_T_1 + _psum_2_T_3; // @[multiplier.scala 189:57]
  wire [11:0] _psum_3_T_1 = {4'h0,psum_1}; // @[Cat.scala 33:92]
  wire [11:0] psum_3 = _psum_3_T_1 + psum_2; // @[multiplier.scala 190:58]
  wire [3:0] result1 = pp_ll[3:0]; // @[multiplier.scala 192:22]
  vedic_4x4 pp_1 ( // @[multiplier.scala 166:24]
    .io_a(pp_1_io_a),
    .io_b(pp_1_io_b),
    .io_c(pp_1_io_c)
  );
  vedic_4x4 pp_2 ( // @[multiplier.scala 171:24]
    .io_a(pp_2_io_a),
    .io_b(pp_2_io_b),
    .io_c(pp_2_io_c)
  );
  vedic_4x4 pp_3 ( // @[multiplier.scala 176:24]
    .io_a(pp_3_io_a),
    .io_b(pp_3_io_b),
    .io_c(pp_3_io_c)
  );
  vedic_4x4 pp_4 ( // @[multiplier.scala 181:24]
    .io_a(pp_4_io_a),
    .io_b(pp_4_io_b),
    .io_c(pp_4_io_c)
  );
  assign io_c = {psum_3,result1}; // @[Cat.scala 33:92]
  assign pp_1_io_a = io_a[3:0]; // @[multiplier.scala 167:25]
  assign pp_1_io_b = io_b[3:0]; // @[multiplier.scala 168:23]
  assign pp_2_io_a = io_a[7:4]; // @[multiplier.scala 172:25]
  assign pp_2_io_b = io_b[3:0]; // @[multiplier.scala 173:23]
  assign pp_3_io_a = io_a[3:0]; // @[multiplier.scala 177:25]
  assign pp_3_io_b = io_b[7:4]; // @[multiplier.scala 178:23]
  assign pp_4_io_a = io_a[7:4]; // @[multiplier.scala 182:25]
  assign pp_4_io_b = io_b[7:4]; // @[multiplier.scala 183:23]
endmodule
module vedic_16x16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  output [31:0] io_c
);
  wire [7:0] pp_1_io_a; // @[multiplier.scala 221:32]
  wire [7:0] pp_1_io_b; // @[multiplier.scala 221:32]
  wire [15:0] pp_1_io_c; // @[multiplier.scala 221:32]
  wire [7:0] pp_2_io_a; // @[multiplier.scala 226:32]
  wire [7:0] pp_2_io_b; // @[multiplier.scala 226:32]
  wire [15:0] pp_2_io_c; // @[multiplier.scala 226:32]
  wire [7:0] pp_3_io_a; // @[multiplier.scala 231:32]
  wire [7:0] pp_3_io_b; // @[multiplier.scala 231:32]
  wire [15:0] pp_3_io_c; // @[multiplier.scala 231:32]
  wire [3:0] pp_4_io_a; // @[multiplier.scala 236:32]
  wire [3:0] pp_4_io_b; // @[multiplier.scala 236:32]
  wire [7:0] pp_4_io_c; // @[multiplier.scala 236:32]
  wire [15:0] _in1_complement_T_2 = ~io_a; // @[multiplier.scala 217:38]
  wire [15:0] in1_complement = _in1_complement_T_2 + 16'h1; // @[multiplier.scala 217:41]
  wire [15:0] input1 = io_a[15] ? in1_complement : io_a; // @[multiplier.scala 218:27]
  wire [15:0] pp_hl = pp_2_io_c; // @[multiplier.scala 209:31 229:25]
  wire [15:0] pp_ll = pp_1_io_c; // @[multiplier.scala 208:31 224:25]
  wire [15:0] _psum_1_T_2 = {8'h0,pp_ll[15:8]}; // @[Cat.scala 33:92]
  wire [15:0] psum_1 = pp_hl + _psum_1_T_2; // @[multiplier.scala 242:29]
  wire [15:0] pp_hh = {{8'd0}, pp_4_io_c}; // @[multiplier.scala 211:31 239:25]
  wire [23:0] _psum_2_T_1 = {pp_hh,8'h0}; // @[Cat.scala 33:92]
  wire [15:0] pp_lh = pp_3_io_c; // @[multiplier.scala 210:31 234:25]
  wire [23:0] _psum_2_T_3 = {8'h0,pp_lh}; // @[Cat.scala 33:92]
  wire [23:0] psum_2 = _psum_2_T_1 + _psum_2_T_3; // @[multiplier.scala 243:54]
  wire [23:0] _psum_3_T_1 = {8'h0,psum_1}; // @[Cat.scala 33:92]
  wire [23:0] psum_3 = _psum_3_T_1 + psum_2; // @[multiplier.scala 244:56]
  wire [7:0] result1 = pp_ll[7:0]; // @[multiplier.scala 246:29]
  wire [31:0] result = {psum_3,result1}; // @[Cat.scala 33:92]
  wire [31:0] _result_complement_T_1 = ~result; // @[multiplier.scala 249:43]
  wire [31:0] result_complement = $signed(_result_complement_T_1) + 32'sh1; // @[multiplier.scala 249:46]
  wire [31:0] _result_final_T_1 = {psum_3,result1}; // @[multiplier.scala 251:70]
  vedic_8x8 pp_1 ( // @[multiplier.scala 221:32]
    .io_a(pp_1_io_a),
    .io_b(pp_1_io_b),
    .io_c(pp_1_io_c)
  );
  vedic_8x8 pp_2 ( // @[multiplier.scala 226:32]
    .io_a(pp_2_io_a),
    .io_b(pp_2_io_b),
    .io_c(pp_2_io_c)
  );
  vedic_8x8 pp_3 ( // @[multiplier.scala 231:32]
    .io_a(pp_3_io_a),
    .io_b(pp_3_io_b),
    .io_c(pp_3_io_c)
  );
  vedic_4x4 pp_4 ( // @[multiplier.scala 236:32]
    .io_a(pp_4_io_a),
    .io_b(pp_4_io_b),
    .io_c(pp_4_io_c)
  );
  assign io_c = io_a[15] ? $signed(result_complement) : $signed(_result_final_T_1); // @[multiplier.scala 251:27]
  assign pp_1_io_a = input1[7:0]; // @[multiplier.scala 222:33]
  assign pp_1_io_b = io_b[7:0]; // @[multiplier.scala 223:31]
  assign pp_2_io_a = input1[15:8]; // @[multiplier.scala 227:33]
  assign pp_2_io_b = io_b[7:0]; // @[multiplier.scala 228:31]
  assign pp_3_io_a = input1[7:0]; // @[multiplier.scala 232:33]
  assign pp_3_io_b = io_b[15:8]; // @[multiplier.scala 233:31]
  assign pp_4_io_a = input1[11:8]; // @[multiplier.scala 237:24]
  assign pp_4_io_b = io_b[11:8]; // @[multiplier.scala 238:24]
endmodule
module PID_Controller(
  input         clock,
  input         reset,
  input         io_fb_period,
  input         io_raw_irq,
  input         io_reg_kp_we,
  input  [15:0] io_reg_kp_di,
  output [15:0] io_reg_kp_do,
  input         io_reg_ki_we,
  input  [15:0] io_reg_ki_di,
  output [15:0] io_reg_ki_do,
  input         io_reg_kd_we,
  input  [15:0] io_reg_kd_di,
  output [15:0] io_reg_kd_do,
  input         io_reg_ref_we,
  input  [15:0] io_reg_ref_di,
  output [15:0] io_reg_ref_do,
  input         io_reg_fb_we,
  input  [15:0] io_reg_fb_di,
  output [15:0] io_reg_fb_do,
  input         io_reg_cfg_we,
  input  [15:0] io_reg_cfg_di,
  output [15:0] io_reg_cfg_do,
  input  [15:0] io_speed_fb_in,
  output [15:0] io_pid_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] mul_kp_io_a; // @[pid.scala 110:25]
  wire [15:0] mul_kp_io_b; // @[pid.scala 110:25]
  wire [31:0] mul_kp_io_c; // @[pid.scala 110:25]
  wire [15:0] mul_ki_io_a; // @[pid.scala 116:25]
  wire [15:0] mul_ki_io_b; // @[pid.scala 116:25]
  wire [31:0] mul_ki_io_c; // @[pid.scala 116:25]
  wire [15:0] mul_kd_io_a; // @[pid.scala 122:25]
  wire [15:0] mul_kd_io_b; // @[pid.scala 122:25]
  wire [31:0] mul_kd_io_c; // @[pid.scala 122:25]
  reg [15:0] kp; // @[pid.scala 56:26]
  reg [15:0] ki; // @[pid.scala 57:26]
  reg [15:0] kd; // @[pid.scala 58:26]
  reg [15:0] ref_; // @[pid.scala 59:26]
  reg [15:0] feedback; // @[pid.scala 60:26]
  reg [15:0] sigma_old; // @[pid.scala 61:26]
  reg  fb_sel; // @[pid.scala 62:26]
  reg [15:0] e_prev1; // @[pid.scala 64:26]
  reg [15:0] e_prev2; // @[pid.scala 65:26]
  reg [15:0] reg_pid_out; // @[pid.scala 66:28]
  wire [31:0] _io_reg_cfg_do_T_1 = {31'h0,fb_sel}; // @[pid.scala 100:49]
  wire [15:0] sigma_new = $signed(e_prev1) + $signed(sigma_old); // @[pid.scala 107:27]
  wire [15:0] prop_out = mul_kp_io_c[15:0]; // @[pid.scala 113:43]
  wire [15:0] integral_out = mul_ki_io_c[15:0]; // @[pid.scala 119:46]
  wire [15:0] derivative_out = mul_kd_io_c[15:0]; // @[pid.scala 125:48]
  wire [15:0] pi_sum = $signed(prop_out) + $signed(integral_out); // @[pid.scala 128:28]
  wire  _pi_sum_overflow_T_12 = ~prop_out[15] & ~integral_out[15] & pi_sum[15]; // @[pid.scala 130:61]
  wire  pi_sum_overflow = prop_out[15] & integral_out[15] & ~pi_sum[15] | _pi_sum_overflow_T_12; // @[pid.scala 129:75]
  wire [15:0] _e_prev1_T_2 = $signed(feedback) - $signed(ref_); // @[pid.scala 135:29]
  wire [15:0] _e_prev1_T_5 = $signed(ref_) - $signed(feedback); // @[pid.scala 137:24]
  wire [15:0] _reg_pid_out_T_2 = $signed(pi_sum) + $signed(derivative_out); // @[pid.scala 141:27]
  vedic_16x16 mul_kp ( // @[pid.scala 110:25]
    .io_a(mul_kp_io_a),
    .io_b(mul_kp_io_b),
    .io_c(mul_kp_io_c)
  );
  vedic_16x16 mul_ki ( // @[pid.scala 116:25]
    .io_a(mul_ki_io_a),
    .io_b(mul_ki_io_b),
    .io_c(mul_ki_io_c)
  );
  vedic_16x16 mul_kd ( // @[pid.scala 122:25]
    .io_a(mul_kd_io_a),
    .io_b(mul_kd_io_b),
    .io_c(mul_kd_io_c)
  );
  assign io_reg_kp_do = kp; // @[pid.scala 69:17]
  assign io_reg_ki_do = ki; // @[pid.scala 74:17]
  assign io_reg_kd_do = kd; // @[pid.scala 79:17]
  assign io_reg_ref_do = ref_; // @[pid.scala 85:17]
  assign io_reg_fb_do = feedback; // @[pid.scala 90:17]
  assign io_reg_cfg_do = _io_reg_cfg_do_T_1[15:0]; // @[pid.scala 100:17]
  assign io_pid_out = pi_sum_overflow | reg_pid_out[15] ? $signed(16'sh0) : $signed(reg_pid_out); // @[pid.scala 144:23]
  assign mul_kp_io_a = e_prev1; // @[pid.scala 111:17]
  assign mul_kp_io_b = kp; // @[pid.scala 112:29]
  assign mul_ki_io_a = $signed(e_prev1) + $signed(sigma_old); // @[pid.scala 107:27]
  assign mul_ki_io_b = ki; // @[pid.scala 118:29]
  assign mul_kd_io_a = $signed(e_prev1) - $signed(e_prev2); // @[pid.scala 106:27]
  assign mul_kd_io_b = kd; // @[pid.scala 124:29]
  always @(posedge clock) begin
    if (reset) begin // @[pid.scala 56:26]
      kp <= 16'sh1; // @[pid.scala 56:26]
    end else if (io_reg_kp_we) begin // @[pid.scala 70:22]
      kp <= io_reg_kp_di; // @[pid.scala 71:8]
    end
    if (reset) begin // @[pid.scala 57:26]
      ki <= 16'sh0; // @[pid.scala 57:26]
    end else if (io_reg_ki_we) begin // @[pid.scala 75:22]
      ki <= io_reg_ki_di; // @[pid.scala 76:8]
    end
    if (reset) begin // @[pid.scala 58:26]
      kd <= 16'sh0; // @[pid.scala 58:26]
    end else if (io_reg_kd_we) begin // @[pid.scala 80:22]
      kd <= io_reg_kd_di; // @[pid.scala 81:8]
    end
    if (reset) begin // @[pid.scala 59:26]
      ref_ <= 16'sh14; // @[pid.scala 59:26]
    end else if (io_reg_ref_we) begin // @[pid.scala 86:23]
      ref_ <= io_reg_ref_di; // @[pid.scala 87:9]
    end
    if (reset) begin // @[pid.scala 60:26]
      feedback <= 16'sh0; // @[pid.scala 60:26]
    end else if (fb_sel) begin // @[pid.scala 92:16]
      if (io_reg_fb_we) begin // @[pid.scala 93:24]
        feedback <= io_reg_fb_di; // @[pid.scala 94:15]
      end
    end else begin
      feedback <= io_speed_fb_in; // @[pid.scala 97:15]
    end
    if (reset) begin // @[pid.scala 61:26]
      sigma_old <= 16'sh0; // @[pid.scala 61:26]
    end else if (io_raw_irq) begin // @[pid.scala 132:20]
      sigma_old <= sigma_new; // @[pid.scala 140:17]
    end
    if (reset) begin // @[pid.scala 62:26]
      fb_sel <= 1'h0; // @[pid.scala 62:26]
    end else if (io_reg_cfg_we) begin // @[pid.scala 101:23]
      fb_sel <= io_reg_cfg_di[0]; // @[pid.scala 102:12]
    end
    if (reset) begin // @[pid.scala 64:26]
      e_prev1 <= 16'sh0; // @[pid.scala 64:26]
    end else if (io_raw_irq) begin // @[pid.scala 132:20]
      if (io_fb_period) begin // @[pid.scala 134:23]
        e_prev1 <= _e_prev1_T_2; // @[pid.scala 135:17]
      end else begin
        e_prev1 <= _e_prev1_T_5; // @[pid.scala 137:17]
      end
    end
    if (reset) begin // @[pid.scala 65:26]
      e_prev2 <= 16'sh0; // @[pid.scala 65:26]
    end else if (io_raw_irq) begin // @[pid.scala 132:20]
      e_prev2 <= e_prev1; // @[pid.scala 139:17]
    end
    if (reset) begin // @[pid.scala 66:28]
      reg_pid_out <= 16'sh0; // @[pid.scala 66:28]
    end else if (io_raw_irq) begin // @[pid.scala 132:20]
      reg_pid_out <= _reg_pid_out_T_2; // @[pid.scala 141:17]
    end
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  kp = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  ki = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  kd = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  ref_ = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  feedback = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  sigma_old = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  fb_sel = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  e_prev1 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  e_prev2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  reg_pid_out = _RAND_9[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Motor_Top(
  input         clock,
  input         reset,
  input  [15:0] io_wbs_m2s_addr,
  input  [31:0] io_wbs_m2s_data,
  input         io_wbs_m2s_we,
  input  [3:0]  io_wbs_m2s_sel,
  input         io_wbs_m2s_stb,
  output        io_wbs_ack_o,
  output [31:0] io_wbs_data_o,
  input         io_motor_gpio_qei_ch_a,
  input         io_motor_gpio_qei_ch_b,
  output        io_motor_gpio_pwm_high,
  output        io_motor_gpio_pwm_low,
  input         io_motor_gpio_x_homed,
  input         io_motor_gpio_y_homed,
  output        io_motor_gpio_step1step,
  output        io_motor_gpio_step2step,
  output        io_motor_gpio_step1dir,
  output        io_motor_gpio_step2dir,
  input         io_motor_select,
  output        io_motor_irq
);
  wire  interlink_clock; // @[motor_top.scala 53:26]
  wire  interlink_reset; // @[motor_top.scala 53:26]
  wire [31:0] interlink_io_bus_adr_i; // @[motor_top.scala 53:26]
  wire [3:0] interlink_io_bus_sel_i; // @[motor_top.scala 53:26]
  wire  interlink_io_bus_we_i; // @[motor_top.scala 53:26]
  wire  interlink_io_bus_stb_i; // @[motor_top.scala 53:26]
  wire  interlink_io_bus_ack_o; // @[motor_top.scala 53:26]
  wire [31:0] interlink_io_bus_dat_o; // @[motor_top.scala 53:26]
  wire  interlink_io_tmr_val_we; // @[motor_top.scala 53:26]
  wire [31:0] interlink_io_tmr_val_do; // @[motor_top.scala 53:26]
  wire  interlink_io_tmr_dat_we; // @[motor_top.scala 53:26]
  wire [31:0] interlink_io_tmr_dat_do; // @[motor_top.scala 53:26]
  wire  interlink_io_tmr_duty_we; // @[motor_top.scala 53:26]
  wire [31:0] interlink_io_tmr_duty_do; // @[motor_top.scala 53:26]
  wire  interlink_io_tmr_cfg_we; // @[motor_top.scala 53:26]
  wire [31:0] interlink_io_tmr_cfg_do; // @[motor_top.scala 53:26]
  wire  interlink_io_tmr_step_we; // @[motor_top.scala 53:26]
  wire [31:0] interlink_io_tmr_step_do; // @[motor_top.scala 53:26]
  wire  interlink_io_qei_count_we; // @[motor_top.scala 53:26]
  wire [31:0] interlink_io_qei_count_do; // @[motor_top.scala 53:26]
  wire  interlink_io_qei_cfg_we; // @[motor_top.scala 53:26]
  wire [31:0] interlink_io_qei_cfg_do; // @[motor_top.scala 53:26]
  wire [15:0] interlink_io_qei_speed_do; // @[motor_top.scala 53:26]
  wire  interlink_io_pid_kp_we; // @[motor_top.scala 53:26]
  wire [15:0] interlink_io_pid_kp_do; // @[motor_top.scala 53:26]
  wire  interlink_io_pid_ki_we; // @[motor_top.scala 53:26]
  wire [15:0] interlink_io_pid_ki_do; // @[motor_top.scala 53:26]
  wire  interlink_io_pid_kd_we; // @[motor_top.scala 53:26]
  wire [15:0] interlink_io_pid_kd_do; // @[motor_top.scala 53:26]
  wire  interlink_io_pid_ref_we; // @[motor_top.scala 53:26]
  wire [15:0] interlink_io_pid_ref_do; // @[motor_top.scala 53:26]
  wire  interlink_io_pid_fb_we; // @[motor_top.scala 53:26]
  wire [15:0] interlink_io_pid_fb_do; // @[motor_top.scala 53:26]
  wire  interlink_io_pid_cfg_we; // @[motor_top.scala 53:26]
  wire [15:0] interlink_io_pid_cfg_do; // @[motor_top.scala 53:26]
  wire  interlink_io_motor_select; // @[motor_top.scala 53:26]
  wire  pwm_clock; // @[motor_top.scala 69:37]
  wire  pwm_reset; // @[motor_top.scala 69:37]
  wire  pwm_io_reg_val_we; // @[motor_top.scala 69:37]
  wire [31:0] pwm_io_reg_val_di; // @[motor_top.scala 69:37]
  wire [31:0] pwm_io_reg_val_do; // @[motor_top.scala 69:37]
  wire  pwm_io_reg_cfg_we; // @[motor_top.scala 69:37]
  wire [31:0] pwm_io_reg_cfg_di; // @[motor_top.scala 69:37]
  wire [31:0] pwm_io_reg_cfg_do; // @[motor_top.scala 69:37]
  wire  pwm_io_reg_dat_we; // @[motor_top.scala 69:37]
  wire [31:0] pwm_io_reg_dat_di; // @[motor_top.scala 69:37]
  wire [31:0] pwm_io_reg_dat_do; // @[motor_top.scala 69:37]
  wire  pwm_io_reg_duty_we; // @[motor_top.scala 69:37]
  wire [31:0] pwm_io_reg_duty_di; // @[motor_top.scala 69:37]
  wire [31:0] pwm_io_reg_duty_do; // @[motor_top.scala 69:37]
  wire  pwm_io_reg_step_we; // @[motor_top.scala 69:37]
  wire [31:0] pwm_io_reg_step_do; // @[motor_top.scala 69:37]
  wire [15:0] pwm_io_reg_pid_out; // @[motor_top.scala 69:37]
  wire  pwm_io_pwm_h; // @[motor_top.scala 69:37]
  wire  pwm_io_pwm_l; // @[motor_top.scala 69:37]
  wire  pwm_io_irq_out; // @[motor_top.scala 69:37]
  wire  pwm_io_rawirq_out; // @[motor_top.scala 69:37]
  wire  pwm_io_x_homed; // @[motor_top.scala 69:37]
  wire  pwm_io_y_homed; // @[motor_top.scala 69:37]
  wire  qei_clock; // @[motor_top.scala 110:37]
  wire  qei_reset; // @[motor_top.scala 110:37]
  wire  qei_io_quad_a; // @[motor_top.scala 110:37]
  wire  qei_io_quad_b; // @[motor_top.scala 110:37]
  wire  qei_io_raw_irq; // @[motor_top.scala 110:37]
  wire  qei_io_reg_count_we; // @[motor_top.scala 110:37]
  wire [31:0] qei_io_reg_count_di; // @[motor_top.scala 110:37]
  wire [31:0] qei_io_reg_count_do; // @[motor_top.scala 110:37]
  wire  qei_io_reg_cfg_we; // @[motor_top.scala 110:37]
  wire [31:0] qei_io_reg_cfg_di; // @[motor_top.scala 110:37]
  wire [31:0] qei_io_reg_cfg_do; // @[motor_top.scala 110:37]
  wire [15:0] qei_io_reg_speed_do; // @[motor_top.scala 110:37]
  wire  qei_io_fb_period; // @[motor_top.scala 110:37]
  wire  pid_clock; // @[motor_top.scala 126:37]
  wire  pid_reset; // @[motor_top.scala 126:37]
  wire  pid_io_fb_period; // @[motor_top.scala 126:37]
  wire  pid_io_raw_irq; // @[motor_top.scala 126:37]
  wire  pid_io_reg_kp_we; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_kp_di; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_kp_do; // @[motor_top.scala 126:37]
  wire  pid_io_reg_ki_we; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_ki_di; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_ki_do; // @[motor_top.scala 126:37]
  wire  pid_io_reg_kd_we; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_kd_di; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_kd_do; // @[motor_top.scala 126:37]
  wire  pid_io_reg_ref_we; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_ref_di; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_ref_do; // @[motor_top.scala 126:37]
  wire  pid_io_reg_fb_we; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_fb_di; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_fb_do; // @[motor_top.scala 126:37]
  wire  pid_io_reg_cfg_we; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_cfg_di; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_reg_cfg_do; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_speed_fb_in; // @[motor_top.scala 126:37]
  wire [15:0] pid_io_pid_out; // @[motor_top.scala 126:37]
  wire [7:0] _pid_io_reg_kp_di_T_1 = io_wbs_m2s_data[7:0]; // @[motor_top.scala 131:53]
  Interlink_Module interlink ( // @[motor_top.scala 53:26]
    .clock(interlink_clock),
    .reset(interlink_reset),
    .io_bus_adr_i(interlink_io_bus_adr_i),
    .io_bus_sel_i(interlink_io_bus_sel_i),
    .io_bus_we_i(interlink_io_bus_we_i),
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
    .io_tmr_step_we(interlink_io_tmr_step_we),
    .io_tmr_step_do(interlink_io_tmr_step_do),
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
  PWM pwm ( // @[motor_top.scala 69:37]
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
    .io_reg_step_we(pwm_io_reg_step_we),
    .io_reg_step_do(pwm_io_reg_step_do),
    .io_reg_pid_out(pwm_io_reg_pid_out),
    .io_pwm_h(pwm_io_pwm_h),
    .io_pwm_l(pwm_io_pwm_l),
    .io_irq_out(pwm_io_irq_out),
    .io_rawirq_out(pwm_io_rawirq_out),
    .io_x_homed(pwm_io_x_homed),
    .io_y_homed(pwm_io_y_homed)
  );
  Quad_Encoder qei ( // @[motor_top.scala 110:37]
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
  PID_Controller pid ( // @[motor_top.scala 126:37]
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
  assign io_wbs_ack_o = interlink_io_bus_ack_o; // @[motor_top.scala 66:29]
  assign io_wbs_data_o = interlink_io_bus_dat_o; // @[motor_top.scala 65:29]
  assign io_motor_gpio_pwm_high = pwm_io_pwm_h; // @[motor_top.scala 105:29]
  assign io_motor_gpio_pwm_low = pwm_io_pwm_l; // @[motor_top.scala 106:29]
  assign io_motor_gpio_step1step = pwm_io_reg_step_do[5]; // @[motor_top.scala 93:50]
  assign io_motor_gpio_step2step = pwm_io_reg_step_do[3]; // @[motor_top.scala 95:50]
  assign io_motor_gpio_step1dir = pwm_io_reg_step_do[4]; // @[motor_top.scala 94:50]
  assign io_motor_gpio_step2dir = pwm_io_reg_step_do[2]; // @[motor_top.scala 96:50]
  assign io_motor_irq = pwm_io_irq_out; // @[motor_top.scala 102:29]
  assign interlink_clock = clock;
  assign interlink_reset = reset;
  assign interlink_io_bus_adr_i = {{16'd0}, io_wbs_m2s_addr}; // @[motor_top.scala 62:29]
  assign interlink_io_bus_sel_i = io_wbs_m2s_sel; // @[motor_top.scala 63:29]
  assign interlink_io_bus_we_i = io_wbs_m2s_we; // @[motor_top.scala 64:29]
  assign interlink_io_bus_stb_i = io_wbs_m2s_stb; // @[motor_top.scala 60:29]
  assign interlink_io_tmr_val_do = pwm_io_reg_val_do; // @[motor_top.scala 76:29]
  assign interlink_io_tmr_dat_do = pwm_io_reg_dat_do; // @[motor_top.scala 88:29]
  assign interlink_io_tmr_duty_do = pwm_io_reg_duty_do; // @[motor_top.scala 91:29]
  assign interlink_io_tmr_cfg_do = pwm_io_reg_cfg_do; // @[motor_top.scala 80:29]
  assign interlink_io_tmr_step_do = pwm_io_reg_step_do; // @[motor_top.scala 84:29]
  assign interlink_io_qei_count_do = qei_io_reg_count_do; // @[motor_top.scala 117:29]
  assign interlink_io_qei_cfg_do = qei_io_reg_cfg_do; // @[motor_top.scala 121:29]
  assign interlink_io_qei_speed_do = qei_io_reg_speed_do; // @[motor_top.scala 123:29]
  assign interlink_io_pid_kp_do = pid_io_reg_kp_do; // @[motor_top.scala 132:29]
  assign interlink_io_pid_ki_do = pid_io_reg_ki_do; // @[motor_top.scala 136:29]
  assign interlink_io_pid_kd_do = pid_io_reg_kd_do; // @[motor_top.scala 140:29]
  assign interlink_io_pid_ref_do = pid_io_reg_ref_do; // @[motor_top.scala 144:29]
  assign interlink_io_pid_fb_do = pid_io_reg_fb_do; // @[motor_top.scala 148:29]
  assign interlink_io_pid_cfg_do = pid_io_reg_cfg_do; // @[motor_top.scala 152:29]
  assign interlink_io_motor_select = io_motor_select; // @[motor_top.scala 57:29]
  assign pwm_clock = clock;
  assign pwm_reset = reset;
  assign pwm_io_reg_val_we = interlink_io_tmr_val_we; // @[motor_top.scala 74:29]
  assign pwm_io_reg_val_di = io_wbs_m2s_data; // @[motor_top.scala 75:29]
  assign pwm_io_reg_cfg_we = interlink_io_tmr_cfg_we; // @[motor_top.scala 78:29]
  assign pwm_io_reg_cfg_di = io_wbs_m2s_data; // @[motor_top.scala 79:29]
  assign pwm_io_reg_dat_we = interlink_io_tmr_dat_we; // @[motor_top.scala 86:29]
  assign pwm_io_reg_dat_di = io_wbs_m2s_data; // @[motor_top.scala 87:29]
  assign pwm_io_reg_duty_we = interlink_io_tmr_duty_we; // @[motor_top.scala 89:29]
  assign pwm_io_reg_duty_di = io_wbs_m2s_data; // @[motor_top.scala 90:29]
  assign pwm_io_reg_step_we = interlink_io_tmr_step_we; // @[motor_top.scala 82:29]
  assign pwm_io_reg_pid_out = pid_io_pid_out; // @[motor_top.scala 154:29 99:35]
  assign pwm_io_x_homed = io_motor_gpio_x_homed; // @[motor_top.scala 71:29]
  assign pwm_io_y_homed = io_motor_gpio_y_homed; // @[motor_top.scala 72:29]
  assign qei_clock = clock;
  assign qei_reset = reset;
  assign qei_io_quad_a = io_motor_gpio_qei_ch_a; // @[motor_top.scala 111:29]
  assign qei_io_quad_b = io_motor_gpio_qei_ch_b; // @[motor_top.scala 112:29]
  assign qei_io_raw_irq = pwm_io_rawirq_out; // @[motor_top.scala 113:29]
  assign qei_io_reg_count_we = interlink_io_qei_count_we; // @[motor_top.scala 115:29]
  assign qei_io_reg_count_di = io_wbs_m2s_data; // @[motor_top.scala 116:29]
  assign qei_io_reg_cfg_we = interlink_io_qei_cfg_we; // @[motor_top.scala 119:29]
  assign qei_io_reg_cfg_di = io_wbs_m2s_data; // @[motor_top.scala 120:29]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_fb_period = qei_io_fb_period; // @[motor_top.scala 127:29]
  assign pid_io_raw_irq = pwm_io_rawirq_out; // @[motor_top.scala 155:29]
  assign pid_io_reg_kp_we = interlink_io_pid_kp_we; // @[motor_top.scala 130:29]
  assign pid_io_reg_kp_di = {{8{_pid_io_reg_kp_di_T_1[7]}},_pid_io_reg_kp_di_T_1}; // @[motor_top.scala 131:29]
  assign pid_io_reg_ki_we = interlink_io_pid_ki_we; // @[motor_top.scala 134:29]
  assign pid_io_reg_ki_di = {{8{_pid_io_reg_kp_di_T_1[7]}},_pid_io_reg_kp_di_T_1}; // @[motor_top.scala 135:29]
  assign pid_io_reg_kd_we = interlink_io_pid_kd_we; // @[motor_top.scala 138:29]
  assign pid_io_reg_kd_di = {{8{_pid_io_reg_kp_di_T_1[7]}},_pid_io_reg_kp_di_T_1}; // @[motor_top.scala 139:29]
  assign pid_io_reg_ref_we = interlink_io_pid_ref_we; // @[motor_top.scala 142:29]
  assign pid_io_reg_ref_di = io_wbs_m2s_data[15:0]; // @[motor_top.scala 143:54]
  assign pid_io_reg_fb_we = interlink_io_pid_fb_we; // @[motor_top.scala 146:29]
  assign pid_io_reg_fb_di = io_wbs_m2s_data[15:0]; // @[motor_top.scala 147:54]
  assign pid_io_reg_cfg_we = interlink_io_pid_cfg_we; // @[motor_top.scala 150:29]
  assign pid_io_reg_cfg_di = io_wbs_m2s_data[15:0]; // @[motor_top.scala 151:54]
  assign pid_io_speed_fb_in = qei_io_reg_speed_do; // @[motor_top.scala 128:29]
endmodule
module WB_InterConnect(
  input         clock,
  input         reset,
  input  [31:0] io_dbus_addr,
  input  [31:0] io_dbus_wdata,
  output [31:0] io_dbus_rdata,
  input         io_dbus_rd_en,
  input         io_dbus_wr_en,
  input  [1:0]  io_dbus_st_type,
  input  [2:0]  io_dbus_ld_type,
  output        io_dbus_valid,
  input  [31:0] io_ibus_addr,
  output [31:0] io_ibus_inst,
  output        io_ibus_valid,
  output        io_uart_tx,
  input         io_uart_rx,
  output        io_uart_irq,
  output        io_spi_cs,
  output        io_spi_clk,
  output        io_spi_mosi,
  input         io_spi_miso,
  output        io_spi_irq,
  input         io_m1_io_qei_ch_a,
  input         io_m1_io_qei_ch_b,
  output        io_m1_io_pwm_high,
  output        io_m1_io_pwm_low,
  input         io_m1_io_x_homed,
  input         io_m1_io_y_homed,
  output        io_m1_io_step1step,
  output        io_m1_io_step2step,
  output        io_m1_io_step1dir,
  output        io_m1_io_step2dir,
  input         io_m2_io_qei_ch_a,
  input         io_m2_io_qei_ch_b,
  output        io_m2_io_pwm_high,
  output        io_m2_io_pwm_low,
  input         io_m2_io_x_homed,
  input         io_m2_io_y_homed,
  output        io_m2_io_step1step,
  output        io_m2_io_step2step,
  output        io_m2_io_step1dir,
  output        io_m2_io_step2dir,
  input         io_m3_io_qei_ch_a,
  input         io_m3_io_qei_ch_b,
  output        io_m3_io_pwm_high,
  output        io_m3_io_pwm_low,
  input         io_m3_io_x_homed,
  input         io_m3_io_y_homed,
  output        io_m3_io_step1step,
  output        io_m3_io_step2step,
  output        io_m3_io_step1dir,
  output        io_m3_io_step2dir,
  output        io_m1_irq,
  output        io_m2_irq,
  output        io_m3_irq
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire  dmem_clock; // @[wb_interconnect.scala 65:24]
  wire  dmem_reset; // @[wb_interconnect.scala 65:24]
  wire  dmem_io_wbs_m2s_stb; // @[wb_interconnect.scala 65:24]
  wire  dmem_io_wbs_ack_o; // @[wb_interconnect.scala 65:24]
  wire  imem_clock; // @[wb_interconnect.scala 66:24]
  wire  imem_reset; // @[wb_interconnect.scala 66:24]
  wire [31:0] imem_io_ibus_addr; // @[wb_interconnect.scala 66:24]
  wire [31:0] imem_io_ibus_inst; // @[wb_interconnect.scala 66:24]
  wire  imem_io_ibus_valid; // @[wb_interconnect.scala 66:24]
  wire [15:0] imem_io_wbs_m2s_addr; // @[wb_interconnect.scala 66:24]
  wire [31:0] imem_io_wbs_m2s_data; // @[wb_interconnect.scala 66:24]
  wire  imem_io_wbs_m2s_we; // @[wb_interconnect.scala 66:24]
  wire [3:0] imem_io_wbs_m2s_sel; // @[wb_interconnect.scala 66:24]
  wire  imem_io_wbs_m2s_stb; // @[wb_interconnect.scala 66:24]
  wire  imem_io_wbs_ack_o; // @[wb_interconnect.scala 66:24]
  wire [31:0] imem_io_wbs_data_o; // @[wb_interconnect.scala 66:24]
  wire [31:0] wbm_dbus_io_dbus_addr; // @[wb_interconnect.scala 67:24]
  wire [31:0] wbm_dbus_io_dbus_wdata; // @[wb_interconnect.scala 67:24]
  wire [31:0] wbm_dbus_io_dbus_rdata; // @[wb_interconnect.scala 67:24]
  wire  wbm_dbus_io_dbus_rd_en; // @[wb_interconnect.scala 67:24]
  wire  wbm_dbus_io_dbus_wr_en; // @[wb_interconnect.scala 67:24]
  wire [1:0] wbm_dbus_io_dbus_st_type; // @[wb_interconnect.scala 67:24]
  wire [2:0] wbm_dbus_io_dbus_ld_type; // @[wb_interconnect.scala 67:24]
  wire  wbm_dbus_io_dbus_valid; // @[wb_interconnect.scala 67:24]
  wire [15:0] wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 67:24]
  wire [31:0] wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 67:24]
  wire  wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 67:24]
  wire [3:0] wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 67:24]
  wire  wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 67:24]
  wire  wbm_dbus_io_wbm_ack_i; // @[wb_interconnect.scala 67:24]
  wire [31:0] wbm_dbus_io_wbm_data_i; // @[wb_interconnect.scala 67:24]
  wire  uart_clock; // @[wb_interconnect.scala 68:24]
  wire  uart_reset; // @[wb_interconnect.scala 68:24]
  wire  uart_io_uart_select; // @[wb_interconnect.scala 68:24]
  wire  uart_io_txd; // @[wb_interconnect.scala 68:24]
  wire  uart_io_rxd; // @[wb_interconnect.scala 68:24]
  wire  uart_io_uartInt; // @[wb_interconnect.scala 68:24]
  wire [15:0] uart_io_wbs_m2s_addr; // @[wb_interconnect.scala 68:24]
  wire [31:0] uart_io_wbs_m2s_data; // @[wb_interconnect.scala 68:24]
  wire  uart_io_wbs_m2s_we; // @[wb_interconnect.scala 68:24]
  wire  uart_io_wbs_m2s_stb; // @[wb_interconnect.scala 68:24]
  wire  uart_io_wbs_ack_o; // @[wb_interconnect.scala 68:24]
  wire [31:0] uart_io_wbs_data_o; // @[wb_interconnect.scala 68:24]
  wire  spi_clock; // @[wb_interconnect.scala 69:24]
  wire  spi_reset; // @[wb_interconnect.scala 69:24]
  wire  spi_io_spi_select; // @[wb_interconnect.scala 69:24]
  wire  spi_io_spi_cs; // @[wb_interconnect.scala 69:24]
  wire  spi_io_spi_clk; // @[wb_interconnect.scala 69:24]
  wire  spi_io_spi_mosi; // @[wb_interconnect.scala 69:24]
  wire  spi_io_spi_miso; // @[wb_interconnect.scala 69:24]
  wire  spi_io_spi_intr; // @[wb_interconnect.scala 69:24]
  wire [15:0] spi_io_wbs_m2s_addr; // @[wb_interconnect.scala 69:24]
  wire [31:0] spi_io_wbs_m2s_data; // @[wb_interconnect.scala 69:24]
  wire  spi_io_wbs_m2s_we; // @[wb_interconnect.scala 69:24]
  wire  spi_io_wbs_m2s_stb; // @[wb_interconnect.scala 69:24]
  wire  spi_io_wbs_ack_o; // @[wb_interconnect.scala 69:24]
  wire [31:0] spi_io_wbs_data_o; // @[wb_interconnect.scala 69:24]
  wire  m1_clock; // @[wb_interconnect.scala 70:24]
  wire  m1_reset; // @[wb_interconnect.scala 70:24]
  wire [15:0] m1_io_wbs_m2s_addr; // @[wb_interconnect.scala 70:24]
  wire [31:0] m1_io_wbs_m2s_data; // @[wb_interconnect.scala 70:24]
  wire  m1_io_wbs_m2s_we; // @[wb_interconnect.scala 70:24]
  wire [3:0] m1_io_wbs_m2s_sel; // @[wb_interconnect.scala 70:24]
  wire  m1_io_wbs_m2s_stb; // @[wb_interconnect.scala 70:24]
  wire  m1_io_wbs_ack_o; // @[wb_interconnect.scala 70:24]
  wire [31:0] m1_io_wbs_data_o; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_gpio_qei_ch_a; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_gpio_qei_ch_b; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_gpio_x_homed; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_gpio_y_homed; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_gpio_step1step; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_gpio_step2step; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_gpio_step1dir; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_gpio_step2dir; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_select; // @[wb_interconnect.scala 70:24]
  wire  m1_io_motor_irq; // @[wb_interconnect.scala 70:24]
  wire  m2_clock; // @[wb_interconnect.scala 71:24]
  wire  m2_reset; // @[wb_interconnect.scala 71:24]
  wire [15:0] m2_io_wbs_m2s_addr; // @[wb_interconnect.scala 71:24]
  wire [31:0] m2_io_wbs_m2s_data; // @[wb_interconnect.scala 71:24]
  wire  m2_io_wbs_m2s_we; // @[wb_interconnect.scala 71:24]
  wire [3:0] m2_io_wbs_m2s_sel; // @[wb_interconnect.scala 71:24]
  wire  m2_io_wbs_m2s_stb; // @[wb_interconnect.scala 71:24]
  wire  m2_io_wbs_ack_o; // @[wb_interconnect.scala 71:24]
  wire [31:0] m2_io_wbs_data_o; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_gpio_qei_ch_a; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_gpio_qei_ch_b; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_gpio_x_homed; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_gpio_y_homed; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_gpio_step1step; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_gpio_step2step; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_gpio_step1dir; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_gpio_step2dir; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_select; // @[wb_interconnect.scala 71:24]
  wire  m2_io_motor_irq; // @[wb_interconnect.scala 71:24]
  wire  m3_clock; // @[wb_interconnect.scala 72:24]
  wire  m3_reset; // @[wb_interconnect.scala 72:24]
  wire [15:0] m3_io_wbs_m2s_addr; // @[wb_interconnect.scala 72:24]
  wire [31:0] m3_io_wbs_m2s_data; // @[wb_interconnect.scala 72:24]
  wire  m3_io_wbs_m2s_we; // @[wb_interconnect.scala 72:24]
  wire [3:0] m3_io_wbs_m2s_sel; // @[wb_interconnect.scala 72:24]
  wire  m3_io_wbs_m2s_stb; // @[wb_interconnect.scala 72:24]
  wire  m3_io_wbs_ack_o; // @[wb_interconnect.scala 72:24]
  wire [31:0] m3_io_wbs_data_o; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_gpio_qei_ch_a; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_gpio_qei_ch_b; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_gpio_x_homed; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_gpio_y_homed; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_gpio_step1step; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_gpio_step2step; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_gpio_step1dir; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_gpio_step2dir; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_select; // @[wb_interconnect.scala 72:24]
  wire  m3_io_motor_irq; // @[wb_interconnect.scala 72:24]
  wire [3:0] address = wbm_dbus_io_wbm_m2s_addr[15:12]; // @[wb_interconnect.scala 79:50]
  wire  imem_addr_match = address == 4'h0; // @[wb_interconnect.scala 80:35]
  wire  dmem_addr_match = address == 4'h1; // @[wb_interconnect.scala 81:35]
  wire  uart_addr_match = address == 4'h2; // @[wb_interconnect.scala 82:35]
  wire  spi_addr_match = address == 4'h3; // @[wb_interconnect.scala 83:35]
  wire  m1_addr_match = address == 4'h4; // @[wb_interconnect.scala 84:35]
  wire  m2_addr_match = address == 4'h5; // @[wb_interconnect.scala 85:35]
  wire  m3_addr_match = address == 4'h6; // @[wb_interconnect.scala 86:35]
  reg  imem_sel; // @[wb_interconnect.scala 107:22]
  reg  dmem_sel; // @[wb_interconnect.scala 108:22]
  reg  uart_sel; // @[wb_interconnect.scala 109:22]
  reg  spi_sel; // @[wb_interconnect.scala 110:22]
  reg  m1_sel; // @[wb_interconnect.scala 111:22]
  reg  m2_sel; // @[wb_interconnect.scala 112:22]
  reg  m3_sel; // @[wb_interconnect.scala 113:22]
  wire [31:0] _wbm_dbus_io_wbm_data_i_T = m3_sel ? m3_io_wbs_data_o : 32'h0; // @[wb_interconnect.scala 129:45]
  wire [31:0] _wbm_dbus_io_wbm_data_i_T_1 = m2_sel ? m2_io_wbs_data_o : _wbm_dbus_io_wbm_data_i_T; // @[wb_interconnect.scala 128:43]
  wire [31:0] _wbm_dbus_io_wbm_data_i_T_2 = m1_sel ? m1_io_wbs_data_o : _wbm_dbus_io_wbm_data_i_T_1; // @[wb_interconnect.scala 127:41]
  wire [31:0] _wbm_dbus_io_wbm_data_i_T_3 = spi_sel ? spi_io_wbs_data_o : _wbm_dbus_io_wbm_data_i_T_2; // @[wb_interconnect.scala 126:39]
  wire [31:0] _wbm_dbus_io_wbm_data_i_T_4 = uart_sel ? uart_io_wbs_data_o : _wbm_dbus_io_wbm_data_i_T_3; // @[wb_interconnect.scala 125:37]
  wire [31:0] _wbm_dbus_io_wbm_data_i_T_5 = imem_sel ? imem_io_wbs_data_o : _wbm_dbus_io_wbm_data_i_T_4; // @[wb_interconnect.scala 124:35]
  wire  _wbm_dbus_io_wbm_ack_i_T = m3_sel & m3_io_wbs_ack_o; // @[wb_interconnect.scala 136:45]
  wire  _wbm_dbus_io_wbm_ack_i_T_1 = m2_sel ? m2_io_wbs_ack_o : _wbm_dbus_io_wbm_ack_i_T; // @[wb_interconnect.scala 135:43]
  wire  _wbm_dbus_io_wbm_ack_i_T_2 = m1_sel ? m1_io_wbs_ack_o : _wbm_dbus_io_wbm_ack_i_T_1; // @[wb_interconnect.scala 134:41]
  wire  _wbm_dbus_io_wbm_ack_i_T_3 = spi_sel ? spi_io_wbs_ack_o : _wbm_dbus_io_wbm_ack_i_T_2; // @[wb_interconnect.scala 133:39]
  wire  _wbm_dbus_io_wbm_ack_i_T_4 = uart_sel ? uart_io_wbs_ack_o : _wbm_dbus_io_wbm_ack_i_T_3; // @[wb_interconnect.scala 132:37]
  wire  _wbm_dbus_io_wbm_ack_i_T_5 = imem_sel ? imem_io_wbs_ack_o : _wbm_dbus_io_wbm_ack_i_T_4; // @[wb_interconnect.scala 131:35]
  DMem_Interface dmem ( // @[wb_interconnect.scala 65:24]
    .clock(dmem_clock),
    .reset(dmem_reset),
    .io_wbs_m2s_stb(dmem_io_wbs_m2s_stb),
    .io_wbs_ack_o(dmem_io_wbs_ack_o)
  );
  IMem_Interface imem ( // @[wb_interconnect.scala 66:24]
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
  WBM_DBus wbm_dbus ( // @[wb_interconnect.scala 67:24]
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
  UART uart ( // @[wb_interconnect.scala 68:24]
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
  SPI spi ( // @[wb_interconnect.scala 69:24]
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
  Motor_Top m1 ( // @[wb_interconnect.scala 70:24]
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
    .io_motor_gpio_x_homed(m1_io_motor_gpio_x_homed),
    .io_motor_gpio_y_homed(m1_io_motor_gpio_y_homed),
    .io_motor_gpio_step1step(m1_io_motor_gpio_step1step),
    .io_motor_gpio_step2step(m1_io_motor_gpio_step2step),
    .io_motor_gpio_step1dir(m1_io_motor_gpio_step1dir),
    .io_motor_gpio_step2dir(m1_io_motor_gpio_step2dir),
    .io_motor_select(m1_io_motor_select),
    .io_motor_irq(m1_io_motor_irq)
  );
  Motor_Top m2 ( // @[wb_interconnect.scala 71:24]
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
    .io_motor_gpio_x_homed(m2_io_motor_gpio_x_homed),
    .io_motor_gpio_y_homed(m2_io_motor_gpio_y_homed),
    .io_motor_gpio_step1step(m2_io_motor_gpio_step1step),
    .io_motor_gpio_step2step(m2_io_motor_gpio_step2step),
    .io_motor_gpio_step1dir(m2_io_motor_gpio_step1dir),
    .io_motor_gpio_step2dir(m2_io_motor_gpio_step2dir),
    .io_motor_select(m2_io_motor_select),
    .io_motor_irq(m2_io_motor_irq)
  );
  Motor_Top m3 ( // @[wb_interconnect.scala 72:24]
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
    .io_motor_gpio_x_homed(m3_io_motor_gpio_x_homed),
    .io_motor_gpio_y_homed(m3_io_motor_gpio_y_homed),
    .io_motor_gpio_step1step(m3_io_motor_gpio_step1step),
    .io_motor_gpio_step2step(m3_io_motor_gpio_step2step),
    .io_motor_gpio_step1dir(m3_io_motor_gpio_step1dir),
    .io_motor_gpio_step2dir(m3_io_motor_gpio_step2dir),
    .io_motor_select(m3_io_motor_select),
    .io_motor_irq(m3_io_motor_irq)
  );
  assign io_dbus_rdata = wbm_dbus_io_dbus_rdata; // @[wb_interconnect.scala 75:20]
  assign io_dbus_valid = wbm_dbus_io_dbus_valid; // @[wb_interconnect.scala 75:20]
  assign io_ibus_inst = imem_io_ibus_inst; // @[wb_interconnect.scala 76:20]
  assign io_ibus_valid = imem_io_ibus_valid; // @[wb_interconnect.scala 76:20]
  assign io_uart_tx = uart_io_txd; // @[wb_interconnect.scala 142:24]
  assign io_uart_irq = uart_io_uartInt; // @[wb_interconnect.scala 143:24]
  assign io_spi_cs = spi_io_spi_cs; // @[wb_interconnect.scala 148:24]
  assign io_spi_clk = spi_io_spi_clk; // @[wb_interconnect.scala 149:24]
  assign io_spi_mosi = spi_io_spi_mosi; // @[wb_interconnect.scala 150:24]
  assign io_spi_irq = spi_io_spi_intr; // @[wb_interconnect.scala 151:24]
  assign io_m1_io_pwm_high = m1_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 154:24]
  assign io_m1_io_pwm_low = m1_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 154:24]
  assign io_m1_io_step1step = m1_io_motor_gpio_step1step; // @[wb_interconnect.scala 154:24]
  assign io_m1_io_step2step = m1_io_motor_gpio_step2step; // @[wb_interconnect.scala 154:24]
  assign io_m1_io_step1dir = m1_io_motor_gpio_step1dir; // @[wb_interconnect.scala 154:24]
  assign io_m1_io_step2dir = m1_io_motor_gpio_step2dir; // @[wb_interconnect.scala 154:24]
  assign io_m2_io_pwm_high = m2_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 158:24]
  assign io_m2_io_pwm_low = m2_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 158:24]
  assign io_m2_io_step1step = m2_io_motor_gpio_step1step; // @[wb_interconnect.scala 158:24]
  assign io_m2_io_step2step = m2_io_motor_gpio_step2step; // @[wb_interconnect.scala 158:24]
  assign io_m2_io_step1dir = m2_io_motor_gpio_step1dir; // @[wb_interconnect.scala 158:24]
  assign io_m2_io_step2dir = m2_io_motor_gpio_step2dir; // @[wb_interconnect.scala 158:24]
  assign io_m3_io_pwm_high = m3_io_motor_gpio_pwm_high; // @[wb_interconnect.scala 162:24]
  assign io_m3_io_pwm_low = m3_io_motor_gpio_pwm_low; // @[wb_interconnect.scala 162:24]
  assign io_m3_io_step1step = m3_io_motor_gpio_step1step; // @[wb_interconnect.scala 162:24]
  assign io_m3_io_step2step = m3_io_motor_gpio_step2step; // @[wb_interconnect.scala 162:24]
  assign io_m3_io_step1dir = m3_io_motor_gpio_step1dir; // @[wb_interconnect.scala 162:24]
  assign io_m3_io_step2dir = m3_io_motor_gpio_step2dir; // @[wb_interconnect.scala 162:24]
  assign io_m1_irq = m1_io_motor_irq; // @[wb_interconnect.scala 156:24]
  assign io_m2_irq = m2_io_motor_irq; // @[wb_interconnect.scala 160:24]
  assign io_m3_irq = m3_io_motor_irq; // @[wb_interconnect.scala 164:24]
  assign dmem_clock = clock;
  assign dmem_reset = reset;
  assign dmem_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 89:20]
  assign imem_clock = clock;
  assign imem_reset = reset;
  assign imem_io_ibus_addr = io_ibus_addr; // @[wb_interconnect.scala 76:20]
  assign imem_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 93:20]
  assign imem_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 93:20]
  assign imem_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 93:20]
  assign imem_io_wbs_m2s_sel = wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 93:20]
  assign imem_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 93:20]
  assign wbm_dbus_io_dbus_addr = io_dbus_addr; // @[wb_interconnect.scala 75:20]
  assign wbm_dbus_io_dbus_wdata = io_dbus_wdata; // @[wb_interconnect.scala 75:20]
  assign wbm_dbus_io_dbus_rd_en = io_dbus_rd_en; // @[wb_interconnect.scala 75:20]
  assign wbm_dbus_io_dbus_wr_en = io_dbus_wr_en; // @[wb_interconnect.scala 75:20]
  assign wbm_dbus_io_dbus_st_type = io_dbus_st_type; // @[wb_interconnect.scala 75:20]
  assign wbm_dbus_io_dbus_ld_type = io_dbus_ld_type; // @[wb_interconnect.scala 75:20]
  assign wbm_dbus_io_wbm_ack_i = dmem_sel ? dmem_io_wbs_ack_o : _wbm_dbus_io_wbm_ack_i_T_5; // @[wb_interconnect.scala 130:32]
  assign wbm_dbus_io_wbm_data_i = dmem_sel ? 32'h0 : _wbm_dbus_io_wbm_data_i_T_5; // @[wb_interconnect.scala 123:32]
  assign uart_clock = clock;
  assign uart_reset = reset;
  assign uart_io_uart_select = address == 4'h2; // @[wb_interconnect.scala 82:35]
  assign uart_io_rxd = io_uart_rx; // @[wb_interconnect.scala 141:24]
  assign uart_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 96:20]
  assign uart_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 96:20]
  assign uart_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 96:20]
  assign uart_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 96:20]
  assign spi_clock = clock;
  assign spi_reset = reset;
  assign spi_io_spi_select = address == 4'h3; // @[wb_interconnect.scala 83:35]
  assign spi_io_spi_miso = io_spi_miso; // @[wb_interconnect.scala 147:24]
  assign spi_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 99:19]
  assign spi_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 99:19]
  assign spi_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 99:19]
  assign spi_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 99:19]
  assign m1_clock = clock;
  assign m1_reset = reset;
  assign m1_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 102:17]
  assign m1_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 102:17]
  assign m1_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 102:17]
  assign m1_io_wbs_m2s_sel = wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 102:17]
  assign m1_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 102:17]
  assign m1_io_motor_gpio_qei_ch_a = io_m1_io_qei_ch_a; // @[wb_interconnect.scala 154:24]
  assign m1_io_motor_gpio_qei_ch_b = io_m1_io_qei_ch_b; // @[wb_interconnect.scala 154:24]
  assign m1_io_motor_gpio_x_homed = io_m1_io_x_homed; // @[wb_interconnect.scala 154:24]
  assign m1_io_motor_gpio_y_homed = io_m1_io_y_homed; // @[wb_interconnect.scala 154:24]
  assign m1_io_motor_select = address == 4'h4; // @[wb_interconnect.scala 84:35]
  assign m2_clock = clock;
  assign m2_reset = reset;
  assign m2_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 103:17]
  assign m2_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 103:17]
  assign m2_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 103:17]
  assign m2_io_wbs_m2s_sel = wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 103:17]
  assign m2_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 103:17]
  assign m2_io_motor_gpio_qei_ch_a = io_m2_io_qei_ch_a; // @[wb_interconnect.scala 158:24]
  assign m2_io_motor_gpio_qei_ch_b = io_m2_io_qei_ch_b; // @[wb_interconnect.scala 158:24]
  assign m2_io_motor_gpio_x_homed = io_m2_io_x_homed; // @[wb_interconnect.scala 158:24]
  assign m2_io_motor_gpio_y_homed = io_m2_io_y_homed; // @[wb_interconnect.scala 158:24]
  assign m2_io_motor_select = address == 4'h5; // @[wb_interconnect.scala 85:35]
  assign m3_clock = clock;
  assign m3_reset = reset;
  assign m3_io_wbs_m2s_addr = wbm_dbus_io_wbm_m2s_addr; // @[wb_interconnect.scala 104:17]
  assign m3_io_wbs_m2s_data = wbm_dbus_io_wbm_m2s_data; // @[wb_interconnect.scala 104:17]
  assign m3_io_wbs_m2s_we = wbm_dbus_io_wbm_m2s_we; // @[wb_interconnect.scala 104:17]
  assign m3_io_wbs_m2s_sel = wbm_dbus_io_wbm_m2s_sel; // @[wb_interconnect.scala 104:17]
  assign m3_io_wbs_m2s_stb = wbm_dbus_io_wbm_m2s_stb; // @[wb_interconnect.scala 104:17]
  assign m3_io_motor_gpio_qei_ch_a = io_m3_io_qei_ch_a; // @[wb_interconnect.scala 162:24]
  assign m3_io_motor_gpio_qei_ch_b = io_m3_io_qei_ch_b; // @[wb_interconnect.scala 162:24]
  assign m3_io_motor_gpio_x_homed = io_m3_io_x_homed; // @[wb_interconnect.scala 162:24]
  assign m3_io_motor_gpio_y_homed = io_m3_io_y_homed; // @[wb_interconnect.scala 162:24]
  assign m3_io_motor_select = address == 4'h6; // @[wb_interconnect.scala 86:35]
  always @(posedge clock) begin
    imem_sel <= imem_addr_match & imem_io_wbs_m2s_stb; // @[wb_interconnect.scala 115:32]
    dmem_sel <= dmem_addr_match & dmem_io_wbs_m2s_stb; // @[wb_interconnect.scala 116:32]
    uart_sel <= uart_addr_match & uart_io_wbs_m2s_stb; // @[wb_interconnect.scala 117:32]
    spi_sel <= spi_addr_match & spi_io_wbs_m2s_stb; // @[wb_interconnect.scala 118:33]
    m1_sel <= m1_addr_match & m1_io_wbs_m2s_stb; // @[wb_interconnect.scala 119:30]
    m2_sel <= m2_addr_match & m2_io_wbs_m2s_stb; // @[wb_interconnect.scala 120:30]
    m3_sel <= m3_addr_match & m3_io_wbs_m2s_stb; // @[wb_interconnect.scala 121:30]
  end
// Register and memory initialization
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  imem_sel = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dmem_sel = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  uart_sel = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  spi_sel = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  m1_sel = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  m2_sel = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  m3_sel = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SoC_Tile(
  input   clock,
  input   reset,
  output  io_uart_tx,
  input   io_uart_rx,
  output  io_spi_cs,
  output  io_spi_clk,
  output  io_spi_mosi,
  input   io_spi_miso,
  input   io_m1_io_qei_ch_a,
  input   io_m1_io_qei_ch_b,
  output  io_m1_io_pwm_high,
  output  io_m1_io_pwm_low,
  input   io_m1_io_x_homed,
  input   io_m1_io_y_homed,
  output  io_m1_io_step1step,
  output  io_m1_io_step2step,
  output  io_m1_io_step1dir,
  output  io_m1_io_step2dir,
  input   io_m2_io_qei_ch_a,
  input   io_m2_io_qei_ch_b,
  output  io_m2_io_pwm_high,
  output  io_m2_io_pwm_low,
  input   io_m2_io_x_homed,
  input   io_m2_io_y_homed,
  output  io_m2_io_step1step,
  output  io_m2_io_step2step,
  output  io_m2_io_step1dir,
  output  io_m2_io_step2dir,
  input   io_m3_io_qei_ch_a,
  input   io_m3_io_qei_ch_b,
  output  io_m3_io_pwm_high,
  output  io_m3_io_pwm_low,
  input   io_m3_io_x_homed,
  input   io_m3_io_y_homed,
  output  io_m3_io_step1step,
  output  io_m3_io_step2step,
  output  io_m3_io_step1dir,
  output  io_m3_io_step2dir
);
  wire  core_clock; // @[SoC_Tile.scala 48:32]
  wire  core_reset; // @[SoC_Tile.scala 48:32]
  wire  core_io_irq_uart_irq; // @[SoC_Tile.scala 48:32]
  wire  core_io_irq_spi_irq; // @[SoC_Tile.scala 48:32]
  wire  core_io_irq_m1_irq; // @[SoC_Tile.scala 48:32]
  wire  core_io_irq_m2_irq; // @[SoC_Tile.scala 48:32]
  wire  core_io_irq_m3_irq; // @[SoC_Tile.scala 48:32]
  wire [31:0] core_io_ibus_addr; // @[SoC_Tile.scala 48:32]
  wire [31:0] core_io_ibus_inst; // @[SoC_Tile.scala 48:32]
  wire  core_io_ibus_valid; // @[SoC_Tile.scala 48:32]
  wire [31:0] core_io_dbus_addr; // @[SoC_Tile.scala 48:32]
  wire [31:0] core_io_dbus_wdata; // @[SoC_Tile.scala 48:32]
  wire [31:0] core_io_dbus_rdata; // @[SoC_Tile.scala 48:32]
  wire  core_io_dbus_rd_en; // @[SoC_Tile.scala 48:32]
  wire  core_io_dbus_wr_en; // @[SoC_Tile.scala 48:32]
  wire [1:0] core_io_dbus_st_type; // @[SoC_Tile.scala 48:32]
  wire [2:0] core_io_dbus_ld_type; // @[SoC_Tile.scala 48:32]
  wire  core_io_dbus_valid; // @[SoC_Tile.scala 48:32]
  wire  wb_inter_connect_clock; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_reset; // @[SoC_Tile.scala 49:32]
  wire [31:0] wb_inter_connect_io_dbus_addr; // @[SoC_Tile.scala 49:32]
  wire [31:0] wb_inter_connect_io_dbus_wdata; // @[SoC_Tile.scala 49:32]
  wire [31:0] wb_inter_connect_io_dbus_rdata; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_dbus_rd_en; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_dbus_wr_en; // @[SoC_Tile.scala 49:32]
  wire [1:0] wb_inter_connect_io_dbus_st_type; // @[SoC_Tile.scala 49:32]
  wire [2:0] wb_inter_connect_io_dbus_ld_type; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_dbus_valid; // @[SoC_Tile.scala 49:32]
  wire [31:0] wb_inter_connect_io_ibus_addr; // @[SoC_Tile.scala 49:32]
  wire [31:0] wb_inter_connect_io_ibus_inst; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_ibus_valid; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_uart_tx; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_uart_rx; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_uart_irq; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_spi_cs; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_spi_clk; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_spi_mosi; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_spi_miso; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_spi_irq; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_io_qei_ch_a; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_io_qei_ch_b; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_io_pwm_high; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_io_pwm_low; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_io_x_homed; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_io_y_homed; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_io_step1step; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_io_step2step; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_io_step1dir; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_io_step2dir; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_io_qei_ch_a; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_io_qei_ch_b; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_io_pwm_high; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_io_pwm_low; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_io_x_homed; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_io_y_homed; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_io_step1step; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_io_step2step; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_io_step1dir; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_io_step2dir; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_io_qei_ch_a; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_io_qei_ch_b; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_io_pwm_high; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_io_pwm_low; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_io_x_homed; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_io_y_homed; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_io_step1step; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_io_step2step; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_io_step1dir; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_io_step2dir; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m1_irq; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m2_irq; // @[SoC_Tile.scala 49:32]
  wire  wb_inter_connect_io_m3_irq; // @[SoC_Tile.scala 49:32]
  Core core ( // @[SoC_Tile.scala 48:32]
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
  WB_InterConnect wb_inter_connect ( // @[SoC_Tile.scala 49:32]
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
    .io_m1_io_x_homed(wb_inter_connect_io_m1_io_x_homed),
    .io_m1_io_y_homed(wb_inter_connect_io_m1_io_y_homed),
    .io_m1_io_step1step(wb_inter_connect_io_m1_io_step1step),
    .io_m1_io_step2step(wb_inter_connect_io_m1_io_step2step),
    .io_m1_io_step1dir(wb_inter_connect_io_m1_io_step1dir),
    .io_m1_io_step2dir(wb_inter_connect_io_m1_io_step2dir),
    .io_m2_io_qei_ch_a(wb_inter_connect_io_m2_io_qei_ch_a),
    .io_m2_io_qei_ch_b(wb_inter_connect_io_m2_io_qei_ch_b),
    .io_m2_io_pwm_high(wb_inter_connect_io_m2_io_pwm_high),
    .io_m2_io_pwm_low(wb_inter_connect_io_m2_io_pwm_low),
    .io_m2_io_x_homed(wb_inter_connect_io_m2_io_x_homed),
    .io_m2_io_y_homed(wb_inter_connect_io_m2_io_y_homed),
    .io_m2_io_step1step(wb_inter_connect_io_m2_io_step1step),
    .io_m2_io_step2step(wb_inter_connect_io_m2_io_step2step),
    .io_m2_io_step1dir(wb_inter_connect_io_m2_io_step1dir),
    .io_m2_io_step2dir(wb_inter_connect_io_m2_io_step2dir),
    .io_m3_io_qei_ch_a(wb_inter_connect_io_m3_io_qei_ch_a),
    .io_m3_io_qei_ch_b(wb_inter_connect_io_m3_io_qei_ch_b),
    .io_m3_io_pwm_high(wb_inter_connect_io_m3_io_pwm_high),
    .io_m3_io_pwm_low(wb_inter_connect_io_m3_io_pwm_low),
    .io_m3_io_x_homed(wb_inter_connect_io_m3_io_x_homed),
    .io_m3_io_y_homed(wb_inter_connect_io_m3_io_y_homed),
    .io_m3_io_step1step(wb_inter_connect_io_m3_io_step1step),
    .io_m3_io_step2step(wb_inter_connect_io_m3_io_step2step),
    .io_m3_io_step1dir(wb_inter_connect_io_m3_io_step1dir),
    .io_m3_io_step2dir(wb_inter_connect_io_m3_io_step2dir),
    .io_m1_irq(wb_inter_connect_io_m1_irq),
    .io_m2_irq(wb_inter_connect_io_m2_irq),
    .io_m3_irq(wb_inter_connect_io_m3_irq)
  );
  assign io_uart_tx = wb_inter_connect_io_uart_tx; // @[SoC_Tile.scala 56:32]
  assign io_spi_cs = wb_inter_connect_io_spi_cs; // @[SoC_Tile.scala 61:32]
  assign io_spi_clk = wb_inter_connect_io_spi_clk; // @[SoC_Tile.scala 62:32]
  assign io_spi_mosi = wb_inter_connect_io_spi_mosi; // @[SoC_Tile.scala 63:32]
  assign io_m1_io_pwm_high = wb_inter_connect_io_m1_io_pwm_high; // @[SoC_Tile.scala 68:12]
  assign io_m1_io_pwm_low = wb_inter_connect_io_m1_io_pwm_low; // @[SoC_Tile.scala 68:12]
  assign io_m1_io_step1step = wb_inter_connect_io_m1_io_step1step; // @[SoC_Tile.scala 68:12]
  assign io_m1_io_step2step = wb_inter_connect_io_m1_io_step2step; // @[SoC_Tile.scala 68:12]
  assign io_m1_io_step1dir = wb_inter_connect_io_m1_io_step1dir; // @[SoC_Tile.scala 68:12]
  assign io_m1_io_step2dir = wb_inter_connect_io_m1_io_step2dir; // @[SoC_Tile.scala 68:12]
  assign io_m2_io_pwm_high = wb_inter_connect_io_m2_io_pwm_high; // @[SoC_Tile.scala 69:12]
  assign io_m2_io_pwm_low = wb_inter_connect_io_m2_io_pwm_low; // @[SoC_Tile.scala 69:12]
  assign io_m2_io_step1step = wb_inter_connect_io_m2_io_step1step; // @[SoC_Tile.scala 69:12]
  assign io_m2_io_step2step = wb_inter_connect_io_m2_io_step2step; // @[SoC_Tile.scala 69:12]
  assign io_m2_io_step1dir = wb_inter_connect_io_m2_io_step1dir; // @[SoC_Tile.scala 69:12]
  assign io_m2_io_step2dir = wb_inter_connect_io_m2_io_step2dir; // @[SoC_Tile.scala 69:12]
  assign io_m3_io_pwm_high = wb_inter_connect_io_m3_io_pwm_high; // @[SoC_Tile.scala 70:12]
  assign io_m3_io_pwm_low = wb_inter_connect_io_m3_io_pwm_low; // @[SoC_Tile.scala 70:12]
  assign io_m3_io_step1step = wb_inter_connect_io_m3_io_step1step; // @[SoC_Tile.scala 70:12]
  assign io_m3_io_step2step = wb_inter_connect_io_m3_io_step2step; // @[SoC_Tile.scala 70:12]
  assign io_m3_io_step1dir = wb_inter_connect_io_m3_io_step1dir; // @[SoC_Tile.scala 70:12]
  assign io_m3_io_step2dir = wb_inter_connect_io_m3_io_step2dir; // @[SoC_Tile.scala 70:12]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_irq_uart_irq = wb_inter_connect_io_uart_irq; // @[SoC_Tile.scala 58:32]
  assign core_io_irq_spi_irq = wb_inter_connect_io_spi_irq; // @[SoC_Tile.scala 65:32]
  assign core_io_irq_m1_irq = wb_inter_connect_io_m1_irq; // @[SoC_Tile.scala 73:22]
  assign core_io_irq_m2_irq = wb_inter_connect_io_m2_irq; // @[SoC_Tile.scala 74:22]
  assign core_io_irq_m3_irq = wb_inter_connect_io_m3_irq; // @[SoC_Tile.scala 75:22]
  assign core_io_ibus_inst = wb_inter_connect_io_ibus_inst; // @[SoC_Tile.scala 52:24]
  assign core_io_ibus_valid = wb_inter_connect_io_ibus_valid; // @[SoC_Tile.scala 52:24]
  assign core_io_dbus_rdata = wb_inter_connect_io_dbus_rdata; // @[SoC_Tile.scala 53:24]
  assign core_io_dbus_valid = wb_inter_connect_io_dbus_valid; // @[SoC_Tile.scala 53:24]
  assign wb_inter_connect_clock = clock;
  assign wb_inter_connect_reset = reset;
  assign wb_inter_connect_io_dbus_addr = core_io_dbus_addr; // @[SoC_Tile.scala 53:24]
  assign wb_inter_connect_io_dbus_wdata = core_io_dbus_wdata; // @[SoC_Tile.scala 53:24]
  assign wb_inter_connect_io_dbus_rd_en = core_io_dbus_rd_en; // @[SoC_Tile.scala 53:24]
  assign wb_inter_connect_io_dbus_wr_en = core_io_dbus_wr_en; // @[SoC_Tile.scala 53:24]
  assign wb_inter_connect_io_dbus_st_type = core_io_dbus_st_type; // @[SoC_Tile.scala 53:24]
  assign wb_inter_connect_io_dbus_ld_type = core_io_dbus_ld_type; // @[SoC_Tile.scala 53:24]
  assign wb_inter_connect_io_ibus_addr = core_io_ibus_addr; // @[SoC_Tile.scala 52:24]
  assign wb_inter_connect_io_uart_rx = io_uart_rx; // @[SoC_Tile.scala 57:32]
  assign wb_inter_connect_io_spi_miso = io_spi_miso; // @[SoC_Tile.scala 64:32]
  assign wb_inter_connect_io_m1_io_qei_ch_a = io_m1_io_qei_ch_a; // @[SoC_Tile.scala 68:12]
  assign wb_inter_connect_io_m1_io_qei_ch_b = io_m1_io_qei_ch_b; // @[SoC_Tile.scala 68:12]
  assign wb_inter_connect_io_m1_io_x_homed = io_m1_io_x_homed; // @[SoC_Tile.scala 68:12]
  assign wb_inter_connect_io_m1_io_y_homed = io_m1_io_y_homed; // @[SoC_Tile.scala 68:12]
  assign wb_inter_connect_io_m2_io_qei_ch_a = io_m2_io_qei_ch_a; // @[SoC_Tile.scala 69:12]
  assign wb_inter_connect_io_m2_io_qei_ch_b = io_m2_io_qei_ch_b; // @[SoC_Tile.scala 69:12]
  assign wb_inter_connect_io_m2_io_x_homed = io_m2_io_x_homed; // @[SoC_Tile.scala 69:12]
  assign wb_inter_connect_io_m2_io_y_homed = io_m2_io_y_homed; // @[SoC_Tile.scala 69:12]
  assign wb_inter_connect_io_m3_io_qei_ch_a = io_m3_io_qei_ch_a; // @[SoC_Tile.scala 70:12]
  assign wb_inter_connect_io_m3_io_qei_ch_b = io_m3_io_qei_ch_b; // @[SoC_Tile.scala 70:12]
  assign wb_inter_connect_io_m3_io_x_homed = io_m3_io_x_homed; // @[SoC_Tile.scala 70:12]
  assign wb_inter_connect_io_m3_io_y_homed = io_m3_io_y_homed; // @[SoC_Tile.scala 70:12]
endmodule