/********************************************************* 
 * Filename :    bmem.scala                                
 * Date     :    28-12-2021                                
 * Author   :    Muhammad Tahir                            
 *                                                         
 * Description:  Boot memory for storing boot loader. This 
 *               is an autogenerated file.                 
 ********************************************************/ 

 package memories                                        
import chisel3._                                           
import chisel3.util._                                      
import riscv_uet.{CONSTANTS, Config, IBusIO}               
import chisel3.util.experimental.loadMemoryFromFile        
/*******   Boot memory implementation    ******/           
class BMem_IO extends Bundle with Config {                 
  val bmem_addr   = Input(UInt(WLEN.W))                    
  val bmem_rdata  = Output(UInt(WLEN.W))                   
}                                                        

class BMem extends Module with Config {                    
  val io = IO(new BMem_IO)                                 

  val addr = io.bmem_addr(9, 0) / 4.U
  val bmem_data = RegInit(0.U(32.W))

  switch (addr) {
    is(0.U) {bmem_data := 0x00000013L.U}
    is(1.U) {bmem_data := 0x0040006fL.U}
    is(2.U) {bmem_data := 0xffffa117L.U}
    is(3.U) {bmem_data := 0x0f810113L.U}
    is(4.U) {bmem_data := 0x00000513L.U}
    is(5.U) {bmem_data := 0x00000593L.U}
    is(6.U) {bmem_data := 0x114000efL.U}
    is(7.U) {bmem_data := 0xfe010113L.U}
    is(8.U) {bmem_data := 0x00812e23L.U}
    is(9.U) {bmem_data := 0x02010413L.U}
    is(10.U) {bmem_data := 0x00050793L.U}
    is(11.U) {bmem_data := 0xfef407a3L.U}
    is(12.U) {bmem_data := 0x000027b7L.U}
    is(13.U) {bmem_data := 0xfef44703L.U}
    is(14.U) {bmem_data := 0x00e78123L.U}
    is(15.U) {bmem_data := 0x00000013L.U}
    is(16.U) {bmem_data := 0x01c12403L.U}
    is(17.U) {bmem_data := 0x02010113L.U}
    is(18.U) {bmem_data := 0x00008067L.U}
    is(19.U) {bmem_data := 0xfe010113L.U}
    is(20.U) {bmem_data := 0x00812e23L.U}
    is(21.U) {bmem_data := 0x02010413L.U}
    is(22.U) {bmem_data := 0x00050793L.U}
    is(23.U) {bmem_data := 0xfef407a3L.U}
    is(24.U) {bmem_data := 0x00000013L.U}
    is(25.U) {bmem_data := 0x000027b7L.U}
    is(26.U) {bmem_data := 0x0047c783L.U}
    is(27.U) {bmem_data := 0x0ff7f793L.U}
    is(28.U) {bmem_data := 0x0027f793L.U}
    is(29.U) {bmem_data := 0xfe0788e3L.U}
    is(30.U) {bmem_data := 0x000027b7L.U}
    is(31.U) {bmem_data := 0xfef44703L.U}
    is(32.U) {bmem_data := 0x00e780a3L.U}
    is(33.U) {bmem_data := 0x00000013L.U}
    is(34.U) {bmem_data := 0x01c12403L.U}
    is(35.U) {bmem_data := 0x02010113L.U}
    is(36.U) {bmem_data := 0x00008067L.U}
    is(37.U) {bmem_data := 0xfe010113L.U}
    is(38.U) {bmem_data := 0x00812e23L.U}
    is(39.U) {bmem_data := 0x02010413L.U}
    is(40.U) {bmem_data := 0x00050793L.U}
    is(41.U) {bmem_data := 0xfef407a3L.U}
    is(42.U) {bmem_data := 0x000037b7L.U}
    is(43.U) {bmem_data := 0x0027c783L.U}
    is(44.U) {bmem_data := 0x0ff7f693L.U}
    is(45.U) {bmem_data := 0x000037b7L.U}
    is(46.U) {bmem_data := 0xfef44703L.U}
    is(47.U) {bmem_data := 0x00e6e733L.U}
    is(48.U) {bmem_data := 0x0ff77713L.U}
    is(49.U) {bmem_data := 0x00e78123L.U}
    is(50.U) {bmem_data := 0x00000013L.U}
    is(51.U) {bmem_data := 0x01c12403L.U}
    is(52.U) {bmem_data := 0x02010113L.U}
    is(53.U) {bmem_data := 0x00008067L.U}
    is(54.U) {bmem_data := 0xfe010113L.U}
    is(55.U) {bmem_data := 0x00812e23L.U}
    is(56.U) {bmem_data := 0x02010413L.U}
    is(57.U) {bmem_data := 0x00050793L.U}
    is(58.U) {bmem_data := 0xfef407a3L.U}
    is(59.U) {bmem_data := 0x000037b7L.U}
    is(60.U) {bmem_data := 0xfef44703L.U}
    is(61.U) {bmem_data := 0x00e780a3L.U}
    is(62.U) {bmem_data := 0x00000013L.U}
    is(63.U) {bmem_data := 0x000037b7L.U}
    is(64.U) {bmem_data := 0x0047c783L.U}
    is(65.U) {bmem_data := 0x0ff7f793L.U}
    is(66.U) {bmem_data := 0x0107f793L.U}
    is(67.U) {bmem_data := 0xfe0788e3L.U}
    is(68.U) {bmem_data := 0x000037b7L.U}
    is(69.U) {bmem_data := 0x0007c783L.U}
    is(70.U) {bmem_data := 0x0ff7f793L.U}
    is(71.U) {bmem_data := 0x00078513L.U}
    is(72.U) {bmem_data := 0x01c12403L.U}
    is(73.U) {bmem_data := 0x02010113L.U}
    is(74.U) {bmem_data := 0x00008067L.U}
    is(75.U) {bmem_data := 0xff010113L.U}
    is(76.U) {bmem_data := 0x00112623L.U}
    is(77.U) {bmem_data := 0x00812423L.U}
    is(78.U) {bmem_data := 0x01010413L.U}
    is(79.U) {bmem_data := 0x01000513L.U}
    is(80.U) {bmem_data := 0xeddff0efL.U}
    is(81.U) {bmem_data := 0x00800513L.U}
    is(82.U) {bmem_data := 0xf4dff0efL.U}
    is(83.U) {bmem_data := 0x054000efL.U}
    is(84.U) {bmem_data := 0x04f00513L.U}
    is(85.U) {bmem_data := 0xef9ff0efL.U}
    is(86.U) {bmem_data := 0x06b00513L.U}
    is(87.U) {bmem_data := 0xef1ff0efL.U}
    is(88.U) {bmem_data := 0x01c000efL.U}
    is(89.U) {bmem_data := 0x00000793L.U}
    is(90.U) {bmem_data := 0x00078513L.U}
    is(91.U) {bmem_data := 0x00c12083L.U}
    is(92.U) {bmem_data := 0x00812403L.U}
    is(93.U) {bmem_data := 0x01010113L.U}
    is(94.U) {bmem_data := 0x00008067L.U}
    is(95.U) {bmem_data := 0xff010113L.U}
    is(96.U) {bmem_data := 0x00812623L.U}
    is(97.U) {bmem_data := 0x01010413L.U}
    is(98.U) {bmem_data := 0x000002b7L.U}
    is(99.U) {bmem_data := 0x00028067L.U}
    is(100.U) {bmem_data := 0x00000013L.U}
    is(101.U) {bmem_data := 0x00c12403L.U}
    is(102.U) {bmem_data := 0x01010113L.U}
    is(103.U) {bmem_data := 0x00008067L.U}
    is(104.U) {bmem_data := 0xfd010113L.U}
    is(105.U) {bmem_data := 0x02112623L.U}
    is(106.U) {bmem_data := 0x02812423L.U}
    is(107.U) {bmem_data := 0x03010413L.U}
    is(108.U) {bmem_data := 0xfe042623L.U}
    is(109.U) {bmem_data := 0xfe042223L.U}
    is(110.U) {bmem_data := 0xfe042023L.U}
    is(111.U) {bmem_data := 0xfe042423L.U}
    is(112.U) {bmem_data := 0xfec42503L.U}
    is(113.U) {bmem_data := 0x088000efL.U}
    is(114.U) {bmem_data := 0xfca42e23L.U}
    is(115.U) {bmem_data := 0xfec42783L.U}
    is(116.U) {bmem_data := 0x00478793L.U}
    is(117.U) {bmem_data := 0x00078513L.U}
    is(118.U) {bmem_data := 0x074000efL.U}
    is(119.U) {bmem_data := 0xfca42c23L.U}
    is(120.U) {bmem_data := 0xfec42783L.U}
    is(121.U) {bmem_data := 0x00878793L.U}
    is(122.U) {bmem_data := 0xfef42623L.U}
    is(123.U) {bmem_data := 0x03c0006fL.U}
    is(124.U) {bmem_data := 0xfec42503L.U}
    is(125.U) {bmem_data := 0x058000efL.U}
    is(126.U) {bmem_data := 0xfea42023L.U}
    is(127.U) {bmem_data := 0xfe842783L.U}
    is(128.U) {bmem_data := 0x00178713L.U}
    is(129.U) {bmem_data := 0xfee42423L.U}
    is(130.U) {bmem_data := 0x00279793L.U}
    is(131.U) {bmem_data := 0xfe442703L.U}
    is(132.U) {bmem_data := 0x00f707b3L.U}
    is(133.U) {bmem_data := 0xfe042703L.U}
    is(134.U) {bmem_data := 0x00e7a023L.U}
    is(135.U) {bmem_data := 0xfec42783L.U}
    is(136.U) {bmem_data := 0x00478793L.U}
    is(137.U) {bmem_data := 0xfef42623L.U}
    is(138.U) {bmem_data := 0xfd842783L.U}
    is(139.U) {bmem_data := 0x0027d793L.U}
    is(140.U) {bmem_data := 0xfe842703L.U}
    is(141.U) {bmem_data := 0xfaf76ee3L.U}
    is(142.U) {bmem_data := 0x00000013L.U}
    is(143.U) {bmem_data := 0x02c12083L.U}
    is(144.U) {bmem_data := 0x02812403L.U}
    is(145.U) {bmem_data := 0x03010113L.U}
    is(146.U) {bmem_data := 0x00008067L.U}
    is(147.U) {bmem_data := 0xfd010113L.U}
    is(148.U) {bmem_data := 0x02112623L.U}
    is(149.U) {bmem_data := 0x02812423L.U}
    is(150.U) {bmem_data := 0x03010413L.U}
    is(151.U) {bmem_data := 0xfca42e23L.U}
    is(152.U) {bmem_data := 0x000037b7L.U}
    is(153.U) {bmem_data := 0x0057c783L.U}
    is(154.U) {bmem_data := 0x0ff7f713L.U}
    is(155.U) {bmem_data := 0x000037b7L.U}
    is(156.U) {bmem_data := 0x00176713L.U}
    is(157.U) {bmem_data := 0x0ff77713L.U}
    is(158.U) {bmem_data := 0x00e782a3L.U}
    is(159.U) {bmem_data := 0x00300513L.U}
    is(160.U) {bmem_data := 0xe59ff0efL.U}
    is(161.U) {bmem_data := 0xfdc42503L.U}
    is(162.U) {bmem_data := 0x078000efL.U}
    is(163.U) {bmem_data := 0xfe042623L.U}
    is(164.U) {bmem_data := 0x0300006fL.U}
    is(165.U) {bmem_data := 0x00000513L.U}
    is(166.U) {bmem_data := 0xe41ff0efL.U}
    is(167.U) {bmem_data := 0x00050793L.U}
    is(168.U) {bmem_data := 0x00078713L.U}
    is(169.U) {bmem_data := 0xfec42783L.U}
    is(170.U) {bmem_data := 0xff040693L.U}
    is(171.U) {bmem_data := 0x00f687b3L.U}
    is(172.U) {bmem_data := 0xfee78c23L.U}
    is(173.U) {bmem_data := 0xfec42783L.U}
    is(174.U) {bmem_data := 0x00178793L.U}
    is(175.U) {bmem_data := 0xfef42623L.U}
    is(176.U) {bmem_data := 0xfec42703L.U}
    is(177.U) {bmem_data := 0x00300793L.U}
    is(178.U) {bmem_data := 0xfce7f6e3L.U}
    is(179.U) {bmem_data := 0x000037b7L.U}
    is(180.U) {bmem_data := 0x0057c783L.U}
    is(181.U) {bmem_data := 0x0ff7f713L.U}
    is(182.U) {bmem_data := 0x000037b7L.U}
    is(183.U) {bmem_data := 0xffe77713L.U}
    is(184.U) {bmem_data := 0x0ff77713L.U}
    is(185.U) {bmem_data := 0x00e782a3L.U}
    is(186.U) {bmem_data := 0xfe842783L.U}
    is(187.U) {bmem_data := 0x00078513L.U}
    is(188.U) {bmem_data := 0x02c12083L.U}
    is(189.U) {bmem_data := 0x02812403L.U}
    is(190.U) {bmem_data := 0x03010113L.U}
    is(191.U) {bmem_data := 0x00008067L.U}
    is(192.U) {bmem_data := 0xfd010113L.U}
    is(193.U) {bmem_data := 0x02112623L.U}
    is(194.U) {bmem_data := 0x02812423L.U}
    is(195.U) {bmem_data := 0x03010413L.U}
    is(196.U) {bmem_data := 0xfca42e23L.U}
    is(197.U) {bmem_data := 0xfdc42783L.U}
    is(198.U) {bmem_data := 0xfef42423L.U}
    is(199.U) {bmem_data := 0x00200793L.U}
    is(200.U) {bmem_data := 0xfef42623L.U}
    is(201.U) {bmem_data := 0x0280006fL.U}
    is(202.U) {bmem_data := 0xfec42783L.U}
    is(203.U) {bmem_data := 0xff040713L.U}
    is(204.U) {bmem_data := 0x00f707b3L.U}
    is(205.U) {bmem_data := 0xff87c783L.U}
    is(206.U) {bmem_data := 0x00078513L.U}
    is(207.U) {bmem_data := 0xd9dff0efL.U}
    is(208.U) {bmem_data := 0xfec42783L.U}
    is(209.U) {bmem_data := 0xfff78793L.U}
    is(210.U) {bmem_data := 0xfef42623L.U}
    is(211.U) {bmem_data := 0xfec42783L.U}
    is(212.U) {bmem_data := 0xfc07dce3L.U}
    is(213.U) {bmem_data := 0x00000013L.U}
    is(214.U) {bmem_data := 0x02c12083L.U}
    is(215.U) {bmem_data := 0x02812403L.U}
    is(216.U) {bmem_data := 0x03010113L.U}
    is(217.U) {bmem_data := 0x00008067L.U}
  }

  io.bmem_rdata := bmem_data
 }