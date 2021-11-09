"aws_iam_role_policy_attachment.7shifts": {
		"type": "aws_iam_role_policy_attachment",
		"depends_on": [
				"aws_iam_role.app",
				"data.aws_iam_policy.7shifts"
		],
		"primary": {
			...
		},
		"deposed": [],
		"provider": "provider.aws"
},
"aws_iam_role_policy_attachment.7shifts_celery": {
		"type": "aws_iam_role_policy_attachment",
		"depends_on": [
				"aws_iam_role.celery",
				"data.aws_iam_policy.7shifts"
		],
		"primary": {
			...
		},
		"deposed": [],
		"provider": "provider.aws"
},
