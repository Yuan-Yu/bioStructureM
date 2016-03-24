testpath = 'C:\googleDrive\labwork\mathlab\Useful_fuc';
disp('CORE TEST :');
%%%%%% test 1 
addpath([testpath '/core']);
try
    tic;
    testPDB = readPDB('FGF2_phaser_P212121-coot-12.pdb');
    time = toc;
catch e
    disp('test 1');
    rethrow(e);
end

if length(testPDB) ~= 2160
    error('test1 failed.');
else
    disp(['test 1 pass. (elapsed time is ' num2str(time) ' seconds)'])
end
clear testPDB time;
%%%%%%% test 2 for NMR
try
    tic;
    testPDBcell = readPDB('2n2a.pdb',0,'NMR');
    time = toc;
catch e
    disp('test 2');
    rethrow(e);
end
if length(testPDBcell) ~= 10 || length(testPDBcell{1}) ~= 1940
    error('test2 failed.');
else
    disp(['test 2 pass. (elapsed time is ' num2str(time) ' seconds)'])
end
clear testPDBcell time;
%%%%%% test 3 for alternate
i =3;
try
    tic;
    testPDB = readPDB('FGF2_phaser_P212121-coot-12.pdb',0,'x-ray',0,{' ','A','B'});
    time = toc;
catch e
    disp(['test ' num2str(i) ]);
    rethrow(e);
end

if length(testPDB) ~= 2171
    error(['test ' num2str(i) ' failed.']);
else
    disp(['test ' num2str(i) ' pass. (elapsed time is ' num2str(time) ' seconds)'])
end
clear testPDBcell time;

%%%%%% test 4 
i =4;
try
    cd ([testpath '/test']);
    tic;
    testPDB = readPDB('FGF2_dimer31_p_bridged_solvated.pdb',0,'x-ray',0,{' ','A','B'});
    time = toc;
catch e
    disp(['test ' num2str(i) ]);
    rethrow(e);
end

if length(testPDB) ~= 265647
    error(['test ' num2str(i) ' failed.']);
else
    disp(['test ' num2str(i) ' pass. (elapsed time is ' num2str(time) ' seconds)'])
end
clear testPDB time;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('ACCELECTOR TEST : ')
cd ([testpath '/accelerator']);
try
    mex('atomfrompdb.cpp');
    addpath([testpath '/accelerator'])
catch e
    cd ([testpath '/test']);
    disp(['test ' num2str(i) ]);
    rethrow(e);
end
cd ([testpath '/test']);
%%%%%% test 1 for accelector
i = 1;
try
    cd ([testpath '/test']);
    tic;
    testPDB = readPDB('FGF2_phaser_P212121-coot-12.pdb');
    time = toc;
catch e
    disp(['test ' num2str(i) ]);
    rethrow(e);
end

if length(testPDB) ~= 2160
    error(['test ' num2str(i) ' failed.']);
else
    disp(['test ' num2str(i) ' pass. (elapsed time is ' num2str(time) ' seconds)'])
end
clear testPDBcell time;

%%%%%% test 2 for accelector
i = 2;
try
    tic;
    testPDBcell = readPDB('2n2a.pdb',0,'NMR');
    time = toc;
catch e
    disp(['test ' num2str(i) ]);
    rethrow(e);
end

if length(testPDBcell) ~= 10 || length(testPDBcell{1}) ~= 1940
    error(['test ' num2str(i) ' failed.']);
else
    disp(['test ' num2str(i) ' pass. (elapsed time is ' num2str(time) ' seconds)'])
end
clear testPDBcell time;

%%%%%% test 3 for alternate
i = 3;
try
    tic;
    testPDB = readPDB('FGF2_phaser_P212121-coot-12.pdb',0,'x-ray',0,{' ','A','B'});
    time = toc;
catch e
    disp(['test ' num2str(i) ]);
    rethrow(e);
end

if length(testPDB) ~= 2171
    error(['test ' num2str(i) ' failed.']);
else
    disp(['test ' num2str(i) ' pass. (elapsed time is ' num2str(time) ' seconds)'])
end
clear testPDB time;

%%%%%% test 4 
i =4;
try
    cd ([testpath '/test']);
    tic;
    testPDB = readPDB('FGF2_dimer31_p_bridged_solvated.pdb',0,'x-ray',0,{' ','A','B'});
    time = toc;
catch e
    disp(['test ' num2str(i) ]);
    rethrow(e);
end

if length(testPDB) ~= 265647
    error(['test ' num2str(i) ' failed.']);
else
    disp(['test ' num2str(i) ' pass. (elapsed time is ' num2str(time) ' seconds)'])
end
clear testPDB time;