drop table if exists main,subMem,subSocket,subCompany,subMhz, subMemType,subKernelName;
drop type if exists streamKer;
create type streamKer as enum('1','2','4','6','8','10','12','16','20','24','32','48','64');
create table subMhz(
	id serial not null primary key,
	basicMhz real null check(basicMhz>0),
	maxMhz real null check(maxMhz>=basicMhz and maxMhz<7)
);
create table subKernelName(
	kernelName_id serial not null primary key,
	kernelName varchar(20) null
);
create table subSocket(
	socket_id serial not null primary key,
	socket varchar(15) null
);
create table subCompany(
	company_id serial not null primary key,
	company varchar(15) null
);
create table subMemType(
	memType_id serial not null primary key,
	memType varchar(10) null
);
create table subMem(
	mem_id serial not null primary key,
	memType_id serial not null references subMemType,
	memChannels int null check(memChannels>=1),
	mhz int null,
	maxCap smallint null
);
create table main(
	id serial not null primary key references subMhz,
	model varchar(35) null,
	socket_id serial not null references subSocket,
	company_id serial not null references subCompany,
	price real null check(price>0),
	kernelName_id serial not null references subKernelName,
	kernels streamKer null,
	streams streamKer null,
	mem_id serial not null references subMem,
	l2 varchar(7) null,
	l3 varchar(7) null,
	tdp smallint null check(tdp>1),
	procTech smallint null check(procTech>=3),
	graphics bool null,
	pciVer real null check(pciVer>=1 and pciVer<=66),
	features text null
);
insert into subSocket(socket_id,socket)
values
	(1, 'AM4'),
	(2, 'LGA 1200'),
	(3, 'LGA 1700');
insert into subCompany(company_id,company)
values
	(1,'AMD'),
	(2,'Intel');
insert into subKernelName(kernelName_id,kernelName)
values
	(1, 'AMD Vermeer'),
	(2, 'Intel Rocket Lake-S'),
	(3, 'Intel Alder Lake-S'),
	(4, 'AMD Cezanne'),
	(5, 'Intel Comet Lake-S'),
	(6, 'AMD Matisse'),
	(7, 'AMD Renoir');
insert into subMemType(memType_id,memType)
values
	(1, 'DDR4'),
	(2, 'DDR5');
insert into subMem(mem_id,memType_id,memChannels,mhz,maxCap)
values
	(1, 1, 2, 3200, 128),
	(2, 2, 2, 4800, 128),
	(3, 1, 2, 2666, 128);
insert into subMhz(id, basicMhz, maxMhz)
values
	(1,3.8,4.7),
	(2,2.6,4.4),
	(3,2.5,4.4),
	(4,3.9,4.4),
	(5,3.7,4.8),
	(6,3.6,5),
	(7,2.9,4.3),
	(8,3.8,4.6),
	(9,3.6,4.3),
	(10,3.7,4.9),
	(11,3.6,4.3),
	(12,3.6,4.2),
	(13,3.6,4.3),
	(14,3.2,5.2),
	(15,3.8,4);
insert into main(id,model,socket_id,company_id,price,kernelName_id,kernels,streams,mem_id,l2,l3,tdp,procTech,graphics,pciVer,features)
values
	(1, 'Ryzen 7 5800X OEM', 1, 1, 20299, 1, '8', '16', 1, '4Mb', '32Mb', 105, 7, false, 4, null),
	(2, 'Core i5-11400F OEM', 2, 2, 10199, 2, '6', '12', 1, '3Mb', '12Mb', 65, 14, false, 4, null),
	(3, 'Core i5-12400F', 3, 2, 12499, 3, '6', '12', 2,  '7.5Mb', '18Mb', 117, 7, false, 5, null),
	(4, 'Ryzen 5 5600G', 1, 1, 12599, 4, '6', '12', 1, '3Mb', '16Mb', 65, 7, true, 3, null),
	(5, 'Ryzen 9 5900X OEM', 1, 1, 28499, 1, '12', '24', 1, '6Mb', '64Mb', 105, 7, false, 4, null),
	(6, 'Core i7-12700KF', 3, 2, 28999, 3, '12', '20', 2, '12Mb', '25Mb', 190, 7, false, 5, 'Intel Optane'),
	(7, 'Core i5-10400F OEM', 2, 2, 9899, 5, '6', '12', 3, '1.5Mb', '12Mb', 65, 14, false, 3, null),
	(8, 'Ryzen 7 5700G OEM', 1, 1, 16799, 4, '8', '16', 1, '4Mb', '16Mb', 65, 7, true, 3, null),
	(9, 'Core i3-10100 OEM', 2, 2, 8199, 5, '4', '8', 3, '1Mb', '6Mb', 65, 14, true, 3, null),
	(10, 'Core i5-12600K BOX', 3, 2, 22999, 3, '10', '16', 2, '9.5Mb', '20Mb', 150, 7, true, 5, null),
	(11, 'Core i3-10100 OEM', 2, 2, 8199, 5, '4', '8', 3, '1Mb', '6Mb', 65, 14, true, 3, null),
	(12, 'Ryzen 5 3600 BOX', 1, 1, 11499, 6, '6', '12', 1, '3Mb', '32Mb', 65, 7, false, 4, null),
	(13, 'Ryzen 5 PRO 4650G OEM', 1, 1, 10999, 7, '6', '12', 1, '3Mb', '8Mb', 65, 7, true, 3, null),
	(14, 'Core i9-12900KF OEM', 3, 2, 41999, 3, '16', '24', 2, '14Mb', '30Mb', 241, 7, false, 5, 'Intel Optane'),
	(15, 'Ryzen 3 PRO 4350G OEM', 1, 1, 8899, 7, '4', '8', 1, '2Mb', '4Mb', 65, 7, true, 3, null);

create index idx_company on main (company_id);
create index idx_procTech on main (procTech);
select * from main;
select * from subMhz;
select * from subSocket;
select * from subCompany;
select * from subKernelName;
select * from subMem;
select * from subMemType;
/*Легкие запросы*/
select * from main where company_id=1;
select model,price from main where graphics=true;
select model,price,kernels,streams from main where kernelName_id=1 and socket_id=1;
select * from main where price<15000 and procTech<14 and kernels = '4';
/*Средние запросы*/
select model,price,company from main inner join subCompany on subCompany.company_id = main.company_id where price>10000 and kernels='8';
select model, basicMhz,maxMhz from main left join subMhz on subMhz.id = main.id where subMhz.basicMhz>3.2 and graphics=false;
select company,model,price,basicMhz,maxMhz from main inner join subCompany on subCompany.company_id=main.company_id inner join subMhz on subMhz.id=main.id inner join subMem on subMem.mem_id=main.mem_id where graphics=true and price<20000 and mhz>=3200;
/*Сложный запрос*/
select model, price, kernels,streams,memType,memChannels,mhz,basicMhz,maxMhz from main inner join subMem on main.mem_id=subMem.mem_id inner join subMemType on subMem.memType_id=subMemType.memType_id inner join subMhz on subMhz.id=main.id where subMem.mhz>=3200 and procTech=7 and (cast(cast(kernels as text) as int)>=6)and (cast(cast(streams as text) as int)=(cast(cast(kernels as text) as int))*2) order by price desc, kernels desc,basicMhz desc, maxMhz desc;
select company,model,(cast(cast(kernels as text) as int)*((basicMhz+maxMhz)/2)) as effCoeff,price,kernelName,socket,kernels,streams,l2,l3,pciVer from main inner join subMhz on subMhz.id=main.id inner join subSocket on subSocket.socket_id=main.socket_id inner join subCompany on subCompany.company_id=main.company_id inner join subKernelName on subKernelName.kernelName_id=main.kernelName_id where procTech=7 and (basicMhz>3 or cast(cast(kernels as text) as int)>=12) and graphics=false order by effCoeff desc,model;
select company, avg(price) as avgPrice, array_agg(distinct kernels) as posKern from main inner join subCompany on subCompany.company_id=main.company_id group by company order by posKern desc;



select socket,sum(cast( trim(both 'Mb'from cast(l2 as text)) as real)) as l2, sum(cast( trim(both 'Mb'from cast(l3 as text)) as real)) as l3 from main inner join subSocket on subSocket.socket_id=main.socket_id group by socket;

написать запрос сокет кэш
/*pg_dump -U postgres processors>processors_dump.sql*/