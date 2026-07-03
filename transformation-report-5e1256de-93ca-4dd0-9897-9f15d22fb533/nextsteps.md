# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a current and supported .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows, such as browsing products, adding items to a cart, and completing any checkout flows, to confirm runtime behavior is correct.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review any failing tests and address them before proceeding. If no tests exist, consider writing basic integration or unit tests to cover critical paths.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in modern .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These do not exist in cross-platform .NET. Verify that any HTTP context, session, or membership-related code has been replaced with the ASP.NET Core equivalents.
- **Entity Framework**: If the project uses Entity Framework 6, confirm whether it has been migrated to Entity Framework Core, as EF6 has limited support on cross-platform .NET.
- **Configuration**: Ensure `Web.config` or `App.config` based configuration has been replaced with `appsettings.json` and the `Microsoft.Extensions.Configuration` system.
- **Authentication/Authorization**: Verify that any `FormsAuthentication` or older membership providers have been replaced with ASP.NET Core Identity or cookie authentication middleware.

### 7. Review Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been moved to the `wwwroot` folder, which is the expected location for static files in ASP.NET Core.

### 8. Validate Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` is correct and that the application can connect and perform basic read/write operations at runtime.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present.

### 10. Deploy

Copy the published output to your target hosting environment. If hosting on IIS, ensure the **ASP.NET Core Hosting Bundle** is installed on the server and that the application pool is configured to use **No Managed Code**, as ASP.NET Core runs out-of-process by default.

If deploying to a Linux host, confirm the target runtime is specified during publish if a self-contained deployment is needed:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained true --output ./publish
```