# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET Support Policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows to check for any runtime errors that would not surface at compile time.

### 5. Run Existing Tests

If the solution contains a test project, run all tests to verify functional correctness:

```bash
dotnet test
```

Review any failing tests and address them before proceeding further.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **File system paths**: Ensure no hardcoded backslash (`\`) path separators exist. Use `Path.Combine` instead.
- **Registry access**: `Microsoft.Win32.Registry` is not supported on Linux or macOS.
- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm all such usages have been replaced, typically with ASP.NET Core equivalents.
- **`HttpContext` and session handling**: Verify these have been migrated to the ASP.NET Core model.
- **Configuration**: Confirm `Web.config` based configuration has been replaced with `appsettings.json` and the `Microsoft.Extensions.Configuration` stack.

### 7. Review Static Files and Middleware

If this is a web project, confirm that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs` using the ASP.NET Core pipeline.

### 8. Database Connectivity

If the project uses a database, verify the connection string in `appsettings.json` is correct for the target environment and that any Entity Framework migrations are up to date:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all expected files are present, including static assets and configuration files.