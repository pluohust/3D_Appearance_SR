#!/bin/bash
# explanation of some of the import options used.
# --ext sep_reset: used to reset the dataset (generate .npy files).
# --data_train: used to judge how to test model, namely, whether to use cross validation. For all of the models trained with texture or texture_hr, cross validation should be used. Only testing EDSR do not used cross validation.
# --model_one: used to split the dataset.
# --subset: used to choose from the Subset. Five options: . (means the combination of all of the subsets), ETH3D, MiddleBury, Collection, SyB3R.
# --normal_lr: use hr or lr normal map
# --input_res: HRST_CNN should use the HR input texture map


##########################################################################
# TEST

# NLR, cross-validation used, test for the first split 
CUDA_VISIBLE_DEVICES=xx python ../main.py --model FINETUNE --submodel NLR --save Test/NLR_first --scale 4 --n_resblocks 32 --n_feats 256 --res_scale 0.1 --pre_train ../../experiment/model/NLR/model_x2_split1.pt  --data_train texture --data_test texture --model_one one --subset . --normal_lr lr --input_res lr --chop --reset --save_results --print_model --test_only

# NLR, cross-validation used, test for the second split 
CUDA_VISIBLE_DEVICES=xx python ../main.py --model FINETUNE --submodel NLR --save Test/NLR_second --scale 4 --n_resblocks 32 --n_feats 256 --res_scale 0.1 --pre_train ../../experiment/model/NLR/model_x2_split2.pt  --data_train texture --data_test texture --model_one two --subset . --normal_lr lr --input_res lr --chop --reset --save_results --print_model --test_only

# NHR, cross-validation used, test for the first split 
CUDA_VISIBLE_DEVICES=xx python ../main.py --model FINETUNE --submodel NHR --save Test/NHR_first --scale 4 --n_resblocks 32 --n_feats 256 --res_scale 0.1 --pre_train ../../experiment/model/NHR/model_x2_split1.pt --data_train texture --data_test texture --model_one one --subset . --normal_lr hr --input_res lr --chop --reset --save_results --print_model --test_only

# NHR, cross-validation used, test for the second split 
CUDA_VISIBLE_DEVICES=xx python ../main.py --model FINETUNE --submodel NHR --save Test/NHR_second --scale 4 --n_resblocks 32 --n_feats 256 --res_scale 0.1 --pre_train ../../experiment/model/NHR/model_x2_split2.pt --data_train texture --data_test texture --model_one two --subset . --normal_lr hr --input_res lr --chop --reset --save_results --print_model --test_only

# EDSR
CUDA_VISIBLE_DEVICES=xx python ../main.py --model EDSR --submodel EDSR --save Test/EDSR --scale 4 --n_resblocks 32 --n_feats 256 --res_scale 0.1 --pre_train ../../experiment/model/EDSR_model/EDSR_x4.pt --data_train div2k --data_test texture --chop --reset --save_results --print_model --test_only 

# EDSR_FT, finetune EDSR, cross-validation used, test for the first split
CUDA_VISIBLE_DEVICES=xx python ../main.py --model EDSR --submodel EDSR --save Test/EDSR_FT_first --scale 4 --n_resblocks 32 --n_feats 256 --res_scale 0.1 --pre_train xx --data_train texture --data_test texture --model_one one --subset . --input_res lr --chop --reset --save_results --print_model 


#########################################################################
#Train

# NLR, cross-validation used, train for the first split 
CUDA_VISIBLE_DEVICES=xx python ../main.py --model FINETUNE --submodel NLR --save NLR_first --scale 4 --patch_size 192 --n_resblocks 32 --n_feats 256 --epochs 100 --res_scale 0.1 --print_every 100 --lr 0.0001 --lr_decay 100 --batch_size 8 --pre_train ../../experiment/model/EDSR_model/EDSR_x4.pt --test_every 200 --data_train texture --data_test texture --model_one one --subset . --normal_lr lr --input_res lr --chop --reset --save_results --print_model

# NLR, cross-validation used, train for the second split 
CUDA_VISIBLE_DEVICES=xx python ../main.py --model FINETUNE --submodel NLR --save NLR_second --scale 4 --patch_size 192 --n_resblocks 32 --n_feats 256 --epochs 100 --res_scale 0.1 --print_every 100 --lr 0.0001 --lr_decay 100 --batch_size 8 --pre_train ../../experiment/model/EDSR_model/EDSR_x4.pt --test_every 200 --data_train texture --data_test texture --model_one two --subset . --normal_lr lr --input_res lr --chop --reset --save_results --print_model    

# NHR, cross-validation used, train for the first split
CUDA_VISIBLE_DEVICES=xx python ../main.py --model FINETUNE --submodel NHR --save NHR_first --scale 4 --patch_size 192 --n_resblocks 32 --n_feats 256 --epochs 100 --res_scale 0.1 --print_every 100 --lr 0.0001 --lr_decay 100 --batch_size 8 --pre_train ../../experiment/model/EDSR_model/EDSR_x4.pt --test_every 200 --data_train texture --data_test texture --model_one one --subset . --normal_lr hr --input_res lr --chop --reset --save_results --print_model  

# NHR, cross-validation used, train for the second split
CUDA_VISIBLE_DEVICES=xx python ../main.py --model FINETUNE --submodel NHR --save NHR_second --scale 4 --patch_size 192 --n_resblocks 32 --n_feats 256 --epochs 100 --res_scale 0.1 --print_every 100 --lr 0.0001 --lr_decay 100 --batch_size 8 --pre_train ../../experiment/model/EDSR_model/EDSR_x4.pt --test_every 200 --data_train texture --data_test texture --model_one two --subset . --normal_lr hr --input_res lr --chop --reset --save_results --print_model 

# EDSR-FT, finetune EDSR, cross-validation used, train for the first split
CUDA_VISIBLE_DEVICES=xx python ../main.py --model EDSR --submodel EDSR --save EDSR_FT_first --scale 4 --patch_size 192 --n_resblocks 32 --n_feats 256 --epochs 100 --res_scale 0.1 --print_every 100 --lr 0.0001 --lr_decay 100 --batch_size 8 --pre_train ../../experiment/model/EDSR_model/EDSR_x4.pt --test_every 200 --data_train texture --data_test texture --model_one one --subset . --input_res lr --chop --reset --save_results --print_model  

# EDSR-FT, finetune EDSR, cross-validation used, train for the second split
CUDA_VISIBLE_DEVICES=xx python ../main.py --model EDSR --submodel EDSR --save EDSR_FT_second --scale 4 --patch_size 192 --n_resblocks 32 --n_feats 256 --epochs 100 --res_scale 0.1 --print_every 100 --lr 0.0001 --lr_decay 100 --batch_size 8 --pre_train ../../experiment/model/EDSR_model/EDSR_x4.pt --test_every 200 --data_train texture --data_test texture --model_one two --subset . --input_res lr --chop --reset --save_results --print_model  








