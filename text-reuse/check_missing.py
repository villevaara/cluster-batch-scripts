import os


def get_filelist(results_path):
    files = os.listdir(results_path)
    return files


def get_file_indices(filelist):
    iter_indices = []
    for file in filelist:
        iter_n = file.split("iter_")[-1].split(".")[0]
        iter_indices.append(int(iter_n))
    return iter_indices


respath = "/scratch/project_2000230/txt_reuse/results_qpi100/"
files = get_filelist(respath)
processed_indices = set(get_file_indices(files))
all_indices = set(range(0, 13023))
missing_indices = []
for item in all_indices:
    if item not in processed_indices:
        missing_indices.append(item)

missing_indices = set(missing_indices)

this_missing = []
for index in range(0, 13023):
    if index in missing_indices:
        this_missing.append(index)
    if index not in missing_indices and len(this_missing) > 0:
        print(str(min(this_missing)) + "-" + str(max(this_missing)))
        this_missing = []

if len(this_missing) > 0:
    print(str(min(this_missing)) + "-" + str(max(this_missing)))
