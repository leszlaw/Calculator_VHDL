<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="F0" />
        <signal name="DO_Rdy" />
        <signal name="DO(7:0)" />
        <signal name="Clk_Sys" />
        <signal name="PS2_Data" />
        <signal name="PS2_Clk" />
        <signal name="Result(15:0)" />
        <port polarity="Input" name="Clk_Sys" />
        <port polarity="Input" name="PS2_Data" />
        <port polarity="Input" name="PS2_Clk" />
        <port polarity="Output" name="Result(15:0)" />
        <blockdef name="calculator">
            <timestamp>2021-5-27T19:52:59</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
        </blockdef>
        <blockdef name="ps2_kbd">
            <timestamp>2021-5-27T20:33:33</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="calculator" name="XLXI_1">
            <blockpin signalname="F0" name="F0" />
            <blockpin signalname="DO_Rdy" name="DI_Rdy" />
            <blockpin signalname="Clk_Sys" name="Clk_Sys" />
            <blockpin signalname="DO(7:0)" name="DI(7:0)" />
            <blockpin signalname="Result(15:0)" name="Result(15:0)" />
        </block>
        <block symbolname="ps2_kbd" name="XLXI_2">
            <blockpin signalname="PS2_Clk" name="PS2_Clk" />
            <blockpin signalname="PS2_Data" name="PS2_Data" />
            <blockpin signalname="Clk_Sys" name="Clk_Sys" />
            <blockpin name="E0" />
            <blockpin signalname="F0" name="F0" />
            <blockpin signalname="DO_Rdy" name="Do_Rdy" />
            <blockpin signalname="DO(7:0)" name="DO(7:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1808" y="1472" name="XLXI_1" orien="R0">
        </instance>
        <instance x="1200" y="1472" name="XLXI_2" orien="R0">
        </instance>
        <branch name="F0">
            <wire x2="1600" y1="1312" y2="1312" x1="1584" />
            <wire x2="1696" y1="1312" y2="1312" x1="1600" />
            <wire x2="1696" y1="1248" y2="1312" x1="1696" />
            <wire x2="1792" y1="1248" y2="1248" x1="1696" />
            <wire x2="1808" y1="1248" y2="1248" x1="1792" />
        </branch>
        <branch name="DO_Rdy">
            <wire x2="1600" y1="1376" y2="1376" x1="1584" />
            <wire x2="1712" y1="1376" y2="1376" x1="1600" />
            <wire x2="1712" y1="1312" y2="1376" x1="1712" />
            <wire x2="1792" y1="1312" y2="1312" x1="1712" />
            <wire x2="1808" y1="1312" y2="1312" x1="1792" />
        </branch>
        <branch name="DO(7:0)">
            <wire x2="1600" y1="1440" y2="1440" x1="1584" />
            <wire x2="1792" y1="1440" y2="1440" x1="1600" />
            <wire x2="1808" y1="1440" y2="1440" x1="1792" />
        </branch>
        <branch name="Clk_Sys">
            <wire x2="1152" y1="1728" y2="1728" x1="1104" />
            <wire x2="1808" y1="1728" y2="1728" x1="1152" />
            <wire x2="1200" y1="1440" y2="1440" x1="1152" />
            <wire x2="1152" y1="1440" y2="1728" x1="1152" />
            <wire x2="1808" y1="1376" y2="1376" x1="1760" />
            <wire x2="1760" y1="1376" y2="1536" x1="1760" />
            <wire x2="1808" y1="1536" y2="1536" x1="1760" />
            <wire x2="1808" y1="1536" y2="1728" x1="1808" />
        </branch>
        <iomarker fontsize="28" x="1104" y="1728" name="Clk_Sys" orien="R180" />
        <branch name="PS2_Data">
            <wire x2="1184" y1="1344" y2="1344" x1="1168" />
            <wire x2="1200" y1="1344" y2="1344" x1="1184" />
        </branch>
        <iomarker fontsize="28" x="1168" y="1344" name="PS2_Data" orien="R180" />
        <branch name="PS2_Clk">
            <wire x2="1184" y1="1248" y2="1248" x1="1168" />
            <wire x2="1200" y1="1248" y2="1248" x1="1184" />
        </branch>
        <iomarker fontsize="28" x="1168" y="1248" name="PS2_Clk" orien="R180" />
        <branch name="Result(15:0)">
            <wire x2="2208" y1="1248" y2="1248" x1="2192" />
            <wire x2="2224" y1="1248" y2="1248" x1="2208" />
        </branch>
        <iomarker fontsize="28" x="2224" y="1248" name="Result(15:0)" orien="R0" />
    </sheet>
</drawing>