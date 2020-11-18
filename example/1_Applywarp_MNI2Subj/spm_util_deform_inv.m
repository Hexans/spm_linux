function spm_util_deform_inv(input,output,refimg,mat)
%-----------------------------------------------------------------------
% transform ROIs from MNI space to DTI(b0) space
%-----------------------------------------------------------------------

	% sourcepath = strcat(WD,'/',SUB{i});
	% sourcepath = '.';
    % disp(sourcepath);
	% mat = strcat(sourcepath,'/rT1_',SUB{i},'_sn.mat');
   	% refimg = strcat(sourcepath,'/rT1_',SUB{i},'.nii');

	spm('defaults','fmri');
	spm_jobman('initcfg');
	
   	matlabbatch{1}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.matname = {mat};
	matlabbatch{1}.spm.util.defs.comp{1}.inv.space = {refimg};
	matlabbatch{1}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.vox = [NaN NaN NaN];
	matlabbatch{1}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.bb = [NaN NaN NaN
       	                                                      	  NaN NaN NaN];
	matlabbatch{1}.spm.util.defs.ofname = '';
	matlabbatch{1}.spm.util.defs.fnames = {input};
	matlabbatch{1}.spm.util.defs.savedir.saveusr = {output};
	matlabbatch{1}.spm.util.defs.interp = 0;

	spm_jobman('run',matlabbatch)

